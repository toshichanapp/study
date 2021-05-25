# my_coupons = [500coupon, 200coupon, 100coupon]
def select_optimum_combination(amount, my_coupons)
  return [0, 0, 0] if amount <= 1000

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

  def test_select_optimum_combination
    assert_equal [0, 0, 0], select_optimum_combination(1000, [2, 1, 3])
    assert_equal [0, 0, 0], select_optimum_combination(1210, [0, 0, 0])
    assert_equal [2, 1, 0], select_optimum_combination(1210, [2, 1, 3])
    assert_equal [2, 1, 3], select_optimum_combination(1530, [2, 1, 3])
  end
end
