# To read the doc

Please visit:https://deepdendrite.readthedocs.io/

# To modify and compile:

## 1. Clone this repo

```
git clone https://github.com/DeepDendrite/DeepDendriteDocument.git
cd DeepDendriteDocument
```

## 2. Use docker to compile

Make sure your docker service is enabled.

i. Build docker image

```
docker build -t deepdendritedoc .
```

iii. Compile by running docker image

```
./make_in_docker.sh html
```

Then you can preview the documentation page locally by checking HTML pages in docs/build/html.

If you have modified the files and want to push it to the remote repo, please create a new branch with a name of version. Before pushing, change the version to your branch name in docs/source/conf.py.
