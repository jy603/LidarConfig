# For splitting RELLIS-3D datset into validset based on split

# Please replace the placeholders {...} with the relevant paths or information

echo "Start splitting for valid set"

CNT=0
# a file path containing the origianl split file 
SPLIT_FILE_PATH="{...}/pt_val.lst"

# a file path contatining the original datasets 
RAW_PATH='{...}'
# a file path where the splitted veldynes of validset will be saved 
VEL_SAVE_PATH='{...}/01/velodyne'
# a file path where the splitted labels of validset will be saved 
ID_SAVE_PATH='{...}/01/labels'


while read bin id;      # Read a line of the split file
# Validset split
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
