require "./program_config"

# UnitConverterの責任：
# 単位を変換する

class UnitConverter
  include ProgramConfig
  attr_accessor :elements
  def initialize(elements)
    @elements = elements
  end

  # 質量を最小(config_unitsで1と設定したもの)に変換
  def convert_to_min
    elements.map do |ele|
      if ele =~ /[0-9]+[a-z]+/
        unit = ele.slice(/[a-z]+/)
        num = ele.slice(/[0-9]+/).to_i
        config_units.map do |key, value|
          if key == unit
            ele = num * value
          end
        end
      end
       ele
    end
  end

  # 最小単位で計算した結果を適切な単位に戻す。
  def convert_to_correct(result)
    config_units.each do |key, value|
      if sort_units.include?(key)
        return ( result / value ).to_s + key
        break
      end
    end
  end


  private

  # 単位のみ収集
  def sort_units
    sort_units = []
    elements.select! do |e|
      if e =~ /[0-9]+[a-z]+/
        sort_units << e.slice(/[a-z]+/)
      else
      end
    end
    return sort_units
  end

end
