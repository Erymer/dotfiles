-- Para que funcione hay que correr este comando
-- cd ~/.local/share/nvim/lazy/bracey.vim
-- npm install --prefx server

return {
   "turbio/bracey.vim",
    build = "npm install --prefix ~/.local/share/nvim/lazy/bracey.vim/server"
}
