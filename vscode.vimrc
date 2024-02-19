"" basic
inoremap kj <Esc>
inoremap <C-g> <Esc>
vnoremap <C-g> <Esc>

"" motion
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

"" +file
nnoremap <leader>fs workbench.action.files.save
nnoremap <leader>fd workbench.view.explorer
nnoremap <leader>fg workbench.view.search
nnoremap <leader>fk workbench.view.scm

"" +quit
nnoremap <leader>qq workbench.action.closeActiveEditor
nnoremap <leader>qa workbench.action.closeAllEditors
nnoremap <leader>qx workbench.action.reopenClosedEditor
nnoremap <leader>q! workbench.action.revertAndCloseActiveEditor

"" +window
nnoremap <leader>wv workbench.action.splitEditorRight
nnoremap <leader>ws workbench.action.splitEditorDown
nnoremap <leader>w[ workbench.action.previousEditorInGroup
nnoremap <leader>w] workbench.action.nextEditorInGroup
nnoremap <C-l> workbench.action.focusRightGroup
nnoremap <C-h> workbench.action.focusLeftGroup
nnoremap <C-k> workbench.action.focusAboveGroup
nnoremap <C-j> workbench.action.focusBelowGroup
nnoremap <C-t> workbench.action.terminal.toggleTerminal

"" +toggle
nnoremap <leader>th :nohl<CR>
nnoremap <leader>tz workbench.action.toggleZenMode
nnoremap <leader>tm editor.action.toggleMinimap

"" +buffer
nnoremap <leader>bb :buffers<CR>

"" +debug
nnoremap <leader>dc workbench.action.debug.start
nnoremap <leader>ds workbench.action.debug.stop
nnoremap <leader>dr workbench.action.debug.restart
nnoremap <leader>db editor.debug.action.toggleBreakpoint
nnoremap <leader>do workbench.action.debug.stepOver
nnoremap <leader>di workbench.action.debug.stepInto
nnoremap <leader>du workbench.action.debug.stepOut
nnoremap <leader>dR workbench.action.debug.run

"" prefix g
nnoremap gd editor.action.peekDefinition
nnoremap gD editor.action.revealDefinition
nnoremap gi editor.action.peekImplementation
nnoremap gI editor.action.revealImplementation
nnoremap gt editor.action.peekTypeDefinition
nnoremap gT editor.action.revealTypeDefinition
nnoremap gr editor.action.referenceSearch.trigger
nnoremap go workbench.action.gotoSymbol
nnoremap g. editor.action.quickFix
nnoremap gf editor.action.formatDocument
nnoremap gF gg=G``

"" prefix [
nnoremap [t workbench.action.previousEditorInGroup
nnoremap [d editor.action.marker.previous

"" prefix ]
nnoremap ]t workbench.action.nextEditorInGroup
nnoremap ]d editor.action.marker.next

"" VSCode
nnoremap <C-b> workbench.action.toggleSidebarVisibility
nnoremap <leader>p workbench.action.quickOpen
nnoremap <leader>o extension.vim_ctrl+o

