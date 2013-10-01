
class Player
  attr_accessor :score, :position, :shipshape, :hull, :shield
  def initialize(window)
    @score = 0
    @texte = Gosu::Font.new(window, "ext/digital-7.ttf", 30)
    @texte_fin = Gosu::Font.new(window, "ext/digital-7.ttf", 40)
    @shieldicon =  Gosu::Image.new(window, "ext/shield.png", false)
    @shieldlevelicon =  Gosu::Image.new(window, "ext/shieldlevel.png", false)
    @imagehull =  Gosu::Image.new(window, "ext/shipshield.png", false)
    @image =  Gosu::Image.new(window, "ext/ship.png", false)
    @acc = 0.0
    @position = Point.new(0,0)
    @movespeed = 2.4
    @hull = []
    @hull << Point.new(0,0)
    @hull << Point.new(0,40)
    @hull << Point.new(40,40)
    @hull << Point.new(40,0)
    @shield = 100
    @shipshape = Rectangle.new @hull
    @shipshape.position = @position
    @shieldalpha = 30
    @textalpha = 200
  end
  def play api
    @shieldalpha -= 5 if @shieldalpha > 30
    @textalpha = 200 if @shieldalpha < 30
    
    @shield += 0.05 if @shield < 100
    if api.button_down? Gosu::Button::KbUp
      self.move_top unless @position.y < 0
    end
    if api.button_down? Gosu::Button::KbDown
      self.move_bottom unless @position.y > 480
    end   
    self.score +=  1
  end
  def move_top
    @position.y -= (@movespeed + @acc)
    #@acc -= 0.3
  end
  def move_bottom
    @position.y += (@movespeed + @acc)
    #@acc += 0.3
  end
  def warp(x,y)
    @position.x = x
    @position.y = y
  end
  def colision
  end
  def drawhull
    
  end
  def shield_reduce(window)
    @textalpha = (@textalpha + 10) % 200
    @shield -= 1 if @shield > 0
    
    @shieldalpha = 255
    die window if @shield < 0
    
  end
  def draw window
    @image.draw_rot(@position.x+20,@position.y+20,1,0)
    @shieldicon.draw_rot(130,15,1,0)
    
    c = Gosu::Color.new(@textalpha,255,255,255) #a,r,g,b
    cl = Gosu::Color.new(((@shield+1)*2.5).round,255,255,255)
    
    ct = Gosu::Color.new(@shieldalpha,255,255,255) #a,r,g,b
    if @shield > 20
      cr = Gosu::Color.new(0x50000000)
    else
      cr = Gosu::Color.new(0x50500000)
    end
    
    @shieldlevelicon.draw_rot(130,15,1,0,0.5,0.5,1,1,cl)
    @imagehull.draw_rot(@position.x+20,@position.y+20,1,0,0.5,0.5,1,1,ct)
    @texte.draw("#{shield.round}", 140, 4, 2, 1.0, 1.0, c)
    window.draw_quad(0,
                     0,
                     cr,
                     640,
                     0,
                     cr,
                     640,
                     30,
                     cr,
                     0,
                     30,
                     cr,
                     1)
    
  end
  def die(window)
    c = Gosu::Color.new(120,0,0,0)
   # song = Gosu::Song.new(window, "ext/sounds/gameover.wav")
    song.play unless song.playing? 
    
    window.draw_quad(0,250,c,640,250,c,640,300,c,0,300,c,2)
    @texte_fin.draw("GAME OVER", 200, 260, 4, 1.0, 1.0, 0xffffffff)
    
    sleep 1
  end
end