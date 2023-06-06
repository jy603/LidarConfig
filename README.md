# Analysis of LiDAR Configurations on Off-road Semantic Segmentation Performance

This repository is the official implementation of [Analysis of LiDAR Configurations on Off-road Semantic Segmentation Performance](will be added later).

## Folder Structure

## 📋 Requirements

### Enviornment setup

- pip
```setup
pip install -r requirements.txt
```
- conda
```setup
conda install --file requirements.txt
``` 
### Dataset Preperation
#### Simulated Dataset
> To generate the simulated datasets you need MSU Autonomous Vehicle Simulator (MAVS). 

1. Request access to MAVS from this [link](https://www.cavs.msstate.edu/capabilities/mavs_request.php), and dowload it.

2. Copy .json sensor files in the simulated_sensor directory to mavs/data/sensors/lidar
  
3. Build. The instruction for building MAVS can be found in [here](https://mavs-documentation.readthedocs.io/en/latest/MavsBuildInstructions/).

#### Off-road Datasets
You can download REELIS-3D dataset on their GitHub page: [RELLIS-3D](https://github.com/unmannedlab/RELLIS-3D)

## Training

To train the Cylinder3D model, run this command:

```train
python train.py --input-data <path_to_data> --alpha 10 --beta 20
```

## Evaluation

To evaluate the model, run:

```eval
python eval.py --model-file mymodel.pth --benchmark imagenet
```

## Contributing

>📋  Pick a licence and describe how to contribute to your code repository. 
