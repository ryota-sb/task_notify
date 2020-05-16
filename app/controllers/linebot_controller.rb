class LinebotController < ApplicationController
  require 'line/bot'

  protect_from_forgery :except => [:callback]

  def week_tasks(week)
    @tasks = Task.select(:content).where(is_done: false, week: week)
    task_lists = @tasks.map { |task| task.content }
    return task_lists
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
      if event.message['text'].include?('月曜日')
        reply_text_lists.concat(week_tasks('monday'))
      elsif event.message['text'].include?('火曜日')
        reply_text_lists.concat(week_tasks('tuesday'))
      elsif event.message['text'].include?('水曜日')
        reply_text_lists.concat(week_tasks('wednesday'))
      elsif event.message['text'].include?('木曜日')
        reply_text_lists.concat(week_tasks('thursday'))
      elsif event.message['text'].include?('金曜日')
        reply_text_lists.concat(week_tasks('friday'))
      elsif event.message['text'].include?('土曜日')
        reply_text_lists.concat(week_tasks('saturday'))
      elsif event.message['text'].include?('日曜日')
        reply_text_lists.concat(week_tasks('sunday'))
      else
        reply_text_lists.push('そのコマンドはありません')
      end
      case event
      when Line::Bot::Event::Message
        case event.type
        when Line::Bot::Event::MessageType::Text
          message_array = reply_text_lists.map do |reply_text|
            { type: 'text', text: "「#{reply_text}」の時間です！" }
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
end
