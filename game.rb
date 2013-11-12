require 'hasu'

Hasu.load 'ship.rb'
Hasu.load 'enemy.rb'
Hasu.load 'background.rb'

class Game < Hasu::Window
  WIDTH = 480
  HEIGHT = 640

  def initialize
    super(WIDTH, HEIGHT, false)
  end

  def reset
    @background = Background.new
    @ship = Ship.new
    @missiles = []
    @enemies = []
    @bombs = []
    @score = 0
    @font = Gosu::Font.new(self, "Arial", 20)
    @game_over = false
  end

  def update
    if button_down?(Gosu::KbLeft)
      @ship.left!
    end

    if button_down?(Gosu::KbRight)
      @ship.right!
    end

    if mouse_moved?
      @ship.set_x(mouse_x)
    end

    update_background
    update_missiles
    update_enemies
    update_bombs
    fire_a_bomb
    find_collisions

    unless game_over?
      create_new_enemy
    end
  end

  def button_down(key)
    if key == Gosu::KbSpace or key == Gosu::MsLeft
      @missiles << @ship.fire!
    end
  end

  def draw
    draw_background
    draw_score
    if game_over?
      write_game_over_text
    else
      draw_ship
      draw_missiles
      draw_enemies
      draw_bombs
    end
  end

  private

  def mouse_moved?
    @prev_mouse_x != mouse_x
  ensure
    @prev_mouse_x = mouse_x
  end

  def update_background
    @background.update
  end

  def update_missiles
    update_collection(@missiles)
  end

  def update_collection(collection)
    collection.each do |object|
      object.update
      if object.out_of_screen?
        collection.delete(object)
      end
    end
  end

  def fire_a_bomb
    if rand(100) == 0 && @enemies.any?
      @bombs << @enemies.sample.fire(@ship)
    end
  end

  def update_enemies
    update_collection(@enemies)
  end

  def find_collisions
    missiles_vs_enemies
    ship_vs_enemies
    ship_vs_bombs
  end

  def missiles_vs_enemies
    @missiles.each do |missile|
      @enemies.each do |enemy|
        if missile.hit?(enemy)
          delete_enemy(enemy)
          delete_missile(missile)
          add_score(10)
        end
      end
    end
  end

  def ship_vs_enemies
    @enemies.each do |enemy|
      if @ship.intersect?(enemy)
        set_game_over
      end
    end
  end

  def ship_vs_bombs
    @bombs.each do |bomb|
      if @ship.intersect?(bomb)
        set_game_over
      end
    end
  end

  def delete_enemy(enemy)
    @enemies.delete(enemy)
  end

  def delete_missile(missile)
    @missiles.delete(missile)
  end

  def set_game_over
    @game_over = true
  end

  def write_game_over_text
    @font.draw(game_over_text, WIDTH/2 - text_width(game_over_text)/2, HEIGHT/2 - 100, 0)
  end

  def game_over_text
    'GAME OVER'
  end

  def text_width(text)
    @font.text_width(text)
  end

  def create_new_enemy
    if rand(70) == 0
      @enemies << Enemy.new
    end
  end

  def add_score(points)
    @score += points
  end

  def draw_background
    @background.draw(self)
  end

  def draw_ship
    @ship.draw(self)
  end

  def draw_missiles
    draw_collection(@missiles)
  end

  def draw_enemies
    draw_collection(@enemies)
  end

  def draw_bombs
    draw_collection(@bombs)
  end

  def draw_collection(collection)
    collection.each { |obj| obj.draw(self) }
  end

  def draw_score
    @font.draw("Score: #{@score}", WIDTH - 110, 10, 0)
  end

  def game_over?
    @game_over
  end

  def update_bombs
    update_collection(@bombs)
  end

  def delete_bomb(bomb)
    @bombs.delete(bomb)
  end

end

Game.run
