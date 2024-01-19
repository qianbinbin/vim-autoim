if !has('mac')
    finish
endif

let s:switch_script = expand('<sfile>:p:h') . '/switch-im.applescript'
let s:switch_bin = expand('<sfile>:p:h') . '/switch-im.scpt'
if !filereadable(s:switch_bin)
    call system('osacompile -o ' . s:switch_bin . ' ' . s:switch_script)
endif

let s:switch_im = 'osascript ' . s:switch_bin

let s:get_current_im = 'defaults read ~/Library/Preferences/com.apple.HIToolbox.plist AppleCurrentKeyboardLayoutInputSourceID'

if !exists('g:autoim_en')
    " com.apple.keylayout.ABC
    let g:autoim_en = 'com.apple.keylayout.US'
endif

function! s:AutoimEnterInsert()
    if exists('b:prev_im') && b:prev_im != g:autoim_en
        call system(s:switch_im)
    endif
endfunction

function! s:AutoimLeaveInsert()
    let b:prev_im = substitute(system(s:get_current_im), '\n$', '', '')
    if b:prev_im != g:autoim_en
        call system(s:switch_im)
    endif
endfunction

autocmd InsertEnter * call s:AutoimEnterInsert()
autocmd InsertLeave * call s:AutoimLeaveInsert()
