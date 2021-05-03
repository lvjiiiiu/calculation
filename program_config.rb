module ProgramConfig

  # 単位の設定(keyへ単位、valueへmgを1としたときの比)
  # 単位は最も小さいものを1とし、昇順に並べる
  def config_units
    { "mg" => 1, "g" => 1000, "kg" => 1000000 }
  end

  # 異常系の設定
  def config_abnormal(elements)
    elements.each do |e|

      mass_exp = /[0-9]+[a-z]+/
      unit = e.slice(/[a-z]+/)
      formula = elements.join(" ")

      case
      # 引数の先頭が質量ではなかった場合
      when elements[0] !~ mass_exp
          raise ArgumentError.new("error: first argument must be weight-value(ex: 1kg)")

      # 使用できない単位を使用した時
      when (e =~ mass_exp) && !config_units.any? {|key, hash| unit == key }
          raise ArgumentError.new("error: the unit must be one of #{config_units.keys}")

      # 乗算演算、除算演算の乗数、除数に単位を指定した場合

      when formula =~ /[*\/] [0-9]+[a-z]+/
        raise ArgumentError.new("error: multiplier & divisor must be a number at * , \/")
      end

    end
  end
end

