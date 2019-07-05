for awr_lst in $(ls *.lst); do
        grep -n "SQL ordered" $awr_lst | awk -F: '{print $1,$2}'| awk -FDB '{print $1}' > kk
        sed -ri "s|SQL ordered by | |" kk
        awk '$2>max[$3]{max[$3]=$2; row[$3]=$0} END{for (i in row) print row[i]}' kk  | sort -k1 -n > kk_dos
        awk '{print NR+1 " " $1 " " $3}' kk_dos > borra_1
        awk '{print NR " " $1}' kk_dos > borra_2
        join borra_1 borra_2 > fichero.txt
        echo | awk -v r=$awr_lst '{print "sed -n -e \047"  $2 "," $4 "p\047 "  r " > " $3 "_" r "_SQL.txt" }' fichero.txt >> ex_sed.txt
        # ejecución del SED
        sh ex_sed.txt
        rm -f kk borra_ kk_dos borra_1 borra_2 fichero.txt ex_sed.txt

        # 7 columnas
        for aux_fil in $(ls *$awr_lst*SQL.txt); do
        my_array_1=(Executions_ Elapsed_ Physical_)
        for i in "${my_array_1[@]}"
         do
         if [[ $aux_fil == *"$i"* ]]
          then
          awk 'length($7)==13' $aux_fil | awk --posix '{ if ($1 ~ /^[0-9]/) print $0}' >  $i$awr_lst.temp
         fi
         done
        done

        # 4 columnas
        for aux_fil in $(ls *$awr_lst*SQL.txt); do
        my_array_2=(Sharable_ Parse_)
        for i in "${my_array_2[@]}"
         do
         if [[ $aux_fil == *"$i"* ]]
          then
          awk 'length($4)==13' $aux_fil | awk --posix '{ if ($1 ~ /^[0-9]/) print $0}' >  $i$awr_lst.temp
         fi
         done
        done

        # 8 columnas
        for aux_fil in $(ls *$awr_lst*SQL.txt); do
        my_array_3=(User_ Reads_ Gets_ CPU_)
        for i in "${my_array_3[@]}"
         do
         if [[ $aux_fil == *"$i"* ]]
          then
          awk 'length($8)==13' $aux_fil | awk --posix '{ if ($1 ~ /^[0-9]/) print $0}' > $i$awr_lst.temp
         fi
         done
        done

        rm -f *.lst_SQL.txt

        for t_fil in $(ls *.lst.temp); do awk -v r=$awr_lst '{print r  $0 }' $t_fil > $t_fil.csv ; done

        rm -f *.lst.temp
done

for full_fil in $(ls Executions_*.temp.csv); do cat $full_fil >> Executions.csv ; done
for full_fil in $(ls Elapsed_*.temp.csv); do cat $full_fil >> Elapsed.csv ; done
for full_fil in $(ls Physical_*.temp.csv); do cat $full_fil >> Physical.csv ; done
for full_fil in $(ls Sharable_*.temp.csv); do cat $full_fil >> Sharable.csv ; done
for full_fil in $(ls Parse_*.temp.csv); do cat $full_fil >> Parse.csv ; done
for full_fil in $(ls User_*.temp.csv); do cat $full_fil >> User.csv ; done
for full_fil in $(ls Reads_*.temp.csv); do cat $full_fil >> Reads.csv ; done
for full_fil in $(ls Gets_*.temp.csv); do cat $full_fil >> Gets.csv ; done
for full_fil in $(ls CPU_*.temp.csv); do cat $full_fil >> CPU.csv ; done

rm -f *.temp.csv


# El formateo final

# 7 columnas
# Executions_$awr_lst.temp.csv
# Elapsed_$awr_lst.temp.csv
# Physical_$awr_lst.temp.csv

sed  -i '1i Filename     Executions   Rows_Processed  Rows_per_Exec   Elapsed_Time_(s)  %CPU   %IO    SQL_Id' Executions.csv
sed  -i '1i Filename     Elapsed_Time_(s)    Executions  Elapsed_Time_per_Exec_(s)  %Total   %CPU    %IO    SQL_Id' Elapsed.csv
sed  -i '1i Filename     UnOptimized_Read_Reqs   Physical_Read_Reqs Executions Reqs_per_Exe   %Opt %Total    SQL_Id' Physical.csv

# 4 columnas
# Sharable_$awr_lst.temp.csv
# Parse_$awr_lst.temp.csv

sed  -i '1i Filename     Parse_Calls        Executions      %_Total_Parses SQL_Id' Parse.csv
sed  -i '1i Filename     Sharable_Mem_(b)  Executions   %_Total    SQL_Id' Sharable.csv

# 8 columnas
# User_$awr_lst.temp.csv
# Reads_$awr_lst.temp.csv
# Gets_$awr_lst.temp.csv
# CPU_$awr_lst.temp.csv

sed  -i '1i Filename     CPU_Time_(s)  Executions    CPU_per_Exec_(s) %Total   Elapsed_Time_(s)   %CPU    %IO    SQL_Id' CPU.csv
sed  -i '1i Filename     Buffer_Gets   Executions   Gets_per_Exec   %Total   Elapsed_Time_(s)  %CPU   %IO    SQL_Id' Gets.csv
sed  -i '1i Filename     Physical_Reads  Executions Reads_per_Exec   %Total   Elapsed_Time_(s)   %CPU    %IO    SQL_Id' Reads.csv
sed  -i '1i Filename     User_I/O_Time_(s)  Executions    UIO_per_Exec_(s) %Total   Elapsed_Time_(s)   %CPU    %IO    SQL_Id' User.csv

