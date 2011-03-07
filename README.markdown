CootCraig's dotfiles
====================
### symlink from ~/dotfiles to ...
~/dotfiles/symlink.sh    

Git submodules
--------------
See [Pro-Git: Submodules](http://progit.org/book/ch6-6.html)   

### Generate a script with the git submodule add command
    File.open('gitmodules') do |f|
      path = url = ""
      f.each do |line|
        s = line.split('=')
        if s.length == 2
          s[0] = s[0].downcase.strip
          s[1] = s[1].downcase.strip
          if s[0] == "path"
            path = s[1]
            url = ""
          end
          if s[0] == "url"
            url = s[1]
            puts "git submodule add #{url} #{path}"
            path = url = ""
          end
        end
      end
    end

Vim files
---------
### People to watch and copy
[scrooloose_vimviles](https://github.com/scrooloose/vimfiles)    
[corey_haines_vimfiles](https://github.com/coreyhaines/vimfiles)    
[tpope](https://github.com/tpope/tpope)    
[Vimlander-2-The-Quickening](https://github.com/spicycode/Vimlander-2-The-Quickening)   

### Organization of Vim files
~/dotfiles/vim   link to ~/.vim/    
~/dotfiles/vim/vimrc  link to ~/.vimrc    
