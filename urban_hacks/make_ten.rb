# frozen_string_literal: true

class RPN
  class NotPolErr < StandardError; end

  def self.validation(arr)
    # [1, 7, 3, "/", "+", 3, "*"] => true
    # [1, 7, 3, "/", "+", "*", 3] => false
    nums = []
    opes = []
    arr.each do |item|
      if item.instance_of?(Integer)
        nums << item
      else
        opes << item
      end

      raise NotPolErr if nums.size <= opes.size
    end
    true
  rescue NotPolErr => _e
    false
  end

  def self.pol_to_ind(formula)
    stack = []
    formula.each do |item|
      if item.instance_of?(Integer)
        stack << item
      else
        a, b = stack.pop(2)
        stack << "(#{a}#{item}#{b})"
      end
    end
    stack.pop.gsub(/\d/) { |s| "#{s}r" }
  end
end

class MakeTen
  OPES = %w[+ - * /].freeze
  def self.formula_list(arr)
    OPES.repeated_combination(arr.length - 1).map do |ope_arr|
      (arr + ope_arr).permutation.select do |nums_with_opes|
        RPN.validation(nums_with_opes)
      end.uniq
    end
  end

  def self.result_formula(list)
    list.flatten(1).map do |formula|
      ind = RPN.pol_to_ind(formula)
      [formula, ind, eval(ind)]
    rescue ZeroDivisionError => _e
      nil
    end
  end
end

def main
  # [[3,4,7,8], [1,3,3,7]]
  arr = [1, 3, 3, 7]
  ans = MakeTen.result_formula(MakeTen.formula_list(arr)).select { |_f, _ind, ans| ans.to_f == 10.0 }
  p ans
end
main
