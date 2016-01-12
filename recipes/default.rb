include_recipe 'zsh'
include_recipe 'vim'

id = :dotfiles

node[id][:users].each do |user_name|
  git "Checkout dotfiles repository to #{user_name}'s home directory" do
    Chef::Resource::Git.send(:include, Dotfiles::Helper)
    destination ::File.join get_user_homedir(user_name), 'dotfiles'
    repository node[id][:repository]
    revision node[id][:revision]
    enable_checkout false
    user user_name
    group get_user_group(user_name)
    action :sync
  end

  execute "Install dotfiles to #{user_name}'s home directory" do
    Chef::Resource::Execute.send(:include, Dotfiles::Helper)
    command './install'
    cwd ::File.join get_user_homedir(user_name), 'dotfiles'
    user user_name
    group get_user_group(user_name)
    environment 'HOME' => get_user_homedir(user_name)
  end

  execute "Set zsh as #{user_name}'s default shell program" do
    command "chsh -s $(which zsh) #{user_name}"
    not_if "test \"$(getent passwd #{user_name} | cut -d: -f7)\" = \"$(which zsh)\""
  end
end
