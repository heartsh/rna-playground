# Docker Playground <img src="./assets/images_fixed/docker_logo.png" width="40">
Replaying computational experiments in academic papers is the first but troublesome step to understand developed computational methods.
I provide an Ubuntu-based computational environment implemented on [Docker](https://www.docker.com/) as a playground to try out RNA software:
```bash
$ git clone https://github.com/heartsh/rna-playground && cd rna-playground
$ # Zsh will be called in a Ubuntu-based Docker container to start your login session
$ ./docker_compose_wrapper.sh
```
To allow GUI features in my Docker playground (e.g., visualizing figures), you need to install [WSL](https://learn.microsoft.com/en-us/windows/wsl/install) (for Windows) or [XQuartz](https://www.xquartz.org) (for macOS).

# Author
[Heartsh](https://github.com/heartsh)

# License
Copyright (c) 2023 Heartsh  
Licensed under [the MIT license](http://opensource.org/licenses/MIT).
