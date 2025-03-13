class ConfirmationTokenGenerator
  def self.generate
    SecureRandom.urlsafe_base64(6)
  end
end
