# MAS-Bench

## Requirements
- OpenJDK 11

## Requirements for sample-code
- python3.8 (3.8.3)
- numpy 1.19.4
- scipy 1.5.4
- pandas 1.1.4

```
pip install numpy
pip install scipy
pip install pandas
```

## How to run sample-code
```
wget [masbench-sample.tar.gz url]
tar xf masbench-sample.tar.gz
cd masbench-sample
sh main.sh
```
or
```
git clone https://github.com/MAS-Bench/MAS-Bench.git
cd MAS-Bench
sh ./release-archive-build.sh
cd masbench-sample
sh main.sh
```

## MAS-Bench commands
- `java -jar MAS-Bench-all.jar init`
- `java -jar MAS-Bench-all.jar <Model name> <Working dir> <Parameter CSV file>`

### Model name
- FS1-1
- FS1-2
- FS1-3
- FS1-4
- FL1-1
- FL1-2
- FL1-3
- FL1-4

### Parameter CSV file format

### Output file format
