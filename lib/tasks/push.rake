namespace :push_line do
  desc "push_line"
  task push_line_message_tasks: :environment do

    # 今日の曜日のタスクを配列で取得
    def weekly_tasks(week)
      tasks = Task.select(:content, :notification_time).where(is_done: false, week: week)
      task_lists = tasks.map { |task| "#{task.notification_time.strftime('%H:%M')}になりました。 #{task.content}の時間です。" }
      
      # 現在時刻と通知時間が同じタスクを配列に入れる
      current_time_task = task_lists.select do |task_list|
        current_time = Time.now.strftime('%H:%M')
        lists = []
        lists.push(task_list) if task_list.include?(current_time)
      end
      current_time_task
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
    
    # Lineのアカウント取得
    client = Line::Bot::Client.new { |config|
      config.channel_secret = ENV['LINE_CHANNEL_SECRET']
      config.channel_token = ENV['LINE_CHANNEL_TOKEN']
    }
    
    unless message.empty?
      response = client.push_message(ENV['LINE_CHANNEL_USER_ID'], message)
    end
  end
end