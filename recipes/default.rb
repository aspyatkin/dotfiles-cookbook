include_recipe 'zsh'
include_recipe 'vim'
id = :dotfiles

node[id][:accounts].each do |account|
  home_dir = "/home/#{account.user}"
  if account.user == 'root'
    home_dir = '/root'
  end

  git "#{home_dir}/dotfiles" do
    repository node[id][:repository]
    revision node[id][:revision]
    enable_checkout false
    user account.user
    group account.group
    action :sync
  end

  execute "install dotfiles to `#{account.user}` home folder" do
    command './install'
    cwd "#{home_dir}/dotfiles"
    user account.user
    group account.group
    environment 'HOME' => home_dir
  end

  execute "set zsh as default shell for `#{account.user}`" do
    command "chsh -s $(which zsh) #{account.user}"
  end
end
