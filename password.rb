class String
  def valid_password?
    upper_case = /(?=.*[A-Z])/
    lower_case = /(?=.*[a-z])/
    numerical = /(?=.*[0-9])/
    sign_mark = /(?=.*[!@#\$%\^&\*])/

    if [upper_case, lower_case, numerical, sign_mark].sum{ |regexp| regexp.match?(self) ? 1 : 0 } < 3
      '新しいパスワードは半角数字・半角英小文字・半角英大文字・記号（!@#$%^&*）のうち3種類以上を含むよう入力してください。'
      return false
    end

    if self.length < 8
      '新しいパスワードは8文字以上で入力してください。'
      return false
    end

    true
  end
end

require 'minitest/autorun'

class Stringtest < Minitest::Test
  def test_valid_password
    assert_equal false, 'password'.valid_password?
    assert_equal false, 'PASSWORD'.valid_password?
    assert_equal false, '12345678'.valid_password?
    assert_equal false, '!@#!@#!@#'.valid_password?
    assert_equal false, 'passWORD'.valid_password?
    assert_equal false, 'pass1234'.valid_password?
    assert_equal false, 'pass!@#%'.valid_password?
    assert_equal false, 'PASS1234'.valid_password?
    assert_equal false, 'PASS!@#%'.valid_password?
    assert_equal false, '1234!@#%'.valid_password?
    assert_equal false, 'P@sw0%'.valid_password?
    assert_equal true, 'P@ssw0rd'.valid_password?
  end
end
