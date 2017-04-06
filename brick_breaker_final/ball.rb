class Ball < Gosu::Image

  SPEED = 5

  attr_reader :x, :y, :velocity_x, :velocity_x

  def initialize(x, y, window)
    super("images/blue_ball.png")
    @x = x
    @y = y
    @velocity_x = SPEED
    @velocity_y = SPEED
    @window = window
    @velocity_x_bak = 0
    @velocity_y_bak = 0
  end

  #Makes @x and @y refer to the middle of the image when drawn.
  def draw
    super(@x - radius, @y - radius, 1)
    #super(@x, @y, 1)
  end

  def change_speed(velocity_x, velocity_y)
  	@velocity_x = velocity_x
    @velocity_y = velocity_y
  end

  def pause
  	if @velocity_x != 0
  	  @velocity_x_bak = @velocity_x
      @velocity_y_bak = @velocity_y
      @velocity_x = 0
      @velocity_y = 0
	  end 
  end
  def unpause
  	if @velocity_x == 0
      @velocity_x = @velocity_x_bak
      @velocity_y = @velocity_y_bak
    end
  end

  def move
    move_position
    bounce_off_walls
  end

  #Helper methods for move --------------------------------------------
  def move_position
    @x += @velocity_x
    @y += @velocity_y
  end

  def half_width
    width / 2
  end

  def half_height
    height / 2
  end

  #Determines when the ball has hit a wall and needs to bounce
  #off it.
  def bounce_off_walls
    change_direction(:x) if hit_wall?(:left) || hit_wall?(:right)
    change_direction(:y) if hit_wall?(:top) #|| hit_wall?(:bottom)
  end

  #Determines when the ball has hit the paddle and needs to bounce
  #off it.
  def bounce_off_paddle
    if @velocity_y > 0 
      change_direction(:y) 
    end
  end

  #Helper methods for bounce_off_walls --------------------------------
  def change_direction(axis)
    if axis == :x
      @velocity_x *= -1
    elsif axis == :y
      @velocity_y *= -1
    end  
  end

  def hit_wall?(wall)
    if wall == :top
      hit_top_wall?
    elsif wall == :bottom
      hit_bottom_wall?
    elsif wall == :right
      hit_right_wall?
    elsif wall == :left
      hit_left_wall?
    end 
  end

  #Helper methods for hit_wall -----------------------------------------
  def hit_top_wall?
    @y - radius <= 0 && !positive?(@velocity_y)
  end

  def hit_bottom_wall?
    @y + radius >= @window.height && positive?(@velocity_y)
  end

  def hit_left_wall?
    @x - radius <= 0 && !positive?(@velocity_x)
  end

  def hit_right_wall?
    @x + radius >= @window.width && positive?(@velocity_x)
  end

  #General helper methods ----------------------------------------------
  def positive?(num)
    num > 0
  end

  def radius
    width / 2
  end

  def bounce_off_brick(side)
    if side == :top
      if @velocity_y >= 0
        @velocity_y = -@velocity_y
      end
    elsif side == :bottom
      if @velocity_y <= 0
        @velocity_y = -@velocity_y
      end
    elsif side == :left
      if @velocity_x >= 0
        @velocity_x = -@velocity_x
      end
    else
      if @velocity_x <= 0
        @velocity_x = -@velocity_x
      end
    end
  end

end


