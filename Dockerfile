FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update
RUN apt-get install git curl wget zsh build-essential clustalw probcons libboost-all-dev pkg-config bzip2 vim cmake libglpk-dev -y
SHELL ["/bin/zsh", "-c"]
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
RUN sed -E -i "s/^ZSH_THEME=\"[a-zA-Z]+\"$/ZSH_THEME=\"ys\"/" /root/.zshrc
WORKDIR /tmp
ENV ANACONDA_ARCHIVE=https://repo.anaconda.com/archive
ENV ANACONDA_INSTALLER_LIST=/tmp/anaconda_installer_list.txt
RUN curl "$ANACONDA_ARCHIVE/" > $ANACONDA_INSTALLER_LIST
ENV LATEST_ANACONDA_INSTALLER=/tmp/latest_anaconda_installer.txt
RUN grep -E "Anaconda[0-9]+\-20[0-9]{2}\.[0-9]+\-Linux\-x86_64\.sh" $ANACONDA_INSTALLER_LIST | sed -E "s/<[^>]*>//g" | sed -E "s/ //g" | sort -nr | head -1 > $LATEST_ANACONDA_INSTALLER
RUN curl -O $ANACONDA_ARCHIVE/$(cat $LATEST_ANACONDA_INSTALLER)
RUN sh $(cat $LATEST_ANACONDA_INSTALLER) -b -p /usr/local/anaconda
ENV PATH=$PATH:/usr/local/anaconda/bin
RUN conda update conda -y
RUN conda update --all -y
RUN git clone https://github.com/VundleVim/Vundle.vim.git /root/.vim/bundle/Vundle.vim
RUN vim +PluginInstall +qall
RUN conda config --add channels defaults
RUN conda config --add channels bioconda
RUN conda config --add channels conda-forge
RUN conda install numpy matplotlib pandas seaborn scipy biopython locarna contrafold rnastructure scikit-learn jupyter -y
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
RUN source /root/.cargo/env
ENV PATH=/root/.cargo/bin:$PATH
# If the following command fails, please remove RUSTFLAGS='...' to disable advanced installation options
RUN RUSTFLAGS='--emit asm -C target-feature=+avx -C target-feature=+ssse3 -C target-feature=+mmx' cargo install consprob consalifold consprob-trained consalign
RUN wget -nd -np -P /tmp https://www.tbi.univie.ac.at/RNA/download/sourcecode/2_4_x/ViennaRNA-2.4.18.tar.gz
RUN tar -xf /tmp/ViennaRNA-2.4.18.tar.gz -C /tmp
WORKDIR /tmp/ViennaRNA-2.4.18
RUN ./configure && make -j$(nproc) && make install
RUN wget -nd -np -P /tmp https://mafft.cbrc.jp/alignment/software/mafft-7.490-with-extensions-src.tgz
RUN tar -xf /tmp/mafft-7.490-with-extensions-src.tgz -C /tmp
WORKDIR /tmp/mafft-7.490-with-extensions/core
RUN make clean && make -j$(nproc) && make install
WORKDIR /tmp/mafft-7.490-with-extensions/extensions
RUN make clean && make -j$(nproc) && make install
RUN wget -nd -np -P /tmp https://github.com/satoken/centroid-rna-package/archive/refs/tags/v0.0.16.tar.gz
RUN tar -xf /tmp/v0.0.16.tar.gz -C /tmp
WORKDIR /tmp/centroid-rna-package-0.0.16
RUN ./configure && make -j$(nproc) && make install
RUN wget -nd -np -P /tmp https://rth.dk/resources/petfold/download/PETfold2.1.tar.gz
RUN tar -xf /tmp/PETfold2.1.tar.gz -C /tmp
WORKDIR /tmp/PETfold/src
RUN make clean && make -j$(nproc)
RUN cp ../bin/* /usr/local/bin
RUN echo -e "export PETFOLDBIN=/usr/local/bin" >> /root/.zshrc
RUN git clone https://github.com/heartsh/contralign-fixed /tmp/contralign-fixed
WORKDIR /tmp/contralign-fixed
RUN make -j$(nproc)
RUN cp contralign /usr/local/bin
RUN git clone https://github.com/heartsh/raf-fixed /tmp/raf-fixed
WORKDIR /tmp/raf-fixed
RUN make -j$(nproc)
RUN cp raf /usr/local/bin
RUN echo -e "\nexport CONTRAFOLD_DIR=/usr/local/miniconda/bin" >> /root/.zshrc
RUN echo -e "\nexport CONTRALIGN_DIR=/usr/local/bin" >> /root/.zshrc
RUN git clone https://github.com/LinearFold/LinearTurboFold /tmp/LinearTurboFold
WORKDIR /tmp/LinearTurboFold
RUN make -j$(nproc)
RUN cp linearturbofold /usr/local/bin
RUN wget -nd -np -P /tmp https://github.com/satoken/dafs/archive/refs/tags/v0.0.3.tar.gz
RUN tar -xf /tmp/v0.0.3.tar.gz -C /tmp
WORKDIR /tmp/dafs-0.0.3
RUN ./configure --with-vienna-rna=$(which RNAfold | sed -E "s/\/bin\/.+//") --with-glpk && make -j$(nproc) && make install
RUN rm -rf /tmp/*
RUN apt-get clean -y && apt-get autoremove -y
RUN conda clean --all -y
ENTRYPOINT zsh
WORKDIR /root 
