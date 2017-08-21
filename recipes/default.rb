require 'etc'

include_recipe 'zsh'
include_recipe 'vim'

id = 'dotfiles'

if node[id]['users'].empty?
  if node['current_user'] != ::ENV['SUDO_USER']
    node.default[id]['users'] = [
      node['current_user'],
      ::ENV['SUDO_USER']
    ]
  else
    node.default[id]['users'] = [
      node['current_user']
    ]
  end
end

node[id]['users'].each do |user_name|
  passwd_entry = ::Etc.getpwnam(user_name)
  group_entry = ::Etc.getgrgid(passwd_entry.gid)

  dotfiles_dir = ::File.join(passwd_entry.dir, 'dotfiles')

  git dotfiles_dir do
    repository node[id]['repository']
    revision node[id]['revision']
    enable_checkout false
    user user_name
    group group_entry.name
    action :sync
  end

  execute "Install dotfiles to #{user_name}'s home directory" do
    command './install'
    cwd dotfiles_dir
    user user_name
    group group_entry.name
    environment 'HOME' => passwd_entry.dir
  end

  execute "chsh -s $(which zsh) #{user_name}" do
    not_if "test \"$(getent passwd #{user_name} | cut -d: -f7)\" = \"$(which zsh)\""
  end
end
