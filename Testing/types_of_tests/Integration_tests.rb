require 'minitest/autorun'
require_relative 'user'
require_relative 'database'

class IntegrationTest < Minitest::Test
  def setup
    @db = Database.new
  end

  def test_user_creation_and_retrieval
    user = User.new('John')
    @db.add_user(user)

    retrieved_users = @db.get_users
    assert_equal 1, retrieved_users.length
    assert_equal 'John', retrieved_users.first.name
    puts "Тест на створення і отримання користувача успішний: користувач #{user.name} доданий у базу даних."
  end
end
