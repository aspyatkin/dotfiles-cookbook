module Dotfiles
  module Helper
    include Chef::Mixin::ShellOut

    def get_user_homedir(username)
      shell_out!("getent passwd #{username} | cut -d: -f6", returns: 0).stdout.strip
    end

    def get_user_group(username)
      shell_out!("getent group $(id -g #{username}) | cut -d: -f1", returns: 0).stdout.strip
    end
  end
end
