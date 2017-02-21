# 创建docker swarm应用

下面以docker官网上的创建[vote投票](https://docs.docker.com/engine/getstarted-voting-app/)示例来说明如何创建一个docker swarm的应用。

在进行如下步骤时，你需要保证已经部署并正常运行着一个docker swarm集群。

在这个应用中你将学到

- 通过创建``docker-stack.yml``和使用``docker stack deploy``命令来部署应用
- 使用``visualizer``来查看应用的运行时
- 更新``docker-stack.yml``和``vote``镜像重新部署和发布**vote** 应用
- 使用Compose Version 3

![vote-app-diagram](imgs/vote-app-diagram.png)

