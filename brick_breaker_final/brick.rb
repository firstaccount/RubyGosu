class Brick < Gosu::Image

  SPEED = 5
  HEIGHT = 45

  attr_reader :x, :y

  def initialize(x, y)
    #super("images/big_brick.png")
    super("images/brick.png")
    @x = x
    @y = y
  end

  #Makes @x and @y refer to the middle of the image when drawn.
  def draw
    super(@x - half_width, @y - half_height, 1)
  end

  def half_width
    width / 2
  end

  def half_height
    height / 2
  end

  def bounce_off_brick(ball)
    # 1. touch?
    #distance = Gosu.distance(ball.x, ball.y, @x, @y)
    return false if (@x - ball.x).abs >= ball.radius + half_width || (@y - ball.y).abs >= ball.radius + half_height
    # p @x
    # p ball.x
    # p ball.radius 
    # p half_width

    # 2. which side?
    if ball.y - @y == 0
      touch_y = false
    else
      touch_y = (self.width.to_f / self.height).abs >= ((ball.x - @x).to_f/(ball.y - @y)).abs
    end
  
    # 2.1 did it touch_y left side? 
    if touch_y == true
      if @y - ball.y > 0
        side = :top
      else 
        side = :bottom
      end
    else
      if @x - ball.x > 0 
        side = :left
      else
        side = :right
      end
    end

    # 2.2 did it touch right side? 
    # 2.3 did it touch top side? 
    # 2.4 did it touch bottom side? 

    # 3. change direction
    #p side

    ball.bounce_off_brick(side)
    return true
  end

  #Private methods ---------------------------------------------------- 

end