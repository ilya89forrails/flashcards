
server '139.162.177.75'

set :application, 'flashcards'
set :repo_url, 'https://github.com/ilya89forrails/flashcards'
set :branch, 'master'
set :rbenv_ruby, '2.3.1'
set :user, 'deployer'
set :deploy_to, '~/applications/flashcards'
set :ssh_options, user: 'deployer',
                  keys: ['~/.ssh/id_rsa']
