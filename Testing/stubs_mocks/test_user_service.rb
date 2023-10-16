require 'test/unit'
require 'mocha/test_unit'

class TestUserService < Test::Unit::TestCase
  def test_get_user_data
    user_id = 1
    api_client_stub = stub('api_client')
    api_client_stub.expects(:get).with("/users/#{user_id}").returns(OpenStruct.new(body: '{"id": 1, "name": "John"}'))

    service = UserService.new(api_client_stub)
    user_data = service.get_user_data(user_id)
    assert_equal('{"id": 1, "name": "John"}', user_data)
  end
end
