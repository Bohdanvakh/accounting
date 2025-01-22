module PhoneConfirmation
  def set_phone_confirmation_token
    update!(
      phone_confirmation_token: generate_confirmation_token,
      token_sent_at: Time.now
    )
  end

  def token_not_expired?
    token_sent_at + 10.minutes > Time.now
  end

  def confirm_phone(confirmation_code)
    if token_not_expired? && phone_confirmation_token == confirmation_code
      update!(phone_confirmation_token: nil, token_sent_at: nil)
      { success: true, message: 'User was confirmed.' }
    else
      { success: false, error: 'Invalid or expired confirmation code.' }
    end
  end

  private

  def generate_confirmation_token
    SecureRandom.random_number(1_000_000).to_s.rjust(6, '0')
  end
end

