
# Formulaの責任：
# 数式を分析する。(加工する)
# 数式を計算する。
class Formula
  attr_accessor :text
  def initialize(text)
    @text = text
  end

  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  # 数式を半角スペースで分割する
  def divide_element
    separate_fomula.chomp.split(' ')
  end

  # 入力から数式を分離する
  def separate_fomula
    text.match(/.\/calc '(.+)'/)[1]
  end

  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  # 要素をつなぎ合わせて計算式にする。
  def elements_to_formula
    convert_unit_to_min.join
  end

  # 計算する。(パブリックメソッド)
  def calculate
    if analyze
    else
      sum_min_unit = eval(elements_to_formula)
      convert_unit_to_correct(sum_min_unit)
    end
  end

  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  # 単位のみ収集
  def sort_units
    sort_units = []
    divide_element.select! do |e|
      if e =~ /[0-9]+[a-z]+/
        sort_units << e.slice(/[a-z]+/)
      else
      end
    end
    return sort_units
  end

  # 最小単位で計算した結果を適切な単位に戻す。
  def convert_unit_to_correct(sum)
    if sort_units.include?("mg")
      sum.to_s + "mg"
    elsif sort_units.include?("g")
      ( sum / 1000 ).to_s + "g"
    else sort_units.include?("kg")
      ( sum / 1000000 ).to_s + "kg"
    end
  end


  # 質量を単位レパートリーの中で最小のものに変換
  def convert_unit_to_min
    divide_element.map! do |ele|
      if ele =~ /[0-9]+[a-z]+/
        unit = ele.slice(/[a-z]+/)
        num = ele.slice(/[0-9]+/).to_i
        if unit == "kg"
          num * 1000000
        elsif unit == "g"
          num * 1000
        else
          num
        end
      else
        ele
      end
    end
  end

#  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  # 異常系の判定
  def analyze
    divide_element.each do |e|
      mass_exp = /[0-9]+[a-z]+/
      unit = e.slice(/[a-z]+/)
      correct_units = ["mg", "g", "kg"]

      # 引数の先頭が質量ではなかった場合
      if divide_element[0] !~ mass_exp
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

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# 呼び出し
text = gets.chomp
formula = Formula.new(text)
p formula.calculate





