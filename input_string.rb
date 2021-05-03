require "./program_config"
# InputStringの責任：
# 入力された文字列の加工、異常系の判定

class InputString
  include ProgramConfig
  attr_accessor :text
  def initialize(text)
    @text = text
  end

  # 異常系の判定
  def judge_abnormal
    config_abnormal(divide_elements)
  end

  # 数式を半角スペースで分割する
  def divide_elements
    separate_fomula.chomp.split(' ')
  end

  private

  # 入力から数式を分離する
  def separate_fomula
    text.match(/.\/calc '(.+)'/)[1]
  end


end