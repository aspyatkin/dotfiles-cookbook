name 'dotfiles'
maintainer 'Alexander Pyatkin'
maintainer_email 'aspyatkin@gmail.com'
license 'MIT'
version '1.4.0'
description 'Installs and configures dotfiles'
long_description ::IO.read(::File.join(::File.dirname(__FILE__), 'README.md'))

recipe 'dotfiles', 'Installs and configures dotfiles'
depends 'zsh', '~> 2.0.0'
depends 'vim', '~> 2.0.2'

source_url 'https://github.com/aspyatkin/dotfiles-cookbook'

supports 'ubuntu'
