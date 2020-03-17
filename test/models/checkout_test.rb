# require 'test_helper'

class CheckoutTest < ActiveSupport::TestCase

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

  test "checkout is created without params" do
    checkout = Checkout.new
    assert checkout
  end

  test "add options" do
    checkout = Checkout.new( {opt: 'Hola mundo. Esto es una opcion!'} )
    assert_not_empty checkout.options
  end

  test "add two items" do
    checkout = Checkout.new
    checkout.scan( %w(GR1 GR1) )
    assert_equal 2, checkout.items.size
  end

  # Basket: GR1,SR1,GR1,GR1,CF1
  # Total price expected: £22.45
  test "test data 1" do
    checkout = Checkout.new(OPTIONS)
    checkout.scan( %w(GR1 SR1 GR1 GR1 CF1) )
    assert_equal 22.45, checkout.total
  end

  # Basket: GR1,GR1
  # Total price expected: £3.11
  test "test data 2" do
    checkout = Checkout.new(OPTIONS)
    checkout.scan( %w(GR1 GR1) )
    assert_equal 3.11, checkout.total
  end

  # Basket: SR1,SR1,GR1,SR1
  # Total price expected: £16.61
  test "test data 3" do
    checkout = Checkout.new(OPTIONS)
    checkout.scan( %w(SR1 SR1 GR1 SR1) )
    assert_equal 16.61, checkout.total
  end

end
