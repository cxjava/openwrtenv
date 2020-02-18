FROM ubuntu:14.04

MAINTAINER SuLIngGG "admin@mlapp.cn"

ENV DEBIAN_FRONTEND noninteractive

RUN sed -i 's/archive.ubuntu.com/mirrors.tuna.tsinghua.edu.cn/g' /etc/apt/sources.list \
	&& apt-get -y update \
	&& apt-get install -qqy --no-install-recommends asciidoc autoconf automake autopoint binutils bison build-essential bzip2 ca-certificates curl device-tree-compiler flex gawk gcc-multilib gettext git git-core gperf htop lib32gcc1 libc6-dev-i386 libelf-dev libglib2.0-dev libgmp3-dev libmpc-dev libmpfr-dev libncurses5-dev libssl-dev libtool libz-dev mc msmtp nano p7zip p7zip-full patch pkg-config python-docutils qemu-utils rsync screen subversion sudo texinfo uglifyjs unzip upx vim wget xmlto zlib1g-dev zsh \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/* \
	&& useradd -m admin \
	&& echo admin:admin | chpasswd \
	&& echo 'admin ALL=NOPASSWD: ALL' > /etc/sudoers.d/admin \
	&& cd /home/admin \
	&& git clone git://github.com/robbyrussell/oh-my-zsh ./.oh-my-zsh \
	&& cp /home/admin/.oh-my-zsh/templates/zshrc.zsh-template ./.zshrc \
	&& git clone git://github.com/zsh-users/zsh-syntax-highlighting ./.oh-my-zsh/custom/plugins/zsh-syntax-highlighting \
	&& git clone git://github.com/zsh-users/zsh-autosuggestions ./.oh-my-zsh/custom/plugins/zsh-autosuggestions \
	&& sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="ys"/g' .zshrc \
	&& sed -i 's/plugins=(git)/plugins=(git sudo zsh-syntax-highlighting zsh-autosuggestions)/g' .zshrc \
	&& sed -i 's/# DISABLE_AUTO_UPDATE/DISABLE_AUTO_UPDATE/g' .zshrc \
	&& chown -R admin:admin /home/admin \
	&& cp -R ./.oh-my-zsh/ /root/ \
	&& cp ./.zshrc /root \
	&& sed -i 's/\/home\/admin:/\/home\/admin:\/bin\/zsh/g' /etc/passwd \
	&& echo "Asia/Shanghai" > /etc/timezone \
	&& dpkg-reconfigure -f noninteractive tzdata

USER admin
WORKDIR /home/admin

CMD ["/build.sh"]
