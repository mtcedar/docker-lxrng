FROM ubuntu:14.04

# install required packages
RUN \
	sed -i.bak -e "s%http://archive.ubuntu.com/%http://linux.yz.yamagata-u.ac.jp/%g" /etc/apt/sources.list && \
	apt update && \
	apt install -y \
		git-core \
		apache2 \
		postgresql-client \
		libxapian22 \
		libsearch-xapian-perl \
		libapache2-mod-perl2 \
		libcgi-simple-perl \
		libcgi-ajax-perl \
		libhtml-parser-perl \
		libtemplate-perl \
		libterm-progressbar-perl \
		libdevel-size-perl \
		libdigest-sha-perl \
		libdbd-pg-perl \
		exuberant-ctags \
		texlive \
		texlive-latex-recommended \
		texlive-fonts-extra \
		lmodern \
		inkscape

# setup lxrng
WORKDIR /var/www/html
RUN \
	useradd lxrng && \
	git clone -b docker-custom https://github.com/mtcedar/lxrng.git

WORKDIR /var/www/html/lxrng
COPY refresh_git . 
COPY update_lxr .
COPY start_lxr .
RUN \
	mkdir text-db cache repo && \
	cp lxrng.conf-dist lxrng.conf && \
	cp apache2-site.conf-dist-mod_perl apache2-site.conf && \
	sed -i -e "s%@@LXRROOT@@%/var/www/html/lxrng%g" apache2-site.conf && \
	sed -i -e "s%@@LXRURL@@%lxr%g" apache2-site.conf && \
	chown -R lxrng.lxrng . && \
	chown -R www-data.www-data lib webroot tmpl lxrng_mod_perl.pl && \
	chmod -R 777 cache && \
	ln -s /var/www/html/lxrng/apache2-site.conf /etc/apache2/sites-enabled/010-lxrng.conf
RUN \
	echo 'lxrng	ALL=(ALL:ALL) ALL' >> /etc/sudoers

CMD /var/www/html/lxrng/start_lxr 

