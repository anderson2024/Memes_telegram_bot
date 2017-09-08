require 'telegram/bot'
require 'pry'
token = File.open('token').read
Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    # binding.pry
    case message.text
    when '/start'
      bot.api.sendMessage(chat_id: message.chat.id, text: "Hello, #{message.from.first_name}")
    when '/hello'
      bot.api.sendMessage(chat_id: message.chat.id, text: "How are you?")
    when '/mem'
      io = Faraday::UploadIO.new(Dir.glob("memes/*").sample, 'image/jpeg')
      bot.api.send_photo(chat_id: message.chat.id, photo: io)
    end
  end
end