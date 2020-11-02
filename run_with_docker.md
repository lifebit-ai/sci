# Run sci with Docker

## Create the docker container

```bash
git clone https://github.com/TheJacksonLaboratory/sci
cd sci
docker build -t sci:latest .
```

## Run

### Prepare input file with juicer

Supposing your data is in current working directory.

```bash
docker run -v $PWD:$PWD -w $PWD -it sci:latest hic2sci.sh <input .hic file> <output file> <resolution> 
```

### Run sci

Test run 

```bash
docker run -v $PWD:$PWD -w $PWD -it sci:latest python2 -m sci -n test -f Input_sample/SCI_input.txt -r 100000 -g chromosome_sizes/hg19.chrom.sizes -o both -s 1 -k 5
```