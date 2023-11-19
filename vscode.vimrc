inoremap kj <Esc>
inoremap <C-g> <Esc>
vnoremap <C-g> <Esc>

nnoremap <leader>// :nohl<CR>

"" Quit
nnoremap <leader>qq workbench.action.closeActiveEditor
nnoremap <leader>q! workbench.action.revertAndCloseActiveEditor
nnoremap <leader>qx workbench.action.reopenClosedEditor
nnoremap <leader>qQ workbench.action.closeAllEditors

"" Files
nnoremap <leader>fs workbench.action.files.save
nnoremap <leader>fd workbench.view.explorer

"" Git
nnoremap <leader>gg workbench.view.scm

nnoremap <C-b> workbench.action.toggleSidebarVisibility

"" Motion
nnoremap K 5k
nnoremap J 5j
nnoremap H ^
nnoremap L $
nnoremap D <C-d>
nnoremap U <C-u>
nnoremap > >>
nnoremap < <<
vnoremap > >gv
vnoremap < <gv
nnoremap s <NOP>

"" g
nnoremap gd editor.action.peekDefinition
nnoremap gD editor.action.revealDefinition
nnoremap gr editor.action.referenceSearch.trigger
nnoremap gt editor.action.peekTypeDefinition
nnoremap go workbench.action.gotoSymbol
nnoremap g. editor.action.quickFix

"" vim_ctrl
nnoremap <leader>o extension.vim_ctrl+o

"" Window management
nnoremap <leader>wv workbench.action.splitEditorRight
nnoremap <leader>ws workbench.action.splitEditorDown
nnoremap <leader>jh workbench.action.previousEditorInGroup
nnoremap <leader>jl workbench.action.nextEditorInGroup
nnoremap <C-l> workbench.action.focusRightGroup
nnoremap <C-h> workbench.action.focusLeftGroup
nnoremap <C-k> workbench.action.focusAboveGroup
nnoremap <C-j> workbench.action.focusBelowGroup
nnoremap <C-t> workbench.action.terminal.toggleTerminal

"" VSCode
nnoremap <leader>p workbench.action.quickOpen
nnoremap sd workbench.action.debug.start
nnoremap sr workbench.action.debug.run
nnoremap ss workbench.action.debug.stop
nnoremap sR workbench.action.debug.restart
""" toggle
nnoremap <leader>tz workbench.action.toggleZenMode
nnoremap <leader>tm editor.action.toggleMinimap
