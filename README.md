
# Kelisto Ruby Challenge

## ✨ About
Kelisto's quest for world domination has prompted us to open a convenience store - we sell only three products:

| Product code | Name | Price |
|:---:|---|---:|
| GR1 | Green tea | £3.11 |
| SR1 | Strawberries | £5.00 |
| CF1 | Coffee | £11.23 |

The CEO is a big fan of buy-one-get-one-free offers and of green tea. He wants us to add a rule to do this.

The COO, though, likes low prices and wants people buying strawberries to get a price discount for bulk purchases. If you buy 3 or more strawberries, the price should drop to £4.50

Our check-out can scan items in any order, and because the CEO and COO change their minds often, it needs to be flexible regarding our pricing rules.

The interface to our checkout looks like this (shown in ruby):

```
co = Checkout.new(pricing_rules)
co.scan(item)
co.scan(item)
price = co.total
```

Implement a checkout system that fulfills these requirements.

> Resolution:
> The interface has been implemented to accept some price rules. They must be sent in hash format, which I would be thinking of to save in a configuration yaml.
> An example configuration for a product (GR1), which does have the option of buy-one-get-one-free and price discount for bulk purchases (if you buy more than 3, the price will be £ 4.5).


    	    'GR1' => {
    		    buy_one_get_one_free => true,
    	    	price_discount_for_bulk_purchases => {
    		       greater_than_or_equal => 3,
    		       new_price => 4.5
	    		}
	    	}

> An interface has been created to add products (individually or in an array). At any moment of the process, the "total" action can be executed and it will return the total price of the products according to the established rules).

### Test data
```
Basket: GR1,SR1,GR1,GR1,CF1
Total price expected: £22.45

Basket: GR1,GR1
Total price expected: £3.11

Basket: SR1,SR1,GR1,SR1
Total price expected: £16.61
```

> Resolution:
> I have created some tests with the data sent as examples.

# kelisto-ruby-challenge
