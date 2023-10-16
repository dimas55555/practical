class Database
  def initialize
    @users = []
  end

  def add_user(user)
    @users << user
  end

  def get_users
    @users
  end
end
