class Score < Gosu::Font

  SIZE = 75

  attr_reader :s

  def initialize
    super(SIZE)
    @s = 0
  end

  def draw
    #p "lives.draw"
    super(@s.to_s, 750, 10, 1, 1, 1, 0xffff_1f2ffaf)    
  end

  def add
    @s += 1
    p @s
  end

end