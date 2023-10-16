class UserService
  def initialize(api_client)
    @api_client = api_client
  end

  def get_user_data(user_id)
    response = @api_client.get("/users/#{user_id}")
    response.body
  end
end
