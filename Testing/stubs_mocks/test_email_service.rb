require 'test/unit'
require 'mocha/test_unit'

class TestEmailService < Test::Unit::TestCase
  def test_send_email
    email_client_mock = mock('email_client')
    email_client_mock.expects(:send_email).with('recipient@example.com', 'Test Subject', 'Test Body').once

    service = EmailService.new(email_client_mock)
    service.send_email('recipient@example.com', 'Test Subject', 'Test Body')
  end
end
