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

# gfal2-python and gfal2-util
There are two options for installing these two components. They can be either installed via Homebrew, as the rest, or
inside a Python virtualenv.

## Homebrew
```shell
brew install gfal2-python
brew install gfal2-util
```

Note that there is no need to install all components manually. If you are just interested on gfal2-util, you
can just do `brew install gfal2-util` and all the required dependencies will be downloaded, built and installed.

## virtualenv

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

### Configure VOMS
We can now create proxies, but not proxies with VO extensions. For that, we need to configure the VOMS. Luckily, this is really easy! Just need to download [our convenience vomses file](http://grid-deployment.web.cern.ch/grid-deployment/dms/dmc/vomses) into `$HOME/.voms/vomses`

```shell
mkdir -p $HOME/.voms
wget http://grid-deployment.web.cern.ch/grid-deployment/dms/dmc/vomses -O $HOME/.voms/vomses
wget -O $HOME/.voms/vomses
```

Now try `voms-proxy-init --voms <your-vo>`, and you are good to go!

```shell
$ voms-proxy-init --voms dteam
Enter GRID pass phrase:
Your identity: /DC=ch/DC=cern/OU=...
Cannot find file or dir: /usr/local/etc/vomses
Creating temporary proxy ..................................... Done
Contacting  voms.hellasgrid.gr:15004 [/C=GR/O=HellasGrid/OU=hellasgrid.gr/CN=voms.hellasgrid.gr] "dteam" Done
Creating proxy ........................................... Done

Your proxy is valid until Fri Jul 31 03:34:08 2015
Error: verify failed.
Cannot verify AC signature!

$ voms-proxy-info --all
subject   : /DC=ch/DC=cern/OU=...
issuer    : /DC=ch/DC=cern/OU=...
identity  : /DC=ch/DC=cern/OU=...
type      : proxy
strength  : 1024 bits
path      : /tmp/x509up_uxxx
timeleft  : 11:59:43
key usage : Digital Signature, Key Encipherment
=== VO dteam extension information ===
VO        : dteam
subject   : /DC=ch/DC=cern/OU=...
issuer    : /C=GR/O=HellasGrid/OU=hellasgrid.gr/CN=voms.hellasgrid.gr
attribute : /dteam/Role=NULL/Capability=NULL
timeleft  : 11:59:39
uri       : voms.hellasgrid.gr:15004
```

Note that you can ignore the "Error: verify failed" message.

Let's verify our new proxy with the gfal2-util that we had installed!

```shell
$ source gfal2/bin/activate
(gfal2) $ gfal-ls gsiftp://dpmhead-rc.cern.ch/dpm/cern.ch/home
alice
atlas
cms
dteam
lhcb
```
