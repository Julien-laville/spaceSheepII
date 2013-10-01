class ArrayList
  attr_accessor :data,:next, :preview
  def initialize(data)
    @actual = 0
    @data = data
  end
  def next
   return @data[(@actual+1)%(@data.size-1)]
 end
 def remove(indice)
   @data.delete_at(indice)
   @actual-=1 if indice <= @actual
 end
  def to_s
    cat = ""
    
      cat += "<#{self.next.data}>,"
      
   
    return cat
  end
  
  def push(elem)
    
    alist = ArrayList.new
    alist.data = elem
    @next = alist
  end

end