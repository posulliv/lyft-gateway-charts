
Lyft's Presto Gateway Helm Charts
===========

[presto-gateway](https://github.com/lyft/presto-gateway) is a load balancer / proxy / gateway for Trino/Presto.


## Usage

[Helm](https://helm.sh) must be installed to use the charts.
Please refer to Helm's [documentation](https://helm.sh/docs/) to get started.

Once Helm is set up properly, add the repo as follows:

```console
helm repo add gateway https://posulliv.github.io/lyft-gateway-charts
```

You can then run `helm search repo gateway` to see the charts.

Then you can install chart using:

```console
helm install trino-gateway gateway/gateway --version 0.2.6 
```

## Documentation

You can find an example of deploying on Google Cloud with this charts [here](https://posulliv.github.io/posts/lyft-gateway-helm/).

You can find documentation about the chart [here](./charts/gateway/README.md).
