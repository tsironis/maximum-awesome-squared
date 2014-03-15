def link_file(original_filename, symlink_filename)
  original_path = File.expand_path(original_filename)
  symlink_path = File.expand_path(symlink_filename)
  if File.exists?(symlink_path) || File.symlink?(symlink_path)
    if File.symlink?(symlink_path)
      symlink_points_to_path = File.readlink(symlink_path)
      return if symlink_points_to_path == original_path
      # Symlinks can't just be moved like regular files. Recreate old one, and
      # remove it.
      ln_s symlink_points_to_path, get_backup_path(symlink_path), :verbose => true
      rm symlink_path
    else
      # Never move user's files without creating backups first
      mv symlink_path, get_backup_path(symlink_path), :verbose => true
    end
  end
  ln_s original_path, symlink_path, :verbose => true
end
def get_backup_path(path)
  number = 1
  backup_path = "#{path}.bak"
  loop do
    if number > 1
      backup_path = "#{backup_path}#{number}"
    end
    if File.exists?(backup_path) || File.symlink?(backup_path)
      number += 1
      next
    end
    break
  end
  backup_path
end
def install_github_bundle(user, package)
  unless File.exist? File.expand_path("~/.vim/bundle/#{package}")
    sh "git clone https://github.com/#{user}/#{package} ~/.vim/bundle/#{package}"
  end
end
def step(description) 
  description = "-- #{description} " 
  description = description.ljust(80, '-') 
  puts 
  puts "\e[32m#{description}\e[0m" 
end
desc 'Install these config files.'
task :default do
  step 'symlink'
  link_file 'vim'                   , '~/.vim'
  link_file 'vimrc'                 , '~/.vimrc'
  link_file 'vimrc.bundles'         , '~/.vimrc.bundles'
  link_file 'vimrc.bundles.local'   , '~/.vimrc.bundles.local'
  install_github_bundle 'gmarik','vundle'
  sh 'vim -c "BundleInstall" -c "q" -c "q"'
end
