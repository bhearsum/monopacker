### Purpose

The intention here is to create a single Packer + cloud-init configuration set that can be used across cloud providers to configure taskcluster worker instances.

### Goals

- Debugability: we should be able to run everything locally as well as in cloud providers
- Clarity: it should be clear which steps run on base images and which steps run on derived images
- Portability: the configuration should be generic enough to be run beyond Firefox CI's worker deployment

### Dependencies

- `jq` (`brew install jq`)
- `yq` (`brew install python-yq`)
- `make`
- `packer` (`go get github.com/hashicorp/packer`)
  - Note: I had issues using the `packer` builder out of box prior to 1.4.3
- `vagrant`

### Pre-requisites

- If building AWS AMIs you should have:
  > AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY, environment variables, representing your AWS Access Key and AWS Secret Key, respectively. [(see here)](https://www.packer.io/docs/builders/amazon.html#environment-variables)
- If building Google Cloud Images you should have:
  > A JSON file (Service Account) whose path is specified by the GOOGLE_APPLICATION_CREDENTIALS environment variable. [(see here)](https://www.packer.io/docs/builders/googlecompute.html#precedence-of-authentication-methods)

### Usage

```
# packer build
make build
# get real debug logging from packer
PACKER_LOG=1 make build
# pass additional args to packer
make build PACKER_ARGS="-only vagrant"
```

### FAQ

#### How do I build using only a single builder?

```
# example using only vagrant builder
cat packer.yaml| yq . | packer build -only vagrant -
```
