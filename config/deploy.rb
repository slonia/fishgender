require 'mina/rails'
require 'mina/git'
require 'mina/rvm'
require 'mina/unicorn'
require 'mina/whenever'

set :application_name, 'fishgender'
set :domain, '37.139.3.131'
set :user, :server
set :deploy_to, '/home/server/apps/fishgender'
set :repository, 'git@github.com:slonia/fishgender.git'
set :branch, 'master'
set :keep_releases, 2
set :rvm_use_path, '/usr/share/rvm/bin/rvm'
# Shared dirs and files will be symlinked into the app-folder by the 'deploy:link_shared_paths' step.
# Some plugins already add folders to shared_dirs like `mina/rails` add `public/assets`, `vendor/bundle` and many more
# run `mina -d` to see all folders and files already included in `shared_dirs` and `shared_files`
set :shared_dirs, fetch(:shared_dirs, []).push('public/assets', 'public/uploads', 'tmp', 'dumps')
set :shared_files, fetch(:shared_files, []).push('config/database.yml', 'config/secrets.yml')
# This task is the environment that is loaded for all remote run commands, such as
# `mina deploy` or `mina rake`.

task :remote_environment do
  # If you're using rbenv, use this to load the rbenv environment.
  # Be sure to commit your .ruby-version or .rbenv-version to your repository.
  # invoke :'rbenv:load'

  # For those using RVM, use this to load an RVM version@gemset.
  invoke :'rvm:use', 'ruby-2.7.2@default'
end

task :setup do
  command %{rvm install ruby-2.7.2}
  command %{gem install bundler:1.13.6}
end

desc "Deploys the current version to the server."
task :deploy do
  # uncomment this line to make sure you pushed your local branch to the remote origin
  # invoke :'git:ensure_pushed'
  deploy do
    # Put things that will set up an empty directory into a fully set-up
    # instance of your project.
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    invoke :'rails:db_migrate'
    invoke :'rails:assets_precompile'
    invoke :'deploy:cleanup'

    on :launch do
      invoke :'whenever:update'
      invoke :'unicorn:restart'
    end
  end

  # you can use `run :local` to run tasks on local machine before of after the deploy scripts
  # run(:local){ say 'done' }
end

# For help in making your deploy script, see the Mina documentation:
#
#  - https://github.com/mina-deploy/mina/tree/master/docs
