require File.dirname(__FILE__)+'/rock.rb'
class Rock_field
  attr_accessor :disabled_rocks, :rocks, :agrandit
  def initialize
    @rocks = []
    @disabled_rocks = [] #stack
    @player
    @thread = create_disabled_rocks
  end
  def set_player player
    @player = player
    @thread.wakeup
  end
  
  def maintain_ressource
    if @rocks.size > 15
      @rocks.delete_at 0
    end
  end
  def set_place rock
    a = rand(600) - 100
    rock.place a
    ##### y a t'il collision
    @rocks.each do |rockelem|
      if rockelem.agrandit.contact?(rock.agrandit)
        return false
      end
      # return true
    end
    return true
  end
  
  def get_one_rock
    @thread.wakeup
    rock = @disabled_rocks.pop
    
    @rocks << rock  if set_place rock
  end
  def create_disabled_rocks
    t = Thread.new {
      begin
        while true
          Thread.stop if @player.shipshape == nil
          if @disabled_rocks.size >= 10 
            Thread.stop
            
          end
          rock = Rock_field.build_rock
          rock.set_agrandit @player.shipshape
          @disabled_rocks << rock
        end
      rescue => e
        puts e.inspect
        puts e.backtrace
      end
    }
    return t
  end
  def transit
    @rocks.each do |rock|
      rock.transit
    end
  end
  def collision_with_player
    @rocks.each do |rock|
      if rock.collision.contact?(@player.shipshape)
        pc = Point_cloud.new
        pc.cloud = rock.points
        return advanced_collision rock
      end
    end
    return false
  end
  def advanced_collision rock
    # un point du ship est il dans l asteroide
      point_temp = Point.new(20,20)+@player.position
      point_temp.angle = Convex_hull::get_angle point_temp, rock.center+rock.position
      rock_clone = rock.points.clone
      rock_clone << point_temp
      pc = Convex_hull::sort_angles rock.center+rock.position,rock_clone
      point_index = pc.index point_temp
      nextpoint = pc[(point_index + 1) % pc.size]
      previewpoint = pc[(point_index - 1) % pc.size]
      isLeft = Convex_hull::left_turn?(previewpoint+rock.position,
                                        point_temp,
                                       nextpoint+rock.position)
                                              
     isLeft = !isLeft
      return isLeft
  end
  
  def self.build_rock
    return Rock.new
  end
  
  def draw(window)
    @rocks.each do |rock|
      rock.draw_rock(window)
    end
  end
end
