if !has('mac') || !has('job')
    finish
endif

let s:switch_script = expand('<sfile>:p:h') . '/switch-im.applescript'
let s:switch_bin = expand('<sfile>:p:h') . '/switch-im.scpt'
if !filereadable(s:switch_bin)
    call job_start(['osacompile', '-o', s:switch_bin, s:switch_script])
endif

let s:get_current_im_cmd = printf('defaults read %s/Library/Preferences/com.apple.HIToolbox.plist AppleCurrentKeyboardLayoutInputSourceID', $HOME)

if !exists('g:autoim_en')
    " com.apple.keylayout.ABC
    let g:autoim_en = 'com.apple.keylayout.US'
endif

function! s:on_enter_insert()
    if exists('b:prev_im') && b:prev_im != g:autoim_en
        call job_start(['osascript', s:switch_bin])
    endif
endfunction

function! s:on_get_current_im(channel, msg)
    let b:prev_im = a:msg
    if b:prev_im != g:autoim_en
        call job_start(['osascript', s:switch_bin])
    endif
endfunction

function! s:on_leave_insert()
    let b:job = job_start(s:get_current_im_cmd, { 'out_cb': 's:on_get_current_im' })
endfunction

autocmd InsertEnter * call s:on_enter_insert()
autocmd InsertLeave * call s:on_leave_insert()
