id = :dotfiles

default[id][:accounts] = [
  { user: 'root', group: 'root' },
  { user: 'vagrant', group: 'vagrant' }
]
default[id][:repository] = 'https://github.com/aspyatkin/dotfiles'
default[id][:revision] = 'master'
