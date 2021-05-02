


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
    eval(elements_to_formula).convert_unit_to_correct
  end

  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  # 最小単位で計算した結果を適切な単位に戻す。
  def convert_unit_to_correct
    if unit_array.include?("mg")
      sum_mg.to_s + "mg"
    elsif unit_array.include?("g")
      ( sum_mg / 1000 ).to_s + "g"
    else unit_array.include?("kg")
      ( sum_mg / 1000000 ).to_s + "kg"
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
          ele
        end
      else
        ele
      end
    end
  end


end

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
text = gets.chomp

formula = Formula.new(text)
p formula.calculate


# クラスわけできない(T_T)
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Unitの責任：単位を変換する
# class Unit
#   attr_accessor :elements
#   def initialize(elements)
#     @elements = elements
#   end

#  # 単位を変換する
#   def convert_unit_to_min
#     elements.map! do |ele|
#       if ele =~ /[0-9]+[a-z]+/
#         unit = ele.slice(/[a-z]+/)
#         num = ele.slice(/[0-9]+/)
#         if unit == ["kg"]
#           num*1000000
#         elsif unit == ["g"]
#           num*1000
#         else
#           num*1
#         end
#         unit = "mg"
#       end
#   end


# end
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



  # 異常系の判定
  def analayze
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



