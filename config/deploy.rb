$:.unshift(File.expand_path("~/.rvm/lib"))
require 'rvm/capistrano'
set :rvm_ruby_string, '1.9.2-p180'
set :rvm_type, :user

require 'bundler/capistrano'

set :application, "wedeltube"
set :repository,  "git://github.com/McRip/wedeltube.git"

set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "213.39.233.10"                          # Your HTTP server, Apache/etc
role :app, "213.39.233.10"                          # This may be the same as your `Web` server
role :db,  "213.39.233.10", :primary => true # This is where Rails migrations will run


default_run_options[:pty] = true
ssh_options[:forward_agent] = true
set :deploy_to, "/var/www/wedeltube.de"
set :deploy_via, :remote_cache
set :user, "administrator"
set :use_sudo, true


set :scm, :git
set :scm_username, "mcrip"
set :repository, "git@github.com:McRip/wedeltube.git"
set :branch, "live"
set :git_enable_submodules, 1

namespace :deploy do
  task :start, :roles => :app do
    run "touch #{current_path}/tmp/restart.txt"
  end

  task :stop, :roles => :app do
    # Do nothing.
  end
   task :stop do ; end
   task :restart, :roles => :app, :except => { :no_release => true } do
     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
   end
 end