# formulaの責任：
# 計算式を計算する

class Formula
  attr_accessor :elements
  def initialize(elements)
    @elements = elements
  end

  # 計算する
  def calculate
    eval(join_elements)
  end

  private

  # 要素をつなぎ合わせて計算式を作成
  def join_elements
    elements.join
  end
end