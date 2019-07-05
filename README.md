# awr-sql-parser
a bash script to output CSV format files with information about SQL perfomance on Oracle database. It takes input AWR txt format reports. 

A tool that try to complete [awr-parser.sh](https://flashdba.com/database/useful-scripts/awr-parser/) bash script


## Purpose

The script [awr-sql-parser.sh](https://github.com/benitoelespinoso/awr-sql-parser) is a complement to the awr-parser.sh, which is a very useful tool when it comes to graphing the performance of an Oracle DB.

The script takes input from the AWR txt reports and generates a CSV with the information related to the SQL sections of said AWR reports.


## Usage

If the AWR reports (in ASCII text) are the directory along with the script, for example:

```
oracle@hv-sv-000439 BDP20 $ ls
awr_20190625_07_00_01.lst  awr_20190625_08_00_06.lst  awr_20190625_09_00_29.lst  awr-sql-parser.sh
awr_20190625_07_30_05.lst  awr_20190625_08_30_07.lst  awr_20190625_09_30_36.lst

oracle@hv-sv-000439 BDP20 $ ./awr-sql-parser.sh

oracle@hv-sv-000439 BDP20 $ ls
awr_20190625_07_00_01.lst  awr_20190625_08_30_07.lst  awr-sql-parser.sh  Executions.csv  Physical.csv  User.csv
awr_20190625_07_30_05.lst  awr_20190625_09_00_29.lst  CPU.csv            Gets.csv        Reads.csv
awr_20190625_08_00_06.lst  awr_20190625_09_30_36.lst  Elapsed.csv        Parse.csv       Sharable.csv

oracle@hv-sv-000439 BDP20 $ more Executions.csv
Filename         Executions   Rows_Processed  Rows_per_Exec   Elapsed_Time_(s)  %CPU   %IO    SQL_Id
awr_20190625_07_00_01.lst     327,855         327,778            1.0       20.8    98     0 ftj9uawt4wwzb
awr_20190625_07_00_01.lst     235,742         235,761            1.0       85.3   100     0 1r05j5qbcyw00
awr_20190625_07_00_01.lst      41,752          40,782            1.0       32.7    98     0 9axfuzk0g2apf
awr_20190625_07_00_01.lst      40,029               0            0.0       11.0 102,1     0 6qdzaxcv71vh8
awr_20190625_07_00_01.lst      31,204             496            0.0        2.6 105,7     0 2syvqzbxp4k9z
awr_20190625_07_00_01.lst      29,205               0            0.0        1.9  98,9     0 2xyb5d6xg9srh
awr_20190625_07_00_01.lst      28,969          28,772            1.0      118.3 100,7     0 abg8qvx6m4ypd
awr_20190625_07_00_01.lst      25,371          42,190            1.7      281.5   100     0 02kkxuxhyv8mx
awr_20190625_07_00_01.lst      23,449          23,454            1.0        1.2   105     0 3w54wsybgw0sc
awr_20190625_07_00_01.lst      20,313       1,374,280           67.7      157.0  99,8     0 dwynqd12njkdh
awr_20190625_07_00_01.lst      17,060          16,503            1.0       73.3 100,8     0 4q384fxx73dv4
awr_20190625_07_30_05.lst     274,148         274,110            1.0       17.6  96,6     0 ftj9uawt4wwzb
awr_20190625_07_30_05.lst     233,841         233,840            1.0      276.9   100     0 46h0tywxxt40q
awr_20190625_07_30_05.lst     229,595         229,608            1.0       82.3 101,7     0 1r05j5qbcyw00
awr_20190625_07_30_05.lst      38,153          36,402            1.0       29.2  99,3     0 9axfuzk0g2apf
awr_20190625_07_30_05.lst      27,253          44,829            1.6      299.6  99,9     0 02kkxuxhyv8mx
awr_20190625_07_30_05.lst      23,349          92,664            4.0        3.9 101,3     0 4aanvw5nv9s2c
awr_20190625_07_30_05.lst      23,336       1,570,732           67.3      181.2  99,9     0 dwynqd12njkdh
awr_20190625_07_30_05.lst      22,621             788            0.0        2.1  98,9     0 2syvqzbxp4k9z
awr_20190625_07_30_05.lst      20,202               0            0.0        1.3 110,5     0 2xyb5d6xg9srh
..........................

```
