# fuck-ru

Running ddos to bring down ru sites using AWS infra.

## Getting started

### Prepare

Copy `.env.example` to `.env` file.

```shell
cp .env.example .env
```

Update .env values, you need to specify:

1. `TF_VAR_aws_access_key`
2. `TF_VAR_aws_secret_key`

You can set the list of regions you want to start instances in, check `AWS_REGIONS` in `.env.example`.

```shell
terraform init
```

### Create instances

Just run it:

```shell
./fuck.sh
```

### Destroy instances

```shell
./fuck.sh destroy
```

### Monitoring

Logs are in `/var/log/cloud-init-output.log`.

## Tech details

We are running spot instances `t3.nano`. We are starting <https://github.com/abionics/attacker> on each instance. Instances are run for 1h and then kill them selves/rotate.

## Cost

On-demand price in `us-east-1` is `$0.0062`. Spot price is about `$0.002`, running 10 instances 24h costs: `0.002*10*24=$0.48`.
