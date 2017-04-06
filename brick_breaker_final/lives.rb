class Lives < Gosu::Font

  SIZE = 75

  attr_reader :lives

  def initialize
    super(SIZE)
    @lives = 3
  end

  def draw
    #p "lives.draw"
    super(@lives.to_s, 10, 10, 1, 1, 1, 0xffff_1f2ffaf)    
  end

  def minus_life
    @lives -= 1
    p @lives
  end

end