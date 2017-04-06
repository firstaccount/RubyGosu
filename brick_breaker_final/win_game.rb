class GameOver < Gosu::Font

  SIZE = 100

  attr_accessor :over

  def initialize
    super(SIZE)
    @over = false
  end

  def draw
    #p "GAME OVER!!!"
    if @over == true 
    	super("GAME OVER", 100, 200, 1, 1, 1, 0xffff_1f211ffaf)  
    end  
  end

end