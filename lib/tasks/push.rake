namespace :push_line do
  desc "push_line"
  task push_line_message_tasks: :environment do
    message = {
      type: 'text',
      text: '朝です。'
    }
    client = Line::Bot::Client.new { |config|
      config.channel_secret = ENV['LINE_CHANNEL_SECRET']
      config.channel_token = ENV['LINE_CHANNEL_TOKEN']
    }
    response = client.push_message(ENV['LINE_CHANNEL_USER_ID'], message)
    p response
  end
end