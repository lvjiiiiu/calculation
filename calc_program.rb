
text = gets.chomp

class Formula
  attr_accessor :text

  def initialize(text)
    @text = text
  end

  def separate_fomula
    text.match(/.\/calc '(.+)'/)[1]
  end
end

formula = Formula.new(text)
p formula.separate_fomula