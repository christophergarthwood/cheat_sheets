#!/usr/bin/bash

#sudo apt install imagemagick
export cmd_convert="/usr/bin/convert";

img_extensions=( JPEG JPG TIFF TIF PNG )
export target_extension="gif"

for ext in ${img_extensions[@]}
do
    actual_ext=$( echo ${ext} | tr '[:upper:]' '[:lower:]' )
    echo "Processing extension ending with ${actual_ext}";
    file_array=( $(find ./ -name "*.${actual_ext}" -print )  )
    for file in ${file_array[@]}
    do
        echo "......processing ${file}";
        export just_the_dirname=$(dirname ${file});
        export just_the_filename=$(basename ${file});
        export just_the_filename="${just_the_filename%.*}";
        echo ".........${cmd_convert} ${file} -flatten ${just_the_dirname}/${just_the_filename}.${target_extension}";
        ${cmd_convert} "${file}" -flatten "${just_the_dirname}/${just_the_filename}.${target_extension}";
        status=$?
        if [ ${status} -ne 0 ];
        then
            echo "WARNING: convert on ${file} resulted in failure with status code of: ${status}";
        fi
    done
done
