include_recipe 'zsh'
include_recipe 'vim'

node['dotfiles']['accounts'].each do |account|
  home_dir = "/home/#{account.user}"
  if account.user == 'root'
    home_dir = '/root'
  end

  git "#{home_dir}/dotfiles" do
    repository node['dotfiles']['repository']
    revision node['dotfiles']['revision']
    enable_checkout false
    user account.user
    group account.group
    action :sync
  end

  execute 'install dotfiles' do
    command './install'
    cwd "#{home_dir}/dotfiles"
    user account.user
    group account.group
    environment 'HOME' => home_dir
  end

  execute 'set zsh as default shell' do
    command "chsh -s $(which zsh) #{account.user}"
  end
end
