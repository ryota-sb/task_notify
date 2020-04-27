class LinebotController < ApplicationController
  require 'line/bot'

  protect_from_forgery except: [:callback]

  def client
    @client ||= Line::Bot::Client.new do |config|
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
      config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
    end 
  end

  def callback
    body = require.body.read

    signature = request.env['HTTP_X_LINE_SIGNATURE']
    unless client.validate_signature(body.signature)
      head :bad_request
    end

    events = client.parse_events_from(body)
    events.each do |event|
      case event
      when Line::Bot::Event::Message
        case event.type
        when Line::Bot::Event::MessageType::Text
          if event.message['text'].eql?('タスク')
            client.reply_message(event['replyToken'], template)
          end
        end
      end
    end
    head :ok
  end

  private
  
  def template
    {
      "type": "template",
      "altText": "this is a confirm template",
      "template": {
        "type": "confirm",
        "text": "タスクですか？",
        "actions": [
          {
            "type": "message",
            "labal": "タスクです。",
            "text": "タスクです。"
          },
          {
            "type": "message",
            "labal": "タスクではない。",
            "text": "タスクではない。"
          }
        ] 
      }
    }
  end

end
