name 'dotfiles'
maintainer 'Alexander Pyatkin'
maintainer_email 'aspyatkin@gmail.com'
license 'MIT'
version '1.1.0'
description 'Installs and configures dotfiles'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))

recipe 'dotfiles', 'Installs and configures dotfiles'
depends 'zsh', '~> 1.0.3'
depends 'vim', '~> 2.0.0'

suggests 'latest-git', '~> 1.1'

source_url 'https://github.com/aspyatkin/dotfiles-cookbook' if respond_to?(:source_url)

supports 'ubuntu'
supports 'centos'
