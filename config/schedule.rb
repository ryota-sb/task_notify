require File.expand_path(File.dirname(__FILE__) + "/environment")

rails_env = ENV['RAILS_ENV'] || :development

set :environment, rails_env
set :output, "#{Rails.root}/log/cron.log"

# 処理の実行ペース
every 1.minutes do
  rake 'push_line:push_line_message_tasks'
end
