function ds --wraps='du -hc | sort -h' --description 'alias ds=du -hc | sort -h'
  du -hc | sort -h $argv
        
end
