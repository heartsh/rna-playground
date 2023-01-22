# Docker Playground <img src="./assets/images_fixed/docker_logo.png" width="40">
Replaying computational experiments in academic papers is the first but troublesome step to understand developed computational methods.
I provide an Ubuntu-based computational environment implemented on [Docker](https://www.docker.com/) as a playground to try out RNA software:
```bash
$ git clone https://github.com/heartsh/rna-playground && cd rna-playground
$ # Build a Docker container and healthcheck it
$ # This container will be removed after this healthcheck
$ ./docker_compose_wrapper.sh
$ # Windows: start your Zsh login session into a Docker container
$ docker-compose run win
$ # Mac: start your Zsh login session into a Docker container
$ docker-compose run mac
```
To allow GUI features in my Docker playground (e.g., visualizing figures), you need to install [WSL](https://learn.microsoft.com/en-us/windows/wsl/install) (for Windows) or [XQuartz](https://www.xquartz.org) (for macOS).

# Author
[Heartsh](https://github.com/heartsh)

# License
Copyright (c) 2023 Heartsh  
Licensed under [the MIT license](http://opensource.org/licenses/MIT).
