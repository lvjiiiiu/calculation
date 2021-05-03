
print "./calc"
# 入力された文字列を取得
text = gets.chomp
formua = text.match(/'(.+)'/)
formua_array = formua[1].split(" ")

# 引数の先頭が質量ではなかった場合
unless formua_array[0] =~ /[0-9]+[a-z]+/
  puts "error: first argument must be weight-value (ex: 1kg) (ArgumentError)"
end
# 使用できない単位を使用した時
if formua_array[0].slice(/[a-z].+/) != ("kg" || "g" || "mg")
  puts "error: the unit must be one of mg,g,kg (ArgumentError) "
else

  calc_array =[]
  unit_array = []
 
  formua_array.each do |ele|
    # eleが質量だった場合、ひとまずmgに変換
    if ele =~ /"[0-9]+[a-z]+"/
      # 単位をunit_array配列に格納
      unit_array << ele.slice(/[a-z]+/)
      # calc_to_mgメソッドでmg単位に変換したものをcalc_arrayに格納
      num_mg = calc_to_mg(ele)
      calc_array << num_mg

    # eleが+ or -だった場合
    else ele == ("+" || "-")
      sym = ele.slice(/[+-]/)
      calc_array << sym
    end
  end
end

# calc_arrayの要素を連結
calc_string = calc_array.join
# 文字列をコードとして実行
sum_mg = eval(calc_string)


# 最後にmgからそれぞれ正しい単位に変換
if unit_array.include?("mg")
  sum_mg.to_s + "mg"
elsif unit_array.include?("g")
  ( sum_mg / 1000 ).to_s + "g"
else unit_array.include?("kg")
  ( sum_mg / 1000000 ).to_s + "kg"
end


# 質量をmgに変換するメソッド
def calc_to_mg(ele)
  unit = ele.slice(/[a-z]+/)
  num = ele.slice(/[0-9]+/)

  if unit == ["kg"]
    unit*1000000
  elsif unit == ["g"]
    unit*1000
  else
    unit*1000
  end
end
