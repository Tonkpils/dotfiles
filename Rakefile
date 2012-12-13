require 'rake'
require 'erb'

desc 'Pull repository'
task :pull do
  "PULLING"
  `git add .`
  `git pull`
end


desc 'Hook dotfiles into system-standard positions.'
task :install do
  `git pull` # Update repository if necessary
  install_oh_my_zsh
  
  linkables = Dir.glob('*/**{.symlink}')
  
  skip_all = false
  overwrite_all = false
  backup_all = false

  linkables.each do |linkable|
    overwrite = false
    backup = false

    file = linkable.split('/').last.split('.symlink').last
    target = "#{ENV['HOME']}/.#{file}"
 
    if File.exists?(target) || File.symlink?(target)
      unless skip_all || overwrite_all || backup_all
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
    
    `ln -s "$PWD/#{linkable}" "#{target}"`
  end
end

desc 'Revert changes done by installation'
task :uninstall do
  Dir.glob('**/*.symlink').each do |linkable|
    file = linkable.split('/').last.split('.symlink').last
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

