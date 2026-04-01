scriptencoding utf-8

let g:airline#themes#habamax#palette = {}

" Palette tuned to habamax-like dark purple/blue tones.
let s:airline_a_normal = [ '#1a1a2e', '#9ece6a', 234, 149, 'bold' ]
let s:airline_b_normal = [ '#c0caf5', '#24283b', 189, 235, '' ]
let s:airline_c_normal = [ '#a9b1d6', '#1f2335', 146, 234, '' ]
let g:airline#themes#habamax#palette.normal =
      \ airline#themes#generate_color_map(s:airline_a_normal, s:airline_b_normal, s:airline_c_normal)

let s:airline_a_insert = [ '#1a1a2e', '#7dcfff', 234, 117, 'bold' ]
let s:airline_b_insert = [ '#c0caf5', '#2a2f45', 189, 236, '' ]
let s:airline_c_insert = [ '#a9b1d6', '#1f2335', 146, 234, '' ]
let g:airline#themes#habamax#palette.insert =
      \ airline#themes#generate_color_map(s:airline_a_insert, s:airline_b_insert, s:airline_c_insert)

let g:airline#themes#habamax#palette.terminal = copy(g:airline#themes#habamax#palette.insert)

let s:airline_a_replace = [ '#1a1a2e', '#f7768e', 234, 210, 'bold' ]
let s:airline_b_replace = [ '#c0caf5', '#2a2f45', 189, 236, '' ]
let s:airline_c_replace = [ '#a9b1d6', '#1f2335', 146, 234, '' ]
let g:airline#themes#habamax#palette.replace =
      \ airline#themes#generate_color_map(s:airline_a_replace, s:airline_b_replace, s:airline_c_replace)

let s:airline_a_visual = [ '#1a1a2e', '#e0af68', 234, 179, 'bold' ]
let s:airline_b_visual = [ '#c0caf5', '#2a2f45', 189, 236, '' ]
let s:airline_c_visual = [ '#a9b1d6', '#1f2335', 146, 234, '' ]
let g:airline#themes#habamax#palette.visual =
      \ airline#themes#generate_color_map(s:airline_a_visual, s:airline_b_visual, s:airline_c_visual)

let s:airline_a_inactive = [ '#6b7089', '', 60, '', '' ]
let s:airline_b_inactive = [ '#6b7089', '', 60, '', '' ]
let s:airline_c_inactive = [ '#6b7089', '', 60, '', '' ]
let g:airline#themes#habamax#palette.inactive =
      \ airline#themes#generate_color_map(s:airline_a_inactive, s:airline_b_inactive, s:airline_c_inactive)

let g:airline#themes#habamax#palette.accents = {
      \ 'red': [ '#f7768e', '', 210, '', '' ],
      \ }
