module UsernameGenerator
  def set_username
    self.username = generated_username if username.blank?
  end

  private

  def generated_username
    curent_unix_time * rand(1...10) + random_number
  end

  def curent_unix_time
    Time.now.to_i
  end

  def random_number
    rand(10**10)
  end
end
