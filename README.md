# Analysis of LiDAR Configurations on Off-road Semantic Segmentation Performance


This repository is the official implementation of [Analysis of LiDAR Configurations on Off-road Semantic Segmentation Performance](https://will-be-added-later).

---
## Environment Setup

We recommend creating a new virtual environment for running the code using either Anaconda or Mamba.

- **Anaconda**
```setup
conda env create -f LidarConfig.yml
``` 
- **Mamba**
```setup
mamba env create --file LidarConfig.yml
```
---
## Dataset Preparation

### **Simulated Dataset [MAVS]**

To generate the simulated datasets, the MSU Autonomous Vehicle Simulator (MAVS) is needed.

1. Request access to MAVS via this link: https://www.cavs.msstate.edu/capabilities/mavs_request.php, and download it.

2. Patch the MAVS code using the patch file "mavs.patch" in the root directory of this repository. 
```bash
git apply mavs.patch
```
3. Copy the "SPIE-vlp 16" directory, which contains json sensor files, to {your_mavs_path}/mavs/data/sensors/lidar

4. Build with the modified code. The instruction for building MAVS can be found here: https://mavs-documentation.readthedocs.io/en/latest/MavsBuildInstructions/.

5. Unzip "files.zip" in the simulated_datasets/scene_files_zip directory using the following command:

```bash
# cd ./LidarConfig/simulated_datasets/scene_files_zip
zip -FF scene_files.zip --out scene_files_ff.zip
unzip -FF scene_files_ff.zip
mv scene_files ../scene_files
```

6. In every mavs_scene{scene_number}_scene.json file, change the path of "PathToMeshes" and "Layers" according to your path to the mavs directory. For example, if your path to the mavs directory is /home/user/mavs, then the path of "PathToMeshes" and "Layers" should be "/home/user/mavs/data/scenes/meshes/" and "/home/user/mavs/data/scenes/meshes/surface_textures/meadow_surfaces.json", respectively.

7. To create the simulated dataset used in this paper, navigate to each sequence folder within the simulated_datasets directory and run my_lidar_trainer.ipynb files for each scene; make sure to replace {your mavs path} in the line sys.path.append(r'{your mavs path}/src/mavs_python/') with your actual path to MAVS. Once you've generated the all datasets, the final file structure should look like this:
```text
./
└── simulated_datasets
    ├──   Original VLP-16
    |      └── original
    |          └── sequences
    |          ├── 00 # for validation
    |          │   ├── labels
    |          │   |   ├── 000000.label
    |          │   |   ├── 000001.label
    |          │   |   └── ...
    |          │   ├── meta_data
    |          │   │   ├── analysis.txt
    |          │   │   └── Seq.00 Number of Points Visualization.png
    |          │   ├── pcd_velodyne
    |          │   │   ├── 000000.pcd
    |          │   │   ├── 000001.pcd
    |          │   │   └── ...
    |          │   ├── raw
    │          │   │   ├── bmp
    │          │   │   │   ├── 0000.bmp
    │          │   │   │   ├── 0001.bmp
    │          │   │   │   └── ...
    │          │   │   ├── labeledpcd
    │          │   │   │   ├── labeled_lidar0000.pcd
    │          │   │   │   ├── labeled_lidar0001.pcd
    │          │   │   │   └── ...
    |          |   |   ├── labeled_lidar000000_16.npy
    │          │   │   ├── labeled_lidar000000.txt
    │          │   │   ├── labeled_lidar000001_16.npy
    │          │   │   ├── labeled_lidar000001.txt
    │          │   │   ├── ...
    │          │   │   ├── mavs_scene00_path.vprp
    │          │   │   ├── mavs_scene00_surface.mtl
    │          │   │   ├── mavs_scene00_surface.obj
    │          │   │   ├── my_lidar_trainer.ipynb
    │          │   │   └── potholes_mavs_scene00.txt
    │          │   └── velodyne
    │          │       ├── 000000.bin
    │          │       ├── 000001.bin
    │          │       └── ...
    │          ├── 01 # for testing
    │          ├── 02 # for training
    │          └── 11 # for testing: different ecosystem
    │              └── ...
    ├── scene_files
    │   ├── 00
    │   │   ├── mavs_scene00_scene.json
    │   │   └── mavs_scene00_surface.obj
    │   ├── 01
    │   │   ├── mavs_scene01_scene.json
    │   │   └── mavs_scene01_surface.obj
    │   ├── 02
    │   │   ├── mavs_scene02_scene.json
    │   │   └── mavs_scene02_surface.obj
    │   └── 11
    │       ├── mavs_scene11_scene.json
    │       └── mavs_scene11_surface.obj
    ├── scene_files_zip
    │   ├── scene_files.z01
    │   ├── scene_files.z02
    │   ├── ...
    │   ├── scene_files.z14
    │   └── scene_files.zip
    ├── VLP-16--diff-Hres
    │   ├── 0.1     
    │   └── 0.4
    ├── VLP-16-diff-pos
    │   ├── down
    │   ├── left s
    │   ├── right
    │   └── up
    ├── VLP-16-diff-Range
    │   ├── 150m
    │   └── 200m
    ├── VLP-16-diff-Vres
    │   ├── 32
    │   └── 64
    └── VLP-16-FOV
        ├── [-10,20]
        └── [-20,10]
            └── ...
```

### **Off-road Datasets [RELLIS-3D]**

1. Download the following files from [here](https://github.com/unmannedlab/RELLIS-3D):
- Ouster LiDAR SemanticKITTI Format
- Ouster LiDAR Annotation SemanticKITTI Format 
- Velodyne LiDAR SemanticKITTI Format
- Velodyne LiDAR Annotation SemanticKITTI Format
- Ouster LiDAR Split File

2. Split the datasets into training(00), validation(01), and test(02) by running bash files in the "utils" directory. You should change the paths in the bash files according to your directory structure. The final file structure should look like this:
```text
./
├── 
└── path_to_data_shown_in_config/
    ├── 00 # for training
    │   ├── labels
    │   │   ├── 000000.label
    │   │   ├── 000001.label
    │   │   └── ...
    │   └── velodyne
    │       ├── 000000.bin
    │       ├── 000001.bin
    │       └── ...
    ├── 01 # for validation
    └── 02 # for testing
        └── ...
```
---
## Training & Evaluation

The Jupyter notebook named "(SPIE DCS23) experiments.ipynb" includes the code for training and evaluating the Cylinder3D model on both the simulated and RELLIS-3D datasets.

---
## Acknowledgment

Our code is based on the following repositories:
- [MAVS](https://gitlab.com/cgoodin/msu-autonomous-vehicle-simulator)
- [Cylinder3D](https://github.com/xinge008/Cylinder3D)
- [RELLIS-3D](https://github.com/unmannedlab/RELLIS-3D)

---
## Citing Our Work
We appreciate your support! If you find our code helpful in your research or work, please consider citing our paper.
