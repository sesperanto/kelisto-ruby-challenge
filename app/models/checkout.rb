class Checkout

  PRICES = {
    'GR1' => 3.11,
    'SR1' => 5.00,
    'CF1' => 11.23
  }

  attr_accessor :options, :items

  def initialize(options={})
    self.options = options
  end

  class << self
  end

  def scan(item)
    self.items ||= []
    self.items += [item].flatten
  end

  def total
    self.items.group_by{|x| x}.map do |product, items_product|
      total_product(product, items_product.size)
    end.sum
  end

  private

  def total_product(product, count)
    return 0 if count == 0

    new_count = buy_one_get_one_free(product, count)
    new_prive = price_discount_for_bulk_purchases(product, count)

    return (new_prive * new_count)
  end

  def buy_one_get_one_free(product, count)
    return count if !self.options.key?(product) || !self.options[product][:buy_one_get_one_free]
    return count - (count / 2)
  end

  def price_discount_for_bulk_purchases(product, count)
    return PRICES[product] if !self.options.key?(product) || !self.options[product].key?(:price_discount_for_bulk_purchases)

    price_discount = self.options[product][:price_discount_for_bulk_purchases]
    return count >= price_discount[:greater_than_or_equal] ? price_discount[:new_price] : PRICES[product]
  end

end
