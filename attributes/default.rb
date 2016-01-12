id = :dotfiles

default[id][:users] = [
  'root',
  'vagrant'
]

default[id][:repository] = 'https://github.com/aspyatkin/dotfiles'
default[id][:revision] = 'master'
