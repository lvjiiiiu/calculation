module ProgramConfig
  # keyへ単位、valueへmgを1としたときの比を格納
  # 単位は最も小さいものを1とし、昇順に並べる
  def config_units
    { "mg" => 1, "g" => 1000, "kg" => 1000000 }
  end

  

end

