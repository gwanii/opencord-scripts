#!/bin/bash
sudo apt-get install build-essential libpcap-dev
if [[ ! -d ~/vEPC ]]; then
    echo "download vEPC first, https://gerrit.opencord.org/vEPC" && exit 1
fi
cd ~/vEPC/mme/Standalone/
make -f vb.mak BLDENV=lnx_acc MACHINE=BIT64 acc
cd ~/vEPC/pgw/Product
make -f av.mak BLDENV=lnx_acc MACHINE=BIT64 acc
cd ~/vEPC/sgw/Product/
make -f qo.mak BLDENV=lnx_acc MACHINE=BIT64 acc
if [[ -d ~/bin ]]; then
    exit 1
fi
mkdir -p ~/bin/mme
mkdir -p ~/bin/pgw
mkdir -p ~/bin/sgw
cp ~/vEPC/mme/Standalone/vb_acc ~/bin/mme/
cp ~/vEPC/mme/Standalone/vb_hss_ue.db ~/bin/mme/
cp ~/vEPC/mme/Standalone/vbsm_cfg.txt ~/bin/mme/
cp ~/vEPC/pgw/Product/av_acc ~/bin/pgw/
cp ~/vEPC/pgw/Product/avsm_cfg.txt ~/bin/pgw/
cp ~/vEPC/sgw/Product/qo_acc ~/bin/sgw/
cp ~/vEPC/sgw/Product/qosm_cfg.txt ~/bin/sgw/
