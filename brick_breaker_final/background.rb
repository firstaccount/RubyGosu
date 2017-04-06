class Background < Gosu::Image

  def initialize
    super("images/sky.jpg")
  end

  def draw
    super(0,0,0)
  end

end