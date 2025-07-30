#!/usr/bin/bash

#sudo apt install imagemagick
export cmd_convert="/usr/bin/convert";
export cmd_python="/usr/bin/python";
export the_script="convert_pdf.py";
export extensions=( PDF pdf )

for ext in ${extensions[@]}
do
    file_array=( $(find ./ -name "*.${ext}" -print) )
    for file in ${file_array[@]}
    do
        echo "......processing ${file}";
        export just_the_dirname=$(dirname ${file});
        export just_the_filename=$(basename ${file});
        export just_the_filename="${just_the_filename%.*}";
        echo ".........${cmd_python} ${the_script} ${file}";
        ${cmd_python} ${the_script} ${file};
        status=$?
        if [ ${status} -ne 0 ];
        then
            echo "WARNING: Python PDF conversion on ${file} resulted in failure with status code of: ${status}";
        fi
    done
done
