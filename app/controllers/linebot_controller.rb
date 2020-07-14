class LinebotController < ApplicationController
  require 'line/bot'
  require 'date'

  protect_from_forgery :except => [:callback]

  # 渡されたweekのタスクをリストに格納
  def week_tasks(week)
    tasks = Task.select(:content, :notification_time).order(:notification_time).where(is_done: false, week: week)
    task_lists = tasks.map { |task| "スタート#{task.notification_time.strftime('%H:%M')} / #{task.content}" }
    return task_lists
  end

  # 完了タスクを未完了にする(リセット)
  def reset_tasks(week)
    tasks = Task.where(is_done: true, week: week)
    tasks.update_all(is_done: false)
    return '今日のタスクをリセットしました。明日も頑張りましょう！'
  end

  def callback

    body = request.body.read

    signature = request.env['HTTP_X_LINE_SIGNATURE']
    unless client.validate_signature(body, signature)
      head :bad_request
    end

    events = client.parse_events_from(body)

    events.each do |event|
      reply_text_lists = []
      case event.message['text']
      when '今日のタスク'
        reply_text_lists.concat(week_tasks(get_day_of_the_week))
      when 'リセット'
        reply_text_lists.push(reset_tasks(get_day_of_the_week))
      else
        reply_text_lists.push('そのコマンドはありません')
      end

      case event
      when Line::Bot::Event::Message
        case event.type
        when Line::Bot::Event::MessageType::Text
          message_array = reply_text_lists.map do |reply_text|
            { type: 'text', text: reply_text }
          end
          client.reply_message(event['replyToken'], message_array)
        end
      end
    end
    head :ok
  end

  private
  def client
    @client ||= Line::Bot::Client.new { |config|
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
      config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
    }
  end

  # 今日の曜日をリスト内の文字列で返す
  def get_day_of_the_week
    date = Date.today
    week_lists = ['sunday', 'monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday']
    return week_lists[date.wday]
  end
end
