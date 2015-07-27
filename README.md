# Homebrew Data Management clients
## How do I install these formulae?
You need first to install the [Homebrew](http://brew.sh/) tool. Then,

`brew install ayllon/dmc/<formula>`

Or `brew tap ayllon/dmc` and then `brew install <formula>`.

## Example
```shell
brew tap ayllon/dmc
brew install srm-ifce
gfal_srm_ifce_version
```

# Where are gfal2-python and gfal2-util?
They are not distributed via Homebrew, but rather using more Pythonic methods. If you want to have gfal2-python
and/or gfal2-util in your Mac machine, just follow the next steps:

```shell
$ sudo easy_install pip
$ sudo pip install virtualenv
$ brew install gfal2
$ brew install boost-python
$ virtualenv gfal2
$ source gfal2/bin/activate
(gfal2) $ pip install "git+https://gitlab.cern.ch/dmc/gfal2-bindings.git@develop"
(gfal2) $ python -c 'import gfal2; print gfal2.__version__'
1.8.3
(gfal2) $ pip install "git+https://gitlab.cern.ch/dmc/gfal2-util.git@develop"
(gfal2) $ gfal-ls "file:///"
...
```
