# For splitting RELLIS-3D datset into trainset based on split

# Please replace the placeholders {...} with the relevant paths or information

echo "Start splitting for train set"

CNT=0
# a file path containing the origianl split file (Ouster LiDAR Split File)
SPLIT_FILE_PATH="{...}/pt_train.lst"

# a file path contatining the original datasets 
RAW_PATH='{...}'

# a file path where the splitted veldynes of trainset will be saved 
VEL_SAVE_PATH='{...}/00/velodyne'

# a file path where the splitted labels of trainset will be saved 
ID_SAVE_PATH='{...}/00/labels'


while read bin id;      # Read a line of the split file
# Trainset split
do

    #bin_out="$(basename $bin)"
    #id_out="$(basename $id)"

    TEMP="000000$CNT"

    echo ${TEMP:(-6)}



    cp "${RAW_PATH}""/""${bin}" "${VEL_SAVE_PATH}""/""${TEMP:(-6)}"".bin"
    cp "${RAW_PATH}""/""${id}" "${ID_SAVE_PATH}""/""${TEMP:(-6)}"".label"
        

    CNT=$(( $CNT + 1 ))
    
done < "${SPLIT_FILE_PATH}"

echo "Finished"
