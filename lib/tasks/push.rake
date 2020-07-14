namespace :push_line do
  desc "push_line"
  task push_line_message_tasks: :environment do

    # 今日の曜日のタスクを配列で取得
    def weekly_tasks(week)
      tasks = Task.select(:content, :notification_time).where(is_done: false, week: week)
      p tasks
      user = User.find(1)
      p user
      binding.pry
      task_lists = tasks.map { |task| "スタート#{task.notification_time.strftime('%H:%M')} / #{task.content}" }
      p task_lists
    end

    def get_user
      
    end

    # 今日の曜日を文字列で取得
    def get_day_of_the_week
      date = Date.today
      week_lists = ['sunday', 'monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday']
      return week_lists[date.wday]
    end
    
    reply_text_lists = []
    reply_text_lists.concat(weekly_tasks(get_day_of_the_week))

    message = reply_text_lists.map do |reply_text|
      { type: 'text', text: reply_text }
    end
    
    client = Line::Bot::Client.new { |config|
      config.channel_secret = ENV['LINE_CHANNEL_SECRET']
      config.channel_token = ENV['LINE_CHANNEL_TOKEN']
    }
    
    response = client.push_message(ENV['LINE_CHANNEL_USER_ID'], message)
    p response
  end
end