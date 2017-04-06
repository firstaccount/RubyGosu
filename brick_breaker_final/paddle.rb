class Paddle < Gosu::Image

  SPEED = 10
  HEIGHT = 50

  attr_reader :x, :y

  def initialize(window)
    super("images/bar.png")
    @x = window.width / 2
    @y = window.height - HEIGHT
    @velocity = SPEED
    @window = window
    # p "paddle: "
    # p width
    # p height
  end

  #Makes @x and @y refer to the middle of the image when drawn.
  def draw
    super(@x - half_width, @y - half_height, 1)
    #super(@x, @y, 1)
  end

  def move(direction)
    @x += @velocity if direction == :right
    @x -= @velocity if direction == :left
  end

  def half_width
    width / 2
  end

  def half_height
    height / 2
  end

  def bounce_off(ball)
    # 1. touch?
    #distance = Gosu.distance(ball.x, ball.y, @x, @y)
    return false if (@x - ball.x).abs >= ball.radius + half_width || (@y - ball.y).abs >= ball.radius + half_height

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
    # 3. change direction
    p side

    ball.bounce_off_brick(side)
    return true
  end
  #Private methods ---------------------------------------------------- 

end