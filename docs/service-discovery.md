# 服务发现

下面罗列一些列常见的服务发现工具。

 Etcd:服务发现/全局分布式键值对存储。这是CoreOS的创建者提供的工具，面向容器和宿主机提供服务发现和全局配置存储功能。它在每个宿主机有基于http协议的API和命令行的客户端。[https://github.com/docker/etcd](https://github.com/docker/etcd) 

- [Cousul](https://github.com/hashicorp/consul)：服务发现/全局分布式键值对存储。这个服务发现平台有很多高级的特性，使得它能够脱颖而出，例如：配置健康检查、ACL功能、HAProxy配置等等。
- [Zookeeper](https://github.com/apache/zookeeper)：诞生于Hadoop生态系统里的组件，Apache的开源项目。服务发现/全局分布式键值对存储。这个工具较上面两个都比较老，提供一个更加成熟的平台和一些新特性。
- Crypt：加密etcd条目的项目。Crypt允许组建通过采用公钥加密的方式来保护它们的信息。需要读取数据的组件或被分配密钥，而其他组件则不能读取数据。
- [Confd](https://github.com/kelseyhightower/confd)：观测键值对存储变更和新值的触发器重新配置服务。Confd项目旨在基于服务发现的变化，而动态重新配置任意应用程序。该系统包含了一个工具来检测节点中的变化、一个模版系统能够重新加载受影响的应用。
- [Vulcand](https://github.com/vulcand/vulcand)：vulcand在组件中作为负载均衡使用。它使用etcd作为后端，并基于检测变更来调整它的配置。
- [Marathon](https://github.com/mesosphere/marathon)：虽然marathon主要是调度器，它也实现了一个基本的重新加载HAProxy的功能，当发现变更时，它来协调可用的服务。
- Frontrunner：这个项目嵌入在marathon中对HAproxy的更新提供一个稳定的解决方案。
- [Synapse](https://github.com/airbnb/synapse)：由Airbnb出品的，Ruby语言开发，这个项目引入嵌入式的HAProxy组件，它能够发送流量给各个组件。[http://bruth.github.io/synapse/docs/](http://bruth.github.io/synapse/docs/) 
- [Nerve](https://github.com/airbnb/nerve)：它被用来与synapse结合在一起来为各个组件提供健康检查，如果组件不可用，nerve将更新synapse并将该组件移除出去。