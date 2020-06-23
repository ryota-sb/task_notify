$worker  = 2
$timeout = 30
$app_dir = "/var/www/rails/task_notify/current"
$listen  = File.expand_path 'tmp/unicorn.sock', $app_dir
$pid     = File.expand_path 'tmp/pids/unicorn.pid', $app_dir
$std_log = File.expand_path 'log/unicorn.log', $app_dir

worker_processes $worker
working_directory $app_dir
stderr_path $std_log
stdout_path $std_log
timeout $timeout
listen $listen
pid $pid

# ホットデプロイの有無
preload_app true

# fork前に行うことを定義
before_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.connection.disconnect!
  old_pid = "#{server.config[:pid]}.oldbin"
  if old_pid != server.pid
    begin
      Process.kill "QUIT", File.read(old_pid).to_i
    rescue Errno::ENOENT, Errno::ESRCH
    end
  end
end

# fork後に行うことを定義
after_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Bass.establish_connection
end