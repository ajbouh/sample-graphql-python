To get started with nix

```
$ nix-shell
$ yarn
$ poetry install

# Create an up to date requirements.txt (if needed)
$ poetry export --format=requirements.txt > requirements.txt
```

To run tests and deploy to now:

```
$ (
  DST=build/$(date +"%F_%s"); 
  docker build -t python2jupyter . && \
  docker run --rm -v $PWD:/export python2jupyter \
  cp lambda.zip /export/$DST.zip && \
  mkdir $DST && \
  unzip $DST.zip -d $DST && \
  cd $DST && now
)
```
