
text = gets.chomp

# Formulaの責任：数式を分類する。(加工する)
class Formula
  attr_accessor :text

  def initialize(text)
    @text = text
  end

  # 入力から数式を分離する
  def separate_fomula
    text.match(/.\/calc '(.+)'/)[1]
  end

  # 分離した数式を半角スペースで分割する
  def divide_element
    separate_fomula.chomp.split(' ')
  end

  def aaa
    divide_element
  end 

  

  # 異常系の判定
  def analayze
    valid_unit = ["kg", "g", "mg"]
    divide_element.each do |e|
      
      # 引数の先頭が質量ではなかった場合
      if divide_element[0] !~ /[0-9]+[a-z]+/
        puts "あとで例外にする"
      elsif (e =~ /[0-9]+[a-z]+/) && e.slice(/[a-z]+/)!= ("kg" || "g" || "mg")
        p "あとで例外にする2"
        p e
      else
      end
    end
  end

  

  

  # 分離した数式を分解しそれぞれのパーツに分ける
  def sort_element
    without_operators = []
    units = []
    operators = []

    divide_element.each do |e|
        # 要素が質量もしくは除数 or 乗数の場合
      if e =~ /[0-9]+[a-z]*/
        # 算術演算子を除いた要素をwithout_operatorsへ格納
        without_operators << e.slice(/[0-9]+[a-z]*/)
        # 単位をunitsに格納
        units << e.slice(/[a-z]+/)
      elsif e =~ /[+*\-\/]/
        operators << e.slice(/[+*\-\/]/)
      else
        p "あとで例外にする"
      end
    end
 
  end
end



# Unitの責任：単位を変換する
class Unit
  def initialize(unit)
    @unit = unit
  end
end

formula = Formula.new(text)
formula.sort_element
formula.analayze

