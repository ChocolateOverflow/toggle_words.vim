" toggle_words.vim
" Authors: Vincent Wang, ChocolateOverflow
" Requires: Vim Ver7.0+
" Version:  1.0

if exists("g:load_toggle_words")
   finish
endif

let s:keepcpo= &cpo
set cpo&vim

let g:load_toggle_words = "1.5"

if exists('g:words_dict')
    for key in keys(g:words_dict)
        if has_key(g:toggle_words_dict, key)
            call extend(g:toggle_words_dict[key], g:words_dict[key])
        else
            let g:toggle_words_dict[key] = g:words_dict[key]
        endif
    endfor
endif

function! s:ToggleWord(reverse)
    let cur_filetype = &filetype
    if ! has_key(g:toggle_words_dict, cur_filetype)
        let words_candicates_array = g:toggle_words_dict['all']
    else
        let words_candicates_array = g:toggle_words_dict[cur_filetype] + g:toggle_words_dict['all']
    endif
    let cur_word = expand("<cword>")
    let word_attr = 0 " 0 - lowercase; 1 - Capital; 2 - uppercase

    if toupper(cur_word)==#cur_word
        let word_attr = 2
    elseif cur_word ==# substitute(cur_word, '.*', '\u\0', '')
        let word_attr = 1
    else
        let word_attr = 0
    endif
    let cur_word = tolower(cur_word)

    for words_candicates in words_candicates_array
        let index = index(words_candicates, cur_word)
        if index != -1
            if a:reverse
              let new_word_index = (index-1)%len(words_candicates)
            else
              let new_word_index = (index+1)%len(words_candicates)
            endif
            let new_word = words_candicates[new_word_index]
            if word_attr==2
                let new_word =toupper(new_word)
            elseif word_attr==1
                let new_word = substitute(new_word, '.*', '\u\0', '')
            else
                let new_word = tolower(new_word)
            endif

            " use the new word to replace the old word
            exec "norm ciw" . new_word . ""
            break
        endif
    endfor
endfunction

command! ToggleWord :call <SID>ToggleWord(0)
command! ToggleWordRev :call <SID>ToggleWord(1)

let &cpo= s:keepcpo
unlet s:keepcpo
