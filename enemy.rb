Hasu.load 'bomb.rb'

class Enemy
  WIDTH = 25
  HEIGHT = 25
  SPEED = 2

  attr_reader :x, :y

  def initialize
    @x = rand(Game::WIDTH - WIDTH*2) + WIDTH
    @y = -HEIGHT
  end

  def update
    move
  end

  def draw(window)
    window.draw_quad(
      x1, y1, color,
      x1, y2, color,
      x2, y2, color,
      x2, y1, color
    )
  end

  def color
    Gosu::Color::RED
  end

  def fire(ship)
    Bomb.new(x, y, bomb_angle(ship))
  end

  def bomb_angle(ship)
    Gosu.angle(x, y, ship.x, ship.y)
  end

  def out_of_screen?
    y > Game::HEIGHT
  end

  def x1
    x - WIDTH/2
  end

  def x2
    x + WIDTH/2
  end

  def y1
    y - HEIGHT/2
  end

  def y2
    y + HEIGHT/2
  end

  private

  def move
    @y += SPEED
  end
end
