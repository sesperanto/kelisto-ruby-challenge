require "minitest/autorun"
require_relative '../lib/checkout'

class CheckoutTest < Minitest::Test

  OPTIONS = {
    'GR1' => {
      buy_one_get_one_free: true
    },
    'SR1' => {
      price_discount_for_bulk_purchases: {
        greater_than_or_equal: 3,
        new_price:             4.5
      }
    }
  }

  def checkout_is_created_without_params
    checkout = Checkout.new
    assert checkout
  end

  def add_options
    checkout = Checkout.new( {opt: 'Hola mundo. Esto es una opcion!'} )
    assert_not_empty checkout.options
  end

  def add_two_items
    checkout = Checkout.new
    checkout.scan( %w(GR1 GR1) )
    assert_equal 2, checkout.items.size
  end

  # Basket: GR1,SR1,GR1,GR1,CF1
  # Total price expected: £22.45
  def test_data_1
    checkout = Checkout.new(OPTIONS)
    checkout.scan( %w(GR1 SR1 GR1 GR1 CF1) )
    assert_equal 22.45, checkout.total
  end

  # Basket: GR1,GR1
  # Total price expected: £3.11
  def test_data_2
    checkout = Checkout.new(OPTIONS)
    checkout.scan( %w(GR1 GR1) )
    assert_equal 3.11, checkout.total
  end

  # Basket: SR1,SR1,GR1,SR1
  # Total price expected: £16.61
  def test_data_3
    checkout = Checkout.new(OPTIONS)
    checkout.scan( %w(SR1 SR1 GR1 SR1) )
    assert_equal 16.61, checkout.total
  end

  # Basket: empty
  # Total price expected: £0
  def test_data_4
    checkout = Checkout.new(OPTIONS)
    checkout.scan( %w() )
    assert_equal 0, checkout.total
  end

end
