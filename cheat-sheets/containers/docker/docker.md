# Docker
**Docker** is a set of platform as a service (PaaS) products that use OS-level virtualization to deliver software in packages called _containers_. The service has both free and premium tiers. The software that hosts the containers is called **Docker Engine**.

- Project Homepage: [Home - Docker](https://www.docker.com/)
- Documentation: [Docker Documentation | Docker Documentation](https://docs.docker.com/)
---
## Installation

One click installation script:
```
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
```

Run docker as non root user:
```
sudo groupadd docker
sudo usermod -aG docker $USER
```

Install Docker Engine : [Docker Engine](https://docs.docker.com/engine/install/)

---

## Commands
See [quickref.me cheat sheet](https://quickref.me/kubernetes)
## Backup a container
Backup docker data from inside container volumes and package it in a tarball archive.
`docker run --rm --volumes-from CONTAINER -v $(pwd):/backup busybox tar cvfz /backup/backup.tar CONTAINERPATH`

An automated backup can be done also by this [Ansible playbook](https://github.com/thedatabaseme/docker_backup).
The output is also a (compressed) tar. The playbook can also manage the backup retention.
So older backups will get deleted automatically.

To also create and backup the container configuration itself, you can use `docker-replay`for that. If you lose
the entire container, you can recreate it with the export from `docker-replay`.
A more detailed tutorial on how to use docker-replay can be found [here](https://thedatabaseme.de/2022/03/18/shorty-generate-docker-run-commands-using-docker-replay/).

## Restore container from backup
Restore the volume with a tarball archive.
`docker run --rm --volumes-from CONTAINER -v $(pwd):/backup busybox sh -c "cd CONTAINERPATH && tar xvf /backup/backup.tar --strip 1"`

## Troubleshooting

### Files issues
[[dive-docker]] might help.

### Networking
`docker run --name netshoot --rm -it nicolaka/netshoot /bin/bash`

