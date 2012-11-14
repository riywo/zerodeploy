## ZeroDeploy

Simple deploy idea using zeromq.

## Install

need zeromq v2. use homebrew, yum, apt.

    $ git clone https://github.com/riywo/zerodeploy
    $ cpanm -v --installdeps .

## Usage

on deploy server

    $ ./master.pl ~/.bashrc

on remote servers

    $ ZD_MASTER=master-host ./slave.pl ~/.bashrc

