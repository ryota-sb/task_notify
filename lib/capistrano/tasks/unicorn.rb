# unicornのpidファイル、設定ファイルのディレクトリを指定
namespace :unicorn do
  task :environment do
    set :unicorn_pid, "#{current_path}/tmp/pids/unicorn.pid"
    set :unicorn_config, "#{current_path}/config/unicorn/production.rb"
  end

  # unicornを起動するメソッド
  def start_unicorn
    within current_path do
      execute :bundle, :exec, :unicorn, "-c #{fetch(:unicorn_config)} -E #{fetch(:rails_env)} -D"
    end
  end

  # unicornを停止するメソッド
  def stop_unicorn
    execute :kill, "-s QUIT $(< #{fetch(:unicorn_pid)})"
  end

  # unicornを再起動するメソッド
  def reload_unicorn
    execute :kill, "-s USR2 $(< #{fetch(:unicorn_pid)})"
  end

  # unicornを強制終了するメソッド
  def force_stop_unicorn
    execute :kill, "$(< #{fetch(:unicorn_pid)})"
  end

  # unicornをスタートさせるタスク
  desc "Start unicorn server"
  task start: :environment do
    on roles(:app) do
      start_unicorn
    end
  end

  # unicornを停止させるタスク
  desc "Stop unicorn server gracefully"
  task stop: :environment do
    on roles(:app) do
      stop_unicorn
    end
  end

  # unicornが起動している場合は再起動、起動していない場合は起動
  desc "Restart unicorn server gracefully"
  task restart: :environment do
    on roles(:app) do
      if test("[-f #{fetch(:unicorn_pid)} ]")
        reload_unicorn
      else
        start_unicorn
      end
    end
  end

  # unicornを強制終了させるタスク
  desc "Stop unicorn server immediately"
  task force_stop: :environment do
    on roles(:app) do
      force_stop_unicorn
    end
  end
end