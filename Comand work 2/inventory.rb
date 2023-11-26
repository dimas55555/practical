class Inventory
  attr_accessor :items

  def initialize(&block)
    @items = []
    instance_eval(&block) if block_given?
  end

  def add_item(item)
    @items << item
  end

  def to_s
    @items.join(", ")
  end
end