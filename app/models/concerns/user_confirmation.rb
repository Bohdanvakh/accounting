module UserConfirmation
  def set_user_confirmed(confirmation_code)
    if phone_confirmation_token == confirmation_code
      self.update!(phone_confirmation_token: nil, token_sent_at: nil, confirmed: true)
      { success: true, message: 'User was confirmed' }
    else
      { success: false, error: 'Wrong confirmation code' }
    end
  end
end
