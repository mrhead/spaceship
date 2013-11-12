Hasu.load 'quad_object.rb'

class Star < QuadObject
  attr_reader :x, :y, :color, :speed, :size

  def initialize
    @x = rand_x
    @y = rand_y
    @color = Gosu::Color::GRAY
    @speed = rand + 0.5
    @size = rand(2) + 1
  end

  def update
    move
    if out_of_screen?
      set_new_position
    end
  end

  def out_of_screen?
    y1 > Game::HEIGHT
  end

  private

  def rand_x
    rand(Game::WIDTH)
  end

  def rand_y
    rand(Game::HEIGHT)
  end

  def move
    @y += speed
  end

  def set_new_position
    @y = - rand(20)
    @x = rand_x
  end

  def width
    size
  end

  def height
    size
  end

  def size
    @size.to_f
  end
end
