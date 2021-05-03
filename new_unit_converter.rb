
# UnitConverterの責任：
# 単位を変換する
class UnitConverter
  attr_accessor :elements
  def initialize(elements)
    @elements = elements
  end

  # 質量をmgに変換
  def convert_to_mg
    elements.map! do |ele|
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

  # 最小単位で計算した結果を適切な単位に戻す。
  def convert_unit_to_correct(result)
    if sort_units.include?("mg")
      result.to_s + "mg"
    elsif sort_units.include?("g")
      ( result / 1000 ).to_s + "g"
    else sort_units.include?("kg")
      ( result / 1000000 ).to_s + "kg"
    end
  end

  private

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

end
