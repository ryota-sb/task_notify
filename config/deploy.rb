# capistranoのバージョン
lock "~> 3.14.1"

# デプロイするアプリ名
set :application, "task_notify"

# cloneするgitリポジトリ
set :repo_url, "git@github.com:ryota-sb/task_notify.git"

# デプロイするブランチ
set :branch, 'master'

# デプロイ先のディレクトリ
set :deploy_to, '/var/www/rails/task_notify'

# シンボリックリンクをはるファイル
set :linked_files, fetch(:linked_files, []).push('config/settings.yml')

# シンボリックリンクをはるフォルダ
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# 保持するバージョンの個数
set :keep_releases, 5

# rubyバージョン
set :rbenv_ruby, '2.5.5'

# 出力するログレベル
set :log_level, :debug

# --deployment` フラグは deprecated だと言われたときの対処用
set :bundle_flags,    '--quiet'
set :bundle_path,     nil
set :bundle_without,  nil

namespace :deploy do
  desc 'Restart application'
  task :restart do
    invoke 'unicorn:restart'
  end

  desc 'Create database'
  task :db_create do
    on roles(:db) do |host|
      with rails_env: fetch(:rails_env) do
        within current_path do
          execute :bundle, :exec, :rails, 'db:create'
        end
      end
    end
  end

  desc 'Run seed'
  task :seed do
    on roles(:app) do
      with rails_env: fetch(:rails_env) do
        within current_path do
          execute :bundle, :exec, :rails, 'db:seed'
        end
      end
    end
  end

  desc 'Config bundler'
  task :config_bundelr do
    on roles(/.*/) do
      within release_path do
        execute :bundle, :config, '--local deployment true'
        execute :bundle, :config, '--local without "development test"'
        execute :bundle, :config, "--local path #{shared_path.join('bundle')}"
      end
    end
  end

  before 'bundler:install', 'deploy:config_bundler'

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :group, limit: 3, wait: 10 do
    end
  end
end