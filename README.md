# To modify and compile:

## 1. Clone this repo

```
git clone https://github.com/Fisheory/DeepDendrite_Documentation.git
```

## 2. Use docker to compile

Make sure your docker service is enabled.

i. Pull python:3.9-slim

```
docker pull python:3.9-slim
```

ii. Build image

```
docker build -t deepdendritedoc .
```

iii. Compile by running docker image

```
docker run -it --rm -v .:/app deepdendritedoc
```

## Then you can preview the documentation page locally by checking HTML pages in docs/build/html.