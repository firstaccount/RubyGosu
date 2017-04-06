class StartBall < Gosu::Image

  attr_reader :x, :y

  def initialize
    @balls << Ball.new(300, 300, self)

  end

  def draw
    super(@x, @y, 1)
  end

  def button_down(id)
    if @balls.length == 0 and @game_over.over == false
      @balls << Ball.new(300, 300, self) if id == Gosu::KbSpace
      @velocity_y *= 1
      @velocity_x = 0
    end
  end
end