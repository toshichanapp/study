def menu
  {
    genovese_m: { value: 1000, is_pizza: true },
    genovese_l: { value: 1400, is_pizza: true },
    margherita_m: { value: 1200, is_pizza: true },
    margherita_l: { value: 1800, is_pizza: true },
    potato_fries: { value: 400, is_pizza: false },
    green_salad: { value: 500, is_pizza: false },
    caesar_salad: { value: 600, is_pizza: false }
  }
end

def calc_amount(menu_list)
  menu_list.sum { |name, num| menu[name][:value] * num }
end

def can_be_use_pizza_coupon?(menu_list)
  menu_list.any?{ |name, _num| menu[name][:is_pizza] }
end

def select_optimum_combination(menu_list, my_coupons)
  # calc_amount
  amount = calc_amount(menu_list)
  use_pizza_coupon = can_be_use_pizza_coupon?(menu_list)

  # apply_coupon
  return [0, 0, 0, 0] if amount <= 1000

  coupon_500 = amount / 500
  num_500 = [coupon_500, my_coupons[0], 2].min
  amount = amount - 500 * num_500

  num_pizza = 0
  if use_pizza_coupon
    coupon_pizza = amount / 400
    num_pizza = [coupon_pizza, my_coupons[3], 1].min
    amount = amount - 400 * num_pizza
  end

  coupon_200 = amount / 200
  num_200 = [coupon_200, my_coupons[1], 2].min
  amount = amount - 200 * num_200

  coupon_100 = amount / 100
  num_100 = [coupon_100, my_coupons[2], 3].min
  amount = amount - 100 * num_100

  [num_500, num_200, num_100, num_pizza]
end

require 'minitest/autorun'
class CouponTest < Minitest::Test

  def test_1
    menu_list = { genovese_m: 1 }
    #{ coupon_500: 1, coupon_200: 1, coupon_100: 1, coupon_pizza: 1 }
    my_coupons = [1, 1, 1, 1]
    assert_equal [0, 0, 0, 0], select_optimum_combination(menu_list, my_coupons)
  end

  def test_2
    menu_list = { genovese_m: 1 }
    my_coupons = [0, 0, 0, 0]
    assert_equal [0, 0, 0, 0], select_optimum_combination(menu_list, my_coupons)
  end

  def test_3
    menu_list = { potato_fries: 2, caesar_salad: 1 }
    my_coupons = [2, 1, 2, 1]
    assert_equal [2, 1, 2, 0], select_optimum_combination(menu_list, my_coupons)
  end

  def test_4
    menu_list = { genovese_l: 1 }
    my_coupons = [2, 1, 2, 1]
    assert_equal [2, 0, 0, 1], select_optimum_combination(menu_list, my_coupons)
  end

  def test_5
    menu_list = { genovese_m: 1, margherita_m: 1 }
    my_coupons = [3, 3, 4, 2]
    assert_equal [2, 2, 3, 1], select_optimum_combination(menu_list, my_coupons)
  end
end
