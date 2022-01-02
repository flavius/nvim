vim.cmd [[
hi! ExtraWhitespace guifg=red
try
  colorscheme darkplus
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry
]]
