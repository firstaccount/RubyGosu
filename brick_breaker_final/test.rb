require 'gosu'
require_relative 'ball.rb'
require_relative 'paddle.rb'
require_relative 'lives.rb'
#require_relative 'score.rb'
require_relative 'background.rb'
require_relative 'brick.rb'
require_relative 'game_over.rb'
#require_relative 'start_ball.rb'

class Game < Gosu::Window

  WIDTH = 800
  HEIGHT = 540

  def initialize
    super(WIDTH, HEIGHT)
    self.caption = "Destroy Ball"
    #@start_ball = StartBall.new
    @paddle = Paddle.new(self)
    @balls = []
    @lives = Lives.new
    @game_over = GameOver.new
    @background = Background.new
    @bricks = []
    @bricks << Brick.new(200, 200)
    @i = 0
    @pause = false
  end

  def draw
    #@start_ball.draw
    @paddle.draw
    draw_balls
    @background.draw
    @bricks.each {|brick| brick.draw}
    @lives.draw
    @game_over.draw
  end

  def update
    @balls.each do |ball|
      if @pause
        ball.pause
      else 
        ball.unpause
      end
    end
    if @game_over.over == false
      move_paddle
      move_balls
      check_for_collision
    end

  end


  def button_down(id)
    @i = @i + 50 if id == Gosu::KbSpace
    if @balls.length == 0 and @game_over.over == false
      @balls << Ball.new(@i, 100, self) if id == Gosu::KbSpace
      #@balls.delete(@start_ball)
    end
    @pause = false if id == Gosu::KbUp
  end

  private

  def check_for_collision
    @balls.each do |ball|
      @paddle.bounce_off(ball)

      #ball hit brick
      @bricks.each do |brick|
        if brick.bounce_off_brick(ball)
          @pause = true
          # @bricks.delete(brick)
        end
      end

      #lost ball
      if ball.y >= HEIGHT
        @lives.minus_life
        @balls.delete(ball)
        if @lives.lives <=0 
          #@game_over.over = true
        end
      end
    end
  end

  def draw_balls
    @balls.each {|ball| ball.draw}
  end

  def move_balls
    @balls.each {|ball| ball.move}
  end

  def move_paddle
    @paddle.move(:right) if button_down?(Gosu::KbRight) && @paddle.x + @paddle.half_width <= self.width
    @paddle.move(:left) if button_down?(Gosu::KbLeft) && @paddle.x - @paddle.half_width >= 0
  end 

end

window = Game.new
window.show