require 'rubygems'
begin
require 'gosu'
rescue
puts "error loading"
end
require File.dirname(__FILE__)+'/Collision.rb'
require File.dirname(__FILE__)+'/player.rb'
require File.dirname(__FILE__)+'/Rock_field.rb'


class GameWindow < Gosu::Window
  def initialize
    super(640,480,false)
    self.caption = "planetid"
    @player = Player.new(self)
    @player.warp(55,300)
    @score = Gosu::Font.new(self, "ext/digital-7.ttf", 16)
    @rock_field = Rock_field.new
    @rock_field.set_player @player
    
    #theme = Gosu::Song.new(self, "ext/sounds/music/Theme1.it")
    Thread.new do
      theme.play
      Thread.stop
    end
    
    #start
   
    #end
  end
  
  def update
    #@player.x = self.mouse_x
    #@player.y = self.mouse_y
    @player.play(self)
      
    @player.shield_reduce(self) if @rock_field.collision_with_player     
    
    @rock_field.maintain_ressource
    @rock_field.transit
    if rand(8) == 1 and @rock_field.disabled_rocks.size > 0
      @rock_field.get_one_rock
    end
    
  end
  def draw
    @player.draw self
    @rock_field.draw(self)
    @score.draw("Score: #{@player.score}", 12, 8, 1, 1.0, 1.0, 0xaaffffff)
    
  end
  
end

win = GameWindow.new
win.show