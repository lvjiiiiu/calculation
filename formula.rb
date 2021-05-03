# formulaの責任
# 計算する
# 分析する

class Formula
  attr_accessor :elements
  def initialize(elements)
    @elements = elements
  end

  # 計算する。(パブリックメソッド)
  def calculate
    eval(join_elements)
  end

  private

  # 要素をつなぎ合わせて計算式にする。
  def join_elements
    elements.join
  end
end