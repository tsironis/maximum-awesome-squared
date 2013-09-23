def brew_install(package, *options)
  `brew list #{package}`
  return if $?.success?

  sh "brew install #{package} #{options.join ' '}"
end

def apt_install(package, *options)
  if `apt-cache search #{package}`.empty?
    puts 
    puts "  \e[41m[x] Please install #{package} manually. Search the web for more info\e[0m"
    return
  end

  sh "sudo apt-get install #{package}"
end

def step(description)
  description = "-- #{description} "
  description = description.ljust(80, '-')
  puts
  puts "\e[32m#{description}\e[0m"
end

def app_path(name)
  if mac?
    path = "/Applications/#{name}.app"
    ["~#{path}", path].each do |full_path|
      return full_path if File.directory?(full_path)
    end
  elsif linux?
    full_path = `which #{name}`
    return full_path if File.file?(full_path)
  end

  return nil
end

def mac?()
  return RUBY_PLATFORM.include?('darwin')
end

def linux?()
  return RUBY_PLATFORM.include?('linux')
end

def app?(name)
  return !app_path(name).nil?
end

def link_file(original_filename, symlink_filename)
  original_path = File.expand_path(original_filename)
  symlink_path = File.expand_path(symlink_filename)
  if File.exists?(symlink_path)
    # Symlink already configured properly. Leave it alone.
    return if File.symlink?(symlink_path) and File.readlink(symlink_path) == original_path
    # Never move user's files without creating backups first
    number = 1
    loop do
      backup_path = "#{symlink_path}.bak"
      if number > 1
        backup_path = "#{backup_path}#{number}"
      end
      if File.exists?(backup_path)
        number += 1
        next
      end
      mv symlink_path, backup_path, :verbose => true
      break
    end
  end
  ln_s original_path, symlink_path, :verbose => true
end

namespace :install do
  desc 'Update or Install Brew'
  task :brew do
    step 'Homebrew'
    unless system('which brew > /dev/null || ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"')
      raise "Homebrew must be installed before continuing."
    end
  end

  desc 'Install The Silver Searcher'
  task :the_silver_searcher do
    step 'the_silver_searcher'
    if mac?
      brew_install 'the_silver_searcher'
    elsif linux?
      apt_install 'silversearcher-ag'
    end
  end

  desc 'Install iTerm'
  task :iterm do
    step 'iterm2'
    unless app? 'iTerm'
      system <<-SHELL
        curl -L -o iterm.zip http://iterm2.googlecode.com/files/iTerm2-1_0_0_20120203.zip && \
          unzip iterm.zip && \
          mv iTerm.app /Applications && \
          rm iterm.zip
      SHELL
    end
  end

  desc 'Install ctags'
  task :ctags do
    step 'ctags'
    if mac?
      brew_install 'ctags'
    elsif linux?
      apt_install 'exuberant-ctags'
    end
  end

  desc 'Install reattach-to-user-namespace'
  task :reattach_to_user_namespace do
    step 'reattach-to-user-namespace'
    brew_install 'reattach-to-user-namespace'
  end

  desc 'Install tmux'
  task :tmux do
    step 'tmux'
    if mac?
      brew_install 'tmux'
    elsif linux?
      apt_install 'tmux'
    end
  end

  desc 'Install MacVim'
  task :macvim do
    step 'MacVim'
    unless app? 'MacVim'
      system <<-SHELL
        curl -L -o macvim.tbz https://github.com/downloads/b4winckler/macvim/MacVim-snapshot-64.tbz && \
          bunzip2 macvim.tbz && tar xf macvim.tar && \
          mv MacVim-snapshot-64/MacVim.app /Applications && \
          rm -rf macvim.tbz macvim.tar MacVim-snapshot-64
      SHELL
      system ''
    end

    bin_vim = File.expand_path('~/bin/vim')
    FileUtils.mkdir_p(File.dirname(bin_vim))
    unless File.executable?(bin_vim)
      File.open(bin_vim, 'w', 0744) do |io|
        io << <<-SHELL
#!/bin/bash
exec /Applications/MacVim.app/Contents/MacOS/Vim "$@"
        SHELL
      end
    end
  end

  desc 'Install GVim'
  task :gvim do
    step 'GVim'
    unless app? 'gvim'
      apt_install 'vim-gnome'
    end
  end

  task :iterm2color do
    step 'iterm2 colorschemes'
    colorschemes = `defaults read com.googlecode.iterm2 'Custom Color Presets'`
    dark  = colorschemes !~ /Solarized Dark/
    light = colorschemes !~ /Solarized Light/
    sh('open', '-a', '/Applications/iTerm.app', File.expand_path('iterm2-colors-solarized/Solarized Dark.itermcolors')) if dark
    sh('open', '-a', '/Applications/iTerm.app', File.expand_path('iterm2-colors-solarized/Solarized Light.itermcolors')) if light

    step 'iterm2 profiles'
    puts
    puts "  Your turn!"
    puts
    puts "  Go and manually set up Solarized Light and Dark profiles in iTerm2."
    puts "  (You can do this in 'Preferences' -> 'Profiles' by adding a new profile,"
    puts "  then clicking the 'Colors' tab, 'Load Presets...' and choosing a Solarized option.)"
    puts "  Also be sure to set Terminal Type to 'xterm-256color' in the 'Terminal' tab."
    puts
  end
end

desc 'Symlink config files'
task :symlink do
  step 'symlink'
  link_file 'vim'       , '~/.vim'
  link_file 'tmux.conf' , '~/.tmux.conf'
  link_file 'vimrc'     , '~/.vimrc'
  unless File.exist?(File.expand_path('~/.vimrc.local'))
    cp File.expand_path('vimrc.local'), File.expand_path('~/.vimrc.local'), :verbose => true
  end
end

desc 'Install these config files.'
task :default do
  # Mac vs. Linux different Dependencies
  if mac?
    Rake::Task['install:brew'].invoke
    Rake::Task['install:iterm'].invoke
    Rake::Task['install:macvim'].invoke
  elsif linux?
    Rake::Task['install:gvim'].invoke
  end
  # Common dependencies
  Rake::Task['install:the_silver_searcher'].invoke
  Rake::Task['install:ctags'].invoke
  Rake::Task['install:tmux'].invoke
  Rake::Task['install:reattach_to_user_namespace'].invoke if mac?

  step 'git submodules'
  
  puts "> If you want to add or exclude Vim plugins, please edit .gitmodules file. Continue? (y/n)"
  yes = gets.chomp.downcase
  if yes == 'y'
    submods = Hash.new
     
    %x{git config -f .gitmodules --get-regexp '^submodule\..*\.(path|url)$'}.lines.each do |l|
    submodule, key, value = l.match(/^submodule\.(.*)\.(path|url)\s+(.*)$/)[1..3]
    submods[submodule] = Hash.new unless submods[submodule].is_a?(Hash)
    submods[submodule][key] = value
    end
     
    submods.each_pair do |s,k|
    %x{git submodule add #{k['url']} #{k['path']}}
    end
     
    %x{git submodule sync}
  end

  # TODO install gem ctags?
  # TODO run gem ctags?

  # Symlink config files
  Rake::Task['symlink']

  # Install iTerm 2 colorschemes
  Rake::Task['install:iterm2color'].invoke if mac?

  puts
  puts "  Enjoy!"

end
