$LOAD_PATH << File.expand_path(File.dirname(__FILE__))
# spec_example.rb
RSpec.describe "Basic Math Operations" do
  it "adds two numbers" do
    result = 1 + 1
    expect(result).to eq(2)
    puts "Тест додавання успішно пройдений!"
  end

  it "subtracts two numbers" do
    result = 3 - 1
    expect(result).to eq(2)
    puts "Тест віднімання успішно пройдений!"
  end

  it "multiplies two numbers" do
    result = 2 * 3
    expect(result).to eq(6)
    puts "Тест множення успішно пройдений!"
  end

  it "divides two numbers" do
    result = 6 / 3
    expect(result).to eq(2)
    puts "Тест ділення успішно пройдений!"
  end
end
