# InputStringの責任：
# 入力された文字列の加工。

class InputString
  attr_accessor :text
  def initialize(text)
    @text = text
  end

  # 数式を半角スペースで分割する
  def divide_elements
    separate_fomula.chomp.split(' ')
  end

  # 入力から数式を分離する
  def separate_fomula
    text.match(/.\/calc '(.+)'/)[1]
  end

   # 異常系の判定
   def analyze
    divide_elements.each do |e|
      mass_exp = /[0-9]+[a-z]+/
      unit = e.slice(/[a-z]+/)
      correct_units = ["mg", "g", "kg"]

      # 引数の先頭が質量ではなかった場合
      if divide_elements[0] !~ mass_exp
        raise ArgumentError.new("error: first argument must be weight-value(ex: 1kg)")
      elsif (e =~ mass_exp) && !correct_units.any? {|c| unit == c }
        raise ArgumentError.new("error: the unit must be one of mg,g,kg")
      end
    end
    if separate_fomula =~ /[*\/] [0-9]+[a-z]+/
      raise ArgumentError.new("error: multiplier & divisor must be a number at * , \/")
    end
  end

end