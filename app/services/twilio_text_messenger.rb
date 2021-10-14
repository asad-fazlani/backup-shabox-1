class TwilioTextMessenger
  attr_reader :message

  def initialize(message)
    @message = message
  end

  def call
    client = Twilio::REST::Client.new
    debugger
    client.messages.create({
      from: '+917020145735',
      to: '+917020145735',
      body: message
    })
  end
end