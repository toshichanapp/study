def menu
  [
    { key: 'genovese_m', value: 1000, is_pizza: true },
    { key: 'genovese_l', value: 1400, is_pizza: true },
    { key: 'margherita_m', value: 1200, is_pizza: true },
    { key: 'margherita_l', value: 1800, is_pizza: true },
    { key: 'potato_fries', value: 400, is_pizza: false },
    { key: 'green_salad', value: 500, is_pizza: false },
    { key: 'caesar_salad', value: 600, is_pizza: false },
  ]
end

def menus(menu_list)
  []
end

def calc_amount
  menus.sum{ |hash| hash[:value] }
end

# my_coupons = [500coupon, 200coupon, 100coupon]
def select_optimum_combination(menu_list, my_coupons)
  # calc_amount
  amount = calc_amount(menus)
  can_be_use = menus.any?{ |hash| hash[:is_pizza] }

  # apply_coupon
  return [0, 0, 0, 0] if amount <= 1000

  coupon_500 = amount / 500
  num_500 = [coupon_500, my_coupons[0]].min
  amount = amount - 500 * num_500

  coupon_200 = amount / 200
  num_200 = [coupon_200, my_coupons[1]].min
  amount = amount - 200 * num_200

  coupon_100 = amount / 100
  num_100 = [coupon_100, my_coupons[2]].min
  amount = amount - 100 * num_100

  [num_500, num_200, num_100]
end

require 'minitest/autorun'
class CouponTest < Minitest::Test

  def test_1
    menu_list = [{key: 'genovese_m', num: 1 }]
    my_coupons = [1, 1, 1, 1]
    assert_equal [0, 0, 0, 0], select_optimum_combination(menu_list, my_coupons)
  end

  def test_2
    menu_list = [{ key: 'genovese_m', num: 1 }]
    my_coupons = [0, 0, 0, 0]
    assert_equal [0, 0, 0, 0], select_optimum_combination(menu_list, my_coupons)
  end

  def test_3
    menu_list = [{ key: 'potato_fries', num: 2 }, { key: 'caesar_salad', num: 1 }]
    my_coupons = [2, 1, 2, 1]
    assert_equal [2, 1, 2, 0], select_optimum_combination(menu_list, my_coupons)
  end

  def test_4
    menu_list = [{ key: 'genovese_L', num: 1 }]
    my_coupons = [2, 1, 2, 1]
    assert_equal [2, 0, 0, 1], select_optimum_combination(menu_list, my_coupons)
  end

  def test_5
    menu_list = [{ key: 'genovese_m', num: 1}, { key: 'margherita_m', num: 1 }]
    my_coupons = [3, 3, 4, 2]
    assert_equal [2, 2, 3, 1], select_optimum_combination(menu_list, my_coupons)
  end
end
