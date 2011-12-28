let SessionLoad = 1
if &cp | set nocp | endif
let s:cpo_save=&cpo
set cpo&vim
inoremap <silent> <S-Tab> =BackwardsSnippet()
map! <S-Insert> <MiddleMouse>
snoremap <silent> 	 i<Right>=TriggerSnippet()
nnoremap  :noh/<BS>
snoremap  b<BS>
snoremap ' b<BS>'
vmap ,gq :s/\s\+/ /ggvgq
nmap ,gq :%s/\s\+/ /ggq1G
map ,s :buffers:sb
map ,l :buffers:b
nmap ,cd :cd %:p:h
nmap ,h :windo wincmd K
nmap ,v :windo wincmd H
map Q gq
snoremap U b<BS>U
vmap [% [%m'gv``
snoremap \ b<BS>\
vmap ]% ]%m'gv``
snoremap ^ b<BS>^
vmap _j :call Justify('tw',4)
nmap _j :%call Justify('tw',4)
snoremap ` b<BS>`
vmap a% [%v]%
nmap gx <Plug>NetrwBrowseX
map v 
snoremap <Left> bi
snoremap <Right> a
snoremap <BS> b<BS>
snoremap <silent> <S-Tab> i<Right>=BackwardsSnippet()
nnoremap <silent> <Plug>NetrwBrowseX :call netrw#NetrwBrowseX(expand("<cWORD>"),0)
map <S-Insert> <MiddleMouse>
inoremap <silent> 	 =TriggerSnippet()
inoremap <silent> 	 =ShowAvailableSnips()
imap ,li Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed varius nunc tristique elit congue tristique. Suspendisse sapien ligula, gravida a pharetra eget, commodo ac nisl. Praesent auctor imperdiet luctus. Mauris rutrum, dui ut posuere malesuada, nibh mi aliquam lacus, quis adipiscing sapien felis bibendum tellus. Curabitur convallis augue ut enim faucibus sed iaculis mauris scelerisque. Aliquam in dolor eget tellus egestas ultrices eget ac enim. Etiam volutpat, lorem molestie eleifend accumsan, urna augue luctus felis, id volutpat lectus orci sed odio. Vestibulum diam justo, mollis at dictum et, tristique ac justo. Morbi laoreet nisi eget lacus vehicula molestie. Nullam est lectus, placerat at egestas dignissim, adipiscing eu sapien. Duis sagittis lectus vitae nulla porta molestie. Fusce dui ligula, sollicitudin nec ornare non, dictum et tellus. Maecenas feugiat lacus nec erat vehicula mollis. Nam ut turpis eu ipsum ornare lacinia. Suspendisse potenti. Nam aliquet enim vel ipsum ornare sed convallis augue luctus. Vestibulum in diam ut metus luctus accumsan ut nec tellus. Integer tortor ligula, tempus eu tincidunt sit amet, eleifend id nibh. Vivamus gravida leo quis elit vestibulum tempus gravida orci semper. Quisque aliquet rhoncus molestie.
let &cpo=s:cpo_save
unlet s:cpo_save
set autoindent
set backspace=2
set backup
set expandtab
set fileencodings=ucs-bom,utf-8,default,latin1
set guifont=courier
set helplang=en
set hlsearch
set iminsert=0
set imsearch=0
set mouse=a
set printoptions=paper:letter
set ruler
set runtimepath=~/.vim,/var/lib/vim/addons,/usr/share/vim/vimfiles,/usr/share/vim/vim72,/usr/share/vim/vimfiles/after,/var/lib/vim/addons/after,~/.vim/after,/usr/share/vim/addons/
set shell=bash\ --norc
set shellpipe=2>&1|\ tee
set shiftwidth=4
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc
set tabstop=4
set termencoding=utf-8
set textwidth=78
set viminfo='20,\"50,!
set wildignore=*.class,*.obj,*.o,*.exe,*.jar,*.dsp,*.dsw,*.ncb,*.opt,*.plg,*.*~
set window=40
set nowrapscan
let s:so_save = &so | let s:siso_save = &siso | set so=0 siso=0
let v:this_session=expand("<sfile>:p")
silent only
cd ~/RailsTest/socialgreeting
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +54 spec/models/card_spec.rb
badd +198 spec/models/user_spec.rb
badd +12 ~/.vim/snippets/ruby-rspec.snippets
badd +90 card_user_recipient.txt
badd +18 spec/factories.rb
badd +17 app/models/card.rb
badd +302 spec/controllers/users_controller_spec.rb
badd +12 app/views/users/show.html.erb
badd +63 app/controllers/users_controller.rb
badd +4 app/views/cards/_cards.html.erb
badd +5 app/views/users/index.html.erb
badd +5 app/views/users/_user.html.erb
badd +1 app/views/pages/home.html.erb
badd +247 app/assets/stylesheets/custom.css
badd +190 ~/.vim/snippets/html.snippets
badd +28 lib/tasks/sample_data.rake
badd +7 config/routes.rb
badd +40 spec/controllers/cards_controller_spec.rb
badd +7 app/helpers/sessions_helper.rb
badd +10 app/controllers/cards_controller.rb
badd +1 Gemfile
badd +11 app/views/shared/_card_form.html.erb
badd +6 app/views/users/edit.html.erb
badd +3 app/views/users/send_card.html.erb
badd +9 app/models/user.rb
badd +1 db/migrate/20111219031424_create_cards.rb
badd +1 db/migrate/20111213183145_create_users.rb
badd +10 app/models/signature.rb
badd +2 db/migrate/20111223200029_create_signatures.rb
badd +1 final.txt
badd +5 spec/models/signature_spec.rb
silent! argdel *
edit card_user_recipient.txt
set splitbelow splitright
wincmd _ | wincmd |
split
1wincmd k
wincmd w
set nosplitbelow
set nosplitright
wincmd t
set winheight=1 winwidth=1
exe '1resize ' . ((&lines * 17 + 20) / 41)
exe '2resize ' . ((&lines * 21 + 20) / 41)
argglobal
setlocal keymap=
setlocal noarabic
setlocal autoindent
setlocal balloonexpr=
setlocal nobinary
setlocal bufhidden=
setlocal buflisted
setlocal buftype=
setlocal nocindent
setlocal cinkeys=0{,0},0),:,0#,!^F,o,O,e
setlocal cinoptions=
setlocal cinwords=if,else,while,do,for,switch
setlocal comments=s1:/*,mb:*,ex:*/,://,b:#,:%,:XCOMM,n:>,fb:-
setlocal commentstring=/*%s*/
setlocal complete=.,w,b,u,t,i
setlocal completefunc=
setlocal nocopyindent
setlocal nocursorcolumn
setlocal nocursorline
setlocal define=
setlocal dictionary=
setlocal nodiff
setlocal equalprg=
setlocal errorformat=
setlocal expandtab
if &filetype != ''
setlocal filetype=
endif
setlocal foldcolumn=0
setlocal foldenable
setlocal foldexpr=0
setlocal foldignore=#
setlocal foldlevel=0
setlocal foldmarker={{{,}}}
setlocal foldmethod=manual
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal foldtext=foldtext()
setlocal formatexpr=
setlocal formatoptions=tcq
setlocal formatlistpat=^\\s*\\d\\+[\\]:.)}\\t\ ]\\s*
setlocal grepprg=
setlocal iminsert=0
setlocal imsearch=0
setlocal include=
setlocal includeexpr=
setlocal indentexpr=
setlocal indentkeys=0{,0},:,0#,!^F,o,O,e
setlocal noinfercase
setlocal iskeyword=@,48-57,_,192-255
setlocal keywordprg=
setlocal nolinebreak
setlocal nolisp
setlocal nolist
setlocal makeprg=
setlocal matchpairs=(:),{:},[:]
setlocal modeline
setlocal modifiable
setlocal nrformats=octal,hex
setlocal nonumber
setlocal numberwidth=4
setlocal omnifunc=
setlocal path=
setlocal nopreserveindent
setlocal nopreviewwindow
setlocal quoteescape=\\
setlocal noreadonly
setlocal norightleft
setlocal rightleftcmd=search
setlocal noscrollbind
setlocal shiftwidth=4
setlocal noshortname
setlocal nosmartindent
setlocal softtabstop=0
setlocal nospell
setlocal spellcapcheck=[.?!]\\_[\\])'\"\	\ ]\\+
setlocal spellfile=
setlocal spelllang=en
setlocal statusline=
setlocal suffixesadd=
setlocal swapfile
setlocal synmaxcol=3000
if &syntax != ''
setlocal syntax=
endif
setlocal tabstop=4
setlocal tags=
setlocal textwidth=78
setlocal thesaurus=
setlocal nowinfixheight
setlocal nowinfixwidth
setlocal wrap
setlocal wrapmargin=0
silent! normal! zE
let s:l = 143 - ((9 * winheight(0) + 8) / 17)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
143
normal! 01l
wincmd w
argglobal
edit app/models/signature.rb
setlocal keymap=
setlocal noarabic
setlocal autoindent
setlocal balloonexpr=RubyBalloonexpr()
setlocal nobinary
setlocal bufhidden=
setlocal buflisted
setlocal buftype=
setlocal nocindent
setlocal cinkeys=0{,0},0),:,0#,!^F,o,O,e
setlocal cinoptions=
setlocal cinwords=if,else,while,do,for,switch
setlocal comments=:#
setlocal commentstring=#\ %s
setlocal complete=.,w,b,u,t,i
setlocal completefunc=
setlocal nocopyindent
setlocal nocursorcolumn
setlocal nocursorline
setlocal define=^\\s*#\\s*define
setlocal dictionary=
setlocal nodiff
setlocal equalprg=
setlocal errorformat=
setlocal expandtab
if &filetype != 'ruby'
setlocal filetype=ruby
endif
setlocal foldcolumn=0
setlocal foldenable
setlocal foldexpr=0
setlocal foldignore=#
setlocal foldlevel=0
setlocal foldmarker={{{,}}}
setlocal foldmethod=manual
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal foldtext=foldtext()
setlocal formatexpr=
setlocal formatoptions=croql
setlocal formatlistpat=^\\s*\\d\\+[\\]:.)}\\t\ ]\\s*
setlocal grepprg=
setlocal iminsert=0
setlocal imsearch=0
setlocal include=^\\s*\\<\\(load\\|w*require\\)\\>
setlocal includeexpr=substitute(substitute(v:fname,'::','/','g'),'$','.rb','')
setlocal indentexpr=GetRubyIndent()
setlocal indentkeys=0{,0},0),0],!^F,o,O,e,=end,=elsif,=when,=ensure,=rescue,==begin,==end
setlocal noinfercase
setlocal iskeyword=@,48-57,_,192-255
setlocal keywordprg=ri\ -T
setlocal nolinebreak
setlocal nolisp
setlocal nolist
setlocal makeprg=
setlocal matchpairs=(:),{:},[:]
setlocal modeline
setlocal modifiable
setlocal nrformats=octal,hex
setlocal nonumber
setlocal numberwidth=4
setlocal omnifunc=rubycomplete#Complete
setlocal path=.,~/.rvm/rubies/ruby-1.9.2-p0/lib/ruby/site_ruby/1.9.1,~/.rvm/rubies/ruby-1.9.2-p0/lib/ruby/site_ruby/1.9.1/i686-linux,~/.rvm/rubies/ruby-1.9.2-p0/lib/ruby/site_ruby,~/.rvm/rubies/ruby-1.9.2-p0/lib/ruby/vendor_ruby/1.9.1,~/.rvm/rubies/ruby-1.9.2-p0/lib/ruby/vendor_ruby/1.9.1/i686-linux,~/.rvm/rubies/ruby-1.9.2-p0/lib/ruby/vendor_ruby,~/.rvm/rubies/ruby-1.9.2-p0/lib/ruby/1.9.1,~/.rvm/rubies/ruby-1.9.2-p0/lib/ruby/1.9.1/i686-linux,~/.rvm/gems/ruby-1.9.2-p0/gems/actionmailer-3.1.0/lib,~/.rvm/gems/ruby-1.9.2-p0/gems/actionpack-3.1.0/lib,~/.rvm/gems/ruby-1.9.2-p0/gems/activemodel-3.1.0/lib,~/.rvm/gems/ruby-1.9.2-p0/gems/activerecord-3.1.0/lib,~/.rvm/gems/ruby-1.9.2-p0/gems/activeresource-3.1.0/lib,~/.rvm/gems/ruby-1.9.2-p0/gems/activesupport-3.1.0/lib,~/.rvm/gems/ruby-1.9.2-p0/gems/addressable-2.2.6/lib,~/.rvm/gems/ruby-1.9.2-p0/gems/adsf-1.0.1/lib,~/.rvm/gems/ruby-1.9.2-p0/gems/ansi-1.3.0/lib,~/.rvm/gems/ruby-1.9.2-p0/gems/ansi-1.4.1/lib,~/.rvm/gems/ruby-1.9.2-p0/gems/arel-2.2.1/lib,~/.rvm/gems/ruby-1.9.2-p0/gems/bcrypt-ruby-3.0.1/lib,~/.rvm/gems/ruby-1.9.2-p0/gems/builder-3.0.0/lib,~/.rvm/gems/ruby-1.9.2-p0/gems/coffee-rails-3.1.1/lib,~/.rvm/gems/ruby-1.9.2-p0/gems/coffee-script-2.2.0/lib,~/.rvm/gems/ruby-1.9.2-p0/gems/coffee-script-source-1.1.2/lib,~/.rvm/gems/ruby-1.9.2-p0/gems/coffee-script-source-1.1.3/lib,~/.rvm/gems/ruby-1.9.2-p0/gems/colortail-0.1.7/lib,~/.rvm/gems/ruby-1.9.2-p0/gems/configuration-1.2.0/lib,~/.rvm/gems/ruby-1.9.2-p0/gems/cri-1.0.1/lib,~/.rvm/gems/ruby-1.9.2-p0/gems/diff-lcs-1.1.2/lib,~/.rvm/gems/ruby-1.9.2-p0/gems/diff-lcs-1.1.3/lib,~/.rvm/gems/ruby-1.9.2-p0/gems/directory_watcher-1.3.2/lib,~/.rvm/gems/ruby-1.9.2-p0/gems/erubis-2.7.0/lib,~/.rvm/gems/ruby-1.9.2-p0/gems/execjs-1.2.12/lib,~/.rvm/gems/ruby-1.9.2-p0/gems/execjs-1.2.6/lib,~/.rvm/gems/ruby-1.9.2-p0/gems/factory_girl-1.3.3/lib,~/.rvm/gems/ruby-1.9.2-p0/gems/factory_girl_rails-1.0/lib,~/.rvm/gems/ruby-1.9.2-p0/gems/faker-0.3.1/lib,~/.rvm/gems/ruby-1.9.2-p0/gems/file-tail-1.0.5/lib,~/.rvm/gems/ruby-1.9.2-p0/gems/gravatar_image_tag-0.1.0/lib,~/.rvm/gems/ruby-1.9.2-p0/gems/heroku-1.14.8/lib,~/.rvm/gems/ruby-1.9.2-p0/gems/heroku-1.16.2/lib,~/.rvm/gems/ruby-1.9.2-p0/gems/heroku-2.16.1/lib,~/.rvm/gems/ruby-1.9.2-p0/gems/hike-1.2.1/lib,~/.rvm/gems/ruby-1.9.2-p0/gems/hpricot-0.8.3/lib,~/.rvm/gems/ruby-1.9.2-p0/gems/i18n-0.6.0/lib,~/.rvm/gems/ruby-1.9.2-p0/gems/innate-2010.07/lib,~/.rvm/gems/ruby-1.9.2-p0/gems/jquery-rails-1.0.14/lib,~/.rvm/gems/ruby-1.9.2-p0/gems/jquery-rails-1.0.19/lib,~/.rvm/gems/ruby-1.9.2-p0/gems/json-1.6.3/ext,~/.rvm/gems/ruby-1.9.2-p0/gems/json-1.6.3/ext/json/ext,~/.rvm/gems/ruby-1.9.2-p0/gems/json-1.6.3/lib,~/.rvm/gems/ruby-1.9.2-p0/gems/json_pure-1.4.6/lib,~/.rvm/gems/ruby-1.9.2-p0/gems/kramdown-0.13.1/lib,~/.rvm/gems/ruby-1.9.2-p0/gems/launchy-0.3.7/lib,~/.rvm/gems/ruby-1.9.2-p0/gems/libv8-3.3.10.2-x86-linux/lib,~/.rvm/gems/ruby-1.9.2-p0/gems/little-plugger-1.1.2/lib,~/.rvm/gems/ruby-1.9.2-p0/gems/logging-1.4.3/lib,~/.rvm/gems/ruby-1.9.2-p0/gems/loquacious-1.7.0/lib,~/.rvm/gems/ruby-1.9.2-p0/gems/mail-2.3.0/lib,~/.rvm/gems/ruby-1.9.2-p0/gems/mime-types-1.16/lib,~/.rvm/gems/ruby-1.9.2-p0/gems/mime-types-1.17.2/lib,~/.rvm/gems/ruby-1.9.2-p0/gems/multi_json-1.0.3/lib,~/.rvm/gems/ruby-1.9.2-p0/gems/multi_json-1.0.4/lib,~/.rvm/gems/ruby-1.9.2-p0/gems/nanoc-3.1.6/lib,~/.rvm/gems/ruby-1.9.2-p0/gems/nanoc3-3.1.6/lib,~/.rvm/gems/ruby-1.9.2-p0/gems/nokogiri-1.5.0/lib,~/.rvm/gems/ruby-1.9.2-p0/gems/polyglot-0.3.2/lib,~/.rvm/gems/ruby-1.9.2-p0/gems/polyglot-0.3.3/lib,~/.rvm/gems/ruby-1.9.2-p0/gems/rack-1.2.1/lib,~/.rvm/gems/ruby-1.9.2-p0/gems/rack-1.3.2/lib,~/.rvm/gems/ruby-1.9.2-p0/gems/rack-1.3.5/lib,~/.rvm/gems/ruby-1.9.2-p0/gems/rack-cache-1.0.3/lib,~/.rvm/gems/ruby-1.9.2-p0/gems/rack-mount-0.8.3/lib,~/.rvm/gems/ruby-1.9.2-p0/gems/rack-ssl-1.3.2/lib,~/.rvm/gems/ruby-1.9.2-p0/gems/rack-test-0.6.1/lib,~/.rvm/gems/ruby-1.9.2-p0/gems/rails-3.1.0/lib,~/.rvm/gems/ruby-1.9.2-p0/gems/railties-3.1.0/lib,~/.rvm/gems/ruby-1.9.2-p0/gems/rake-0.8.7/lib,~/.rvm/gems/ruby-1.9.2-p0/gems/rake-0.9.2.2/lib,~/.rvm/gems/ruby-1.9.2-p0/gems/rake-0.9.2/lib
setlocal nopreserveindent
setlocal nopreviewwindow
setlocal quoteescape=\\
setlocal noreadonly
setlocal norightleft
setlocal rightleftcmd=search
setlocal noscrollbind
setlocal shiftwidth=4
setlocal noshortname
setlocal nosmartindent
setlocal softtabstop=0
setlocal nospell
setlocal spellcapcheck=[.?!]\\_[\\])'\"\	\ ]\\+
setlocal spellfile=
setlocal spelllang=en
setlocal statusline=
setlocal suffixesadd=.rb
setlocal swapfile
setlocal synmaxcol=3000
if &syntax != 'ruby'
setlocal syntax=ruby
endif
setlocal tabstop=4
setlocal tags=
setlocal textwidth=78
setlocal thesaurus=
setlocal nowinfixheight
setlocal nowinfixwidth
setlocal wrap
setlocal wrapmargin=0
silent! normal! zE
let s:l = 12 - ((11 * winheight(0) + 10) / 21)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
12
normal! 04l
wincmd w
exe '1resize ' . ((&lines * 17 + 20) / 41)
exe '2resize ' . ((&lines * 21 + 20) / 41)
tabnext 1
if exists('s:wipebuf')
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20 shortmess=filnxtToO
let s:sx = expand("<sfile>:p:r")."x.vim"
if file_readable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &so = s:so_save | let &siso = s:siso_save
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
