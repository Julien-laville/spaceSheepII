require File.dirname(__FILE__)+'/utiles/points/Point.rb'
class Point_cloud
  attr_accessor :cloud
  def initialize(minX = 200, minY=200, nb = 20)
    @cloud = Array.new
    nb.times { |i|
      @cloud << Point.new(rand(minX), rand(minY))
      
      
    }
    
    
  end
  
  def first
    return @cloud.first
  end
  def suivant(actual)
    index = @cloud.index(actual)
    return nil if actual == @cloud.size
    return @cloud[index+1]
  end
  
  def min
    min = @cloud.first
    @cloud.each do |point|
      if point.y > min.y
        min = point 
      end     
    end
    puts @cloud.index(min).to_s + "<<"
    return @cloud.index(min)
  end
  def to_s
    chaine = ""
    @cloud.each{ |cloud_point|
      chaine += cloud_point.to_s
    }
  end
  
  
end
class Array_list
  attr_accessor :size, :first, :last, :next, :preview
  def initialize(array)
    array.each do |a|
      @size += 1
      @next = Array_list.add(a)
    end
  end
  
  
end
