# Docker使用文档#

本文档旨在实验Docker1.13新特性和帮助大家了解docker集群的管理和使用。

## 环境配置##

**软件环境**

- Docker1.13.1
- docker-compose 1.11.1
- centos 7.3.1611

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

## 创建应用##

使用docker-compose创建应用

使用service创建应用

## 集群管理##

我们推荐使用开源的docker集群管理配置方案：

- [Crane](https://github.com/Dataman-Cloud/crane)：由数人云开源的基于swarmkit的容器管理软件，可以作为docker和go语言开发的一个不错入门项目
- [Rancher](https://github.com/rancher/rancher):Rancher是一个企业级的容器管理平台，可以使用Kubernetes、swarm和rancher自研的cattle来管理集群。

[Crane的部署和使用](docs/crane_usage.md)

[Rancher的部署和使用](docs/rancher_usage.md)

## 关于##

Jimmy Song 

rootsongjc@gmail.com