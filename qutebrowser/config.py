
config.load_autoconfig(True)

# colors
#c.colors.webpage.darkmode.algorithm = 'lightness-cielab'
c.colors.webpage.darkmode.enabled = False
c.editor.command = ['kitty','-e', 'nvim', '{}']
c.editor.encoding = 'utf-8'
c.fonts.default_size = '15pt'
c.statusbar.show = 'always'
c.tabs.show = 'switching'
c.zoom.default = '125%'

# key bindings
config.bind('<Ctrl-E>', 'hint inputs ;; later 50 edit-text', mode='insert')
#config.bind('<Ctrl-E>', 'yank inline', mode='insert')
config.bind('<Alt-Shift-u>', 'spawn --userscript qute-keepassxc --key AEC07DF6961DF8A4F7C23DDCE89F9BCA115E93C1', mode='insert')
config.bind('pw', 'spawn --userscript qute-keepassxc --key AEC07DF6961DF8A4F7C23DDCE89F9BCA115E93C1', mode='normal')
config.bind(',m', 'spawn mpv {url}')
config.bind(',M', 'hint links spawn mpv {hint-url}')
