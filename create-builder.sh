#!/bin/bash
set -ex
pack create-builder making/java-native-image-cnb-builder -c $(dirname $0)/builder.toml
