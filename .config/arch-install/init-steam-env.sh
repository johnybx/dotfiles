#!/bin/bash
setfacl --recursive -m u:steam:rwx "$XDG_RUNTIME_DIR"
xhost si:localuser:steam

