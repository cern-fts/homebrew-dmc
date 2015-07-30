# Homebrew Data Management clients
## How do I install these formulae?
You need first to install the [Homebrew](http://brew.sh/) tool. Then,

`brew install cern-it-sdc-id/dmc/<formula>`

Or `brew tap cern-it-sdc-id/dmc` and then `brew install <formula>`.

## Example
```shell
brew tap cern-it-sdc-id/dmc
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

## Help! I can't connect to secure endpoints
To connect to Grid endpoints normally a proxy is required, sometimes with the proper VO extensions.
Additionally, these endpoints will present the client application a X509 certificate that proofs they are who
they say they are. These certificates are signed by a trusted Certification Authority, whose certificates need to be present in the client machine.

So, basically, we need to fix two related issues

### Install the trusted CA's
You will need to grab the required root certificates from the [EGI Repository](http://repository.egi.eu/sw/production/cas/1/current/tgz/). For instance, if we want to access endpoints
signed by CERN, you will need `ca_CERN-GridCA-1.65.tar.gz` and `ca_CERN-Root-2-1.65.tar.gz`.

Anyway, just for facilitate the setup, let's install all of them:

```shell
brew install wget
sudo su -
mkdir -p /etc/grid-security/certificates
cd /etc/grid-security/certificates/
wget -r -l1 --no-parent -nd --accept=.tar.gz "http://repository.egi.eu/sw/production/cas/1/current/tgz/"
for i in `ls *.tar.gz`; do tar xzf $i --strip-components=1; done
rm -vf robots.txt *.tar.gz
```
Now the Root certificates are installed under /etc/grid-security/certificates, where the tools can find them.

You can validate it works running `voms-proxy-init` (without `--voms` yet!). Remember to point the environment
variables X509_USER_CERT and X509_USER_KEY to your Grid certificate and key, if they are not in the default area.
