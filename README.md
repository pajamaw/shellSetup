## Shell Setup
This contains everything to start a comp from scratch except for applications and setting up new keys. Just make sure to transfer the dotfiles and brewfile into the home path. The files exist within the repo locally are copied and pushed from for backup.   

It has most of the nuts and bolts to utilize the `prezto` theme as well - although once cloned you'll need to update the .zprezto submodule folder. 
```console
cd $ZPREZTODIR
git pull
git submodule update --init --recursive
```

