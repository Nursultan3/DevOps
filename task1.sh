SOURCE_CSV="$1"
TARGET_CSV=$(echo $SOURCE_CSV | awk -F '.' {'print$1'} | sed 's/$/_new.csv/')

while read line col1 col2 col3 col4 col5 col6

do
    unset col3_new

    if [ "$col1" == id ]; then
        echo "${col1},${col2},${col3},${col4},${col5},${col6}"
        continue
    fi

    for n in $col3; do
        if [ -z "$col3_new" ]
        then
            col3_new=${n^}
            col5_new=$(echo $col3 | awk '{print $0,tolower(substr($1,1,1)$NF)}' | awk {'print$3'} | sed 's/$/@abc.com/')
        else
            col3_new+=" ${n^}"
        fi
    done 

    echo "${col1},${col2},${col3_new},${col4},${col5_new},${col6}"

done < $SOURCE_CSV > $TARGET_CSV
