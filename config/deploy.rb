# config valid only for Capistrano 3.1
lock '3.2.1'

set :repo_url, 'git@bitbucket.org:fatbulat/ilham.git'
set :application, 'ilham'
application = 'ilham'
set :rvm_type, :user
set :rvm_ruby_version, '2.1.2'
set :deploy_to, '/var/www/apps/ilham'
set :rails_env, 'production'
set :linked_dirs, %w(public/uploads public/social)

slide_count = 3

namespace :git do
  desc 'Deploy'
  task :deploy do
    ask(:message, "Commit message?")
    run_locally do
      execute "git add -A"
      execute "git commit -m '#{fetch(:message)}'"
      execute "git push"
    end
  end
end

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

# Default deploy_to directory is /var/www/my_app
# set :deploy_to, '/var/www/my_app'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, %w{config/database.yml}

# Default value for linked_dirs is []
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5
namespace :unicorn do

  desc 'Start'
  task :start do
    on roles(:all) do
      execute "cd #{current_path} && bundle exec unicorn_rails -c #{current_path}/config/unicorn.rb -E production -D"
    end
  end

  desc 'Restart'
  task :restart do
    on roles(:all) do
      execute "kill -s USR2 `cat #{fetch(:deploy_to)}/run/unicorn.pid`"
    end
  end

  desc 'Stop'
  task :stop do
    on roles(:all) do
      execute "kill -s QUIT `cat #{fetch(:deploy_to)}/run/unicorn.pid`"
    end
  end

  after :finishing, 'deploy:restart'
end

namespace :deploy do

 desc 'Setup'
  task :setup do
    on roles(:all) do
      execute "mkdir  #{shared_path}/config/"
      execute "mkdir  #{shared_path}/img/"
      execute "mkdir  /var/www/apps/#{application}/run/"
      execute "mkdir  /var/www/apps/#{application}/log/"
      execute "mkdir #{shared_path}/system"

      upload!('shared/database.yml', "#{shared_path}/config/database.yml")

      upload!('shared/nginx.conf', "#{shared_path}/nginx.conf")
      sudo 'service nginx stop'
      sudo "ln -sf #{shared_path}/nginx.conf /etc/nginx/conf.d/default.conf"
      sudo 'service nginx start'

      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, "db:create"
        end
      end
    end
  end

  desc 'Create symlink'
  task :symlink do
    on roles(:all) do
      execute "ln -sf #{shared_path}/config/database.yml #{release_path}/config/database.yml"
      execute "ln -sf #{shared_path}/system #{release_path}/public/system"
    end
  end

  desc 'Upload images'
  task :upload_img do
    on roles(:all) do
      slide_count.times do |i|
        upload!("public/slide#{i}.jpg",  "#{shared_path}/img/slide#{i}.jpg")
      end
    end
  end

  desc 'Create symlinks for images'
  task :symlink_img do
    on roles(:all) do
      slide_count.times do |i|
        execute "ln -sf #{shared_path}/img/slide#{i}.jpg #{current_path}/public/slide#{i}.jpg"
      end
    end
  end

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      sudo "service nginx restart"
    end
  end

  after :finishing, 'deploy:cleanup'
  after :finishing, 'deploy:symlink_img'
  after :finishing, 'unicorn:restart'

  after :updating, 'deploy:symlink'

  before :setup, 'deploy:starting'
  before :setup, 'deploy:updating'
  before :setup, 'bundler:install'
end
