class EmailService
  def initialize(email_client)
    @email_client = email_client
  end

  def send_email(to, subject, body)
    @email_client.send_email(to, subject, body)
  end
end
