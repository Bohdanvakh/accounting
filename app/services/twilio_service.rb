class TwilioService
  def initialize
    @client = Twilio::REST::Client.new(ENV['TWILIO_ACCOUNT_SID'],
                                       ENV['TWILIO_AUTH_TOKEN'])
  end

  def send_sms(user, code)
    @client.messages.create(
      from: ENV['TWILIO_PHONE_NUMBER'],
      to: user.phone_number,
      body: "You confirmation code is: #{code}"
    )
  end
end
