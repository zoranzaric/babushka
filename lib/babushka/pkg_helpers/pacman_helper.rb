module Babushka
  class PacmanHelper < PkgHelper
  class << self
    def pkg_type; :pacman end
    def pkg_cmd; pkg_binary end
    def pkg_binary; "pacman" end
    def manager_key; :pacman end
	 def pkg_update_command; "#{pkg_cmd} -Sy" end

    def install! pkgs, opts = nil
		log_shell "Installing #{pkgs.to_list} via #{manager_key}", "#{pkg_cmd} -Sq --noconfirm --noprogressbar #{pkgs.join(' ')} #{opts}", :sudo => should_sudo?
    end

    private

    def _has? pkg_name
      # Some example output, with 'wget' installed:
      #   'wget'
      pkg_name == shell("#{pkg_cmd} -Qq #{pkg_name}")
    end

    def pkg_update_timeout
      3600 # 1 hour
    end
    def pkg_list_dir
      '/var/lib/pacman'.p
    end

  end
  end
end
