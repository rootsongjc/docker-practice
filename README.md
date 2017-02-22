# Docker实践教程#

本文档旨在实验Docker1.13新特性和帮助大家了解docker集群的管理和使用。

## 环境配置##

**软件环境**

- Docker1.13.1
- docker-compose 1.11.1
- centos 7.3.1611

如果在Mac上安装后docker后需要从docker hub上下载镜像，建议设置国内的mirror，能够显著增加下载成功率，提高下载速度，推荐[daocloud的mirror](https://www.daocloud.io/mirror#accelerator-doc)。

设置方式很简单，只需要在Mac版本的docker - preferences - daemon - registry mirrors中增加一条``http://c22d9eb5.m.daocloud.io``即可。

**硬件环境**

| Hostname                                | IP           | Role                |
| --------------------------------------- | ------------ | ------------------- |
| sz-pg-oam-docker-test-001.tendcloud.com | 172.20.0.113 | Swarm leader/worker |
| sz-pg-oam-docker-test-002.tendcloud.com | 172.20.0.114 | Worker              |
| sz-pg-oam-docker-test-003.tendcloud.com | 172.20.0.115 | Worker              |

**网络环境**

- Swarm内置的overlay网络，不需要单独安装
- *mynet自定义网络(TBD)，目前没有在docker中使用*

## 网络配置##

网络配置是容器使用中的的一个重点和难点，对比我们之前使用的docker版本是1.11.1，docker1.13中网络模式跟之前的变动比较大，我们会花大力气讲解。

[如何创建docker network](docs/create_network.md)

[一步步教你创建一个自定义网络](docs/create_network_step_by_step.md)

[Rancher网络探讨和扁平网络实现](docs/rancher_network.md)

## 存储管理##

## 日志管理##

Docker提供了一系列[log drivers](https://docs.docker.com/engine/admin/logging/overview/)，如fluentd、journald、syslog等。

需要配置docker engine的启动参数。

## 创建应用

官方文档：[Docker swarm sample app overview](https://docs.docker.com/engine/getstarted-voting-app/)

[基于docker1.13手把手教你创建swarm app](docs/create_swarm_app.md)

使用docker-compose创建应用

使用service创建应用

## 集群管理##

我们使用docker内置的swarm来管理docker集群。

[swarm mode介绍](docs/swarm_mode.md)

我们推荐使用开源的docker集群管理配置方案：

- [Crane](https://github.com/Dataman-Cloud/crane)：由数人云开源的基于swarmkit的容器管理软件，可以作为docker和go语言开发的一个不错入门项目
- [Rancher](https://github.com/rancher/rancher):Rancher是一个企业级的容器管理平台，可以使用Kubernetes、swarm和rancher自研的cattle来管理集群。

[Crane的部署和使用](docs/crane_usage.md)

[Rancher的部署和使用](docs/rancher_usage.md)

## 插件开发##

网络插件

存储插件

## 业界使用案例

[京东从OpenStack切换到Kubernetes的经验之谈](docs/jd_transform_to_kubernetes.md)

[美团点评容器平台介绍](docs/meituan_docker_platform.md)

## 相关资源##

[容器技术工具与资源](docs/tech_resource.md)

## 关于##

Author: Jimmy Song 

rootsongjc@gmail.com