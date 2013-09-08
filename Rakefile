require 'rake'
require 'erb'

HOME_DIR = ENV['HOME']

desc 'Hook dotfiles into system-standard positions.'
task :install do
  `git pull` # Update repository if necessary
  install_oh_my_zsh
  
  symlinks = Dir.glob('**/*{.symlink}')
  
  skip_all = false
  overwrite_all = false
  backup_all = false

  symlinks.each do |symlink|
    overwrite = false
    backup = false

    file = symlink.split('/').last.split('.symlink').last
    target = "#{ENV['HOME']}/.#{file}"
 
    if File.exists?(target) || File.symlink?(target)
      if !skip_all && !overwrite_all && !backup_all
        print "File already exists: #{target}, what do you want to do? [s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all: "
        case c = STDIN.gets.chomp
    	  when 'o' then overwrite = true
    	  when 'b' then backup = true
     	  when 'O' then overwrite_all = true
    	  when 'B' then backup_all = true
    	  when 'S' then skip_all = true and puts "Skipping all files"
        when 's' 
    	    puts "Skipping file #{target}"
    	    next
        end
      end
      FileUtils.rm_rf(target) if overwrite || overwrite_all
      `mv "$HOME/.#{file}" "$HOME/.#{file}.backup"` if backup || backup_all
    end
    break if skip_all 
    
    create_symlink("$PWD/#{symlink}", target)
  end

  setup_vim
  install_bin_scripts

  warnings
end

desc 'Revert changes done by installation'
task :uninstall do
  Dir.glob('**/*.symlink').each do |symlink|
    file = symlink.split('/').last.split('.symlink').last
    target = "#{ENV['HOME']}/.#{file}"

    # Remove all symlinks created during installation
    if File.symlink(target)
      FileUtils.rm(target)
    end

    # Replace any backups made during installation
    if File.exists?("#{ENV['HOME']}/.#{file}.backup")
      `mv "$HOME/.#{file}.backup" "$HOME/.#{file}"`
    end
  end
end

task :default => 'install'

def warnings
  puts 
  puts
  puts "NOTE======"
  puts "Make sure you update .gitconfig with your user data"
end

def setup_vim
  vim_path   = File.expand_path('../vim', __FILE__)
  vimrc_path = File.expand_path('../vim/vimrc', __FILE__)
  vim_target = File.join(HOME_DIR, '.vim')
  vimrc_target = File.join(HOME_DIR, '.vimrc')
  
  create_symlink(vimrc_path, vimrc_target, "-sf") 
  create_symlink(vim_path, vim_target, "-sfh")
end 

def create_symlink(source, target, options = '-s')
  puts "ln #{options} #{source} #{target}"
  `ln #{options} "#{source}" "#{target}"`
end

def install_bin_scripts
  FileUtils.mkdir_p(File.join(HOME_DIR, "bin"))

  Dir.glob("#{File.join(ENV['PWD'], "bin")}/**/*").each do |script|
    target = File.join(HOME_DIR, "bin", script.split('/').last)
    create_symlink(script, target, '-sfh')
  end
end

def install_oh_my_zsh
  if File.exist?(File.join(ENV['HOME'], ".oh-my-zsh"))
    puts "Oh My Zsh found at ~/.oh-my-zsh"
  else
    print "Install oh-my-zsh? [ynq] "
    case $stdin.gets.chomp
    when 'y'
      puts "Installing oh-my-zsh"
      system %Q{curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh}
    when 'q'
      exit
    else
      puts "Skipping oh-my-zsh, you will need to change ~/.zshrc"
    end
  end
end

