# Hardware optimized ICA

Speed (10 channels, 10000 sampling points): default binica 38% slower than optimized  
Speed (64 channels, 10000 sampling points): default binica 62% slower than optimized  
Speed (64 channels, 100000 sampling points): default binica 68.5% slower than optimized  

## Prerequesites
### Install Intel Math Kernel Library
```bash
sudo wget https://apt.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS-2019.PUB
sudo apt-key add GPG-PUB-KEY-INTEL-SW-PRODUCTS-2019.PUB
sudo rm GPG-PUB-KEY-INTEL-SW-PRODUCTS-2019.PUB
sudo wget https://apt.repos.intel.com/setup/intelproducts.list -O /etc/apt/sources.list.d/intelproducts.list
sudo apt update
sudo apt install intel-mkl-2020.0-088
```

### USER-specific(!): Add MKL to PATH
You need to tell Ubuntu the location of the Intel MKL libraries. _**This is actually necessary to use the optimized binica**_.
To do so, simply add the following line to your `~/.bashrc` file. Note: According to intel, this is supposed to be in `~/.profile`, but my `~/.profile` does nothing but loading `~/.bashrc`.

`~/.profile`:
```bash
# include bashrc if it exists
if [ -f "$HOME/.bashrc" ]; then
     . "$HOME/.bashrc"
fi
```

`~/.bashrc`:
```
# include intel mkl paths
. /opt/intel/mkl/bin/mklvars.sh intel64 mod ilp64
```

log off and on and your path is set up.

## Compilation
Most likely you can just download the compiled binary from https://github.com/wanjam/binica . Nevertheless, I am documenting here how to compile the binary for future reference:

### clone binica repo
`git clone https://github.com/wanjam/binica`

### compile
```bash
make -f Makefile clean
make -f Makefile
```
That should be it.

## Adjustments I made
The most relevant change are the Paths and commands in `Makefile` and `Makefile.linux`. In the future, you might want to Google for something called the "MKL library linker", which will provide you with the correct commands for the MKL libraries. Please just take a look at the commits in my fork of the binica repository to check other edits.

# How to use it:
two steps:
1. add MKL permanently to your path
2. add binary to eeglab folder

## add binary
simply download the `ica_linux` file from https://github.com/wanjam/binica and replace the default one in your eeglab folder: `eeglab/functions/supportfiles/ica_linux`. Alternatively, you can manipulate the path in `icadefs.m` ll. 162 & 171
