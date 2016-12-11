# aws-ec2-elasticsearch

Install Elasticsearch on AWS EC2 instance.

## Get code

```
sudo yum install -y git
git clone https://github.com/alexzhangs/aws-ec2-elasticsearch.git
```

## Installation Elasticsearch

Since Elasticsearch 5.x, it requires java 1.8.

First upgrade java version from 1.7 to 1.8 if needs.

```
yum install -y java-1.8.0-openjdk
echo 2 | /usr/sbin/alternatives --config java
java -version
```

Elasticsearch is not avalaible in AWS built-in yum repo, you will need
to provide a repo URL to this script.

I provide a repo URL at
`https://gist.github.com/alexzhangs/d0c858520f79de71543393aa45dccf61/raw`.

elastic.repo

```
[elastic-5.x]
name=Elastic.co repository for 5.x packages
baseurl=https://artifacts.elastic.co/packages/5.x/yum
gpgcheck=1
gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
enabled=1
autorefresh=1
type=rpm-md
```

Please note that `gist.github.com` is unaccessable within China deal
to well known reason.

Install Elasticsearch from yum repo:

```
sudo sh aws-ec2-elasticsearch/aws-ec2-elasticsearch-install.sh \
    -r https://gist.github.com/alexzhangs/d0c858520f79de71543393aa45dccf61/raw
```

In case there's other yum repo enabled, you may want to install Elasticsearch
from some repo only, e.g. `elastic-5.x` here, use:

```
sudo sh aws-ec2-elasticsearch/aws-ec2-elasticsearch-install.sh \
    -r https://gist.github.com/alexzhangs/d0c858520f79de71543393aa45dccf61/raw
    -n elastic-5.x
```

Or you can install Elasticsearch from a RPM file path or URL, this is
useful if experiencing slow network during downloading package from yum repo.

from local file:

```
sudo sh aws-ec2-elasticsearch/aws-ec2-elasticsearch-install.sh \
    -f ~/elasticsearch.rpm
```

from URL:

```
sudo sh aws-ec2-elasticsearch/aws-ec2-elasticsearch-install.sh \
    -f http://somewhere.com/elasticsearch.rpm
```

See script help:

```
sh aws-ec2-elasticsearch/aws-ec2-elasticsearch-install.sh -h
```

## Setup Elasticsesarch

Simply run:

```
sudo sh aws-ec2-elasticsearch/aws-ec2-elasticsearch-setup.sh
```

It's able to specify cluster name and other settings, and install plugins
by the script, see script help:

```
sh aws-ec2-elasticsearch/aws-ec2-elasticsearch-setup.sh -h
```
