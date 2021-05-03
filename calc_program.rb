require "/Users/aoiujiie/Desktop/プログラミング学習/ruby/字句解析と単位違いの四則演算/input_string.rb"
require "/Users/aoiujiie/Desktop/プログラミング学習/ruby/字句解析と単位違いの四則演算/formula.rb"
require "/Users/aoiujiie/Desktop/プログラミング学習/ruby/字句解析と単位違いの四則演算/unit_converter.rb"

# 入力された文字列をtextに格納
text = gets.chomp

# 文字列を要素に分解
input_string = InputString.new(text)

# 入力文字列を分析、異常値があればエラー
if input_string.analyze

# 異常なしなら計算を続ける
else
  elements = input_string.divide_elements

  # 単位変換(→mg)
  unit_convert = UnitConverter.new(elements)
  elements_unit_mg = unit_convert.convert_to_mg

  # 計算式を作成。計算
  formula = Formula.new(elements_unit_mg)
  result_for_mg = formula.calculate

  # 計算結果を正しい単位に変換
  answer = unit_convert.convert_unit_to_correct(result_for_mg)

  puts answer
  
end




