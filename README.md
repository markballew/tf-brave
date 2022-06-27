# tf-brave
Automated Brave build from scratch
## Getting the build running

    docker pull markballew/geodesic:latest # change /usr/local/bin/geodesic line 295 to export DOCKER_IMAGE="markballew/geodesic"
    cd tf-brave
    geodesic
    atmos workflow init -f workflow1
    atmos workflow vpc -f workflow1
    atmos workflow security-groups -f workflow1
    atmos workflow ec2 -f workflow1
    atmos workflow buildenv -f workflow1
## tear it all down
    atmos workflow destroy -f workflow1
