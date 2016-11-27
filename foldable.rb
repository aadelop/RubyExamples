
module Foldable
  
  def null? 
      if length == 0 then 
        true 
      else 
        false 
      end
  end

  def foldr1(&block)
    if self.null? then
      raise "fodlr1: Empty structure"
    else
      self.foldr(self.last, &block)
    end

  end

  def length
      self.foldr(0){|x| x+=1 }
  end

  def all? (&block)
      foldr(true){|memo,x|memo = memo && block.call(x) }
  end
  
  def any? (&block)
      foldr(false){|memo,x|memo = memo || block.call(x) }
  end

  def to_arr
      temp = []
      foldr(temp){|x,y|temp = [y]+[x]}
      temp.flatten.reverse

  end

  def elem? (to_find)
     self.any? {|x| x == to_find}
  end
end

class Array 
  include Foldable

  def foldr(e,&block)
    self.inject(e,&block)
  end
end 

class Rose
  attr_accessor :elem, :children
  def initialize elem, children = []
    @elem = elem
    @children = children
  end

  def add elem
    @children.push elem
    self
  end

  def travel_tree n
      if self.children.length == 0
        p "Leaf:  #{self.elem}"
      else 
        travel_tree (self.children[0])
        p "Node: #{self.elem}"
        i= 1
        while i < self.children.lentgh 
            travel_tree(self.children[i])
        end
      end
  end
  
end

/
  def foldr(e,&block)
    result = e
    self.reverse_each {|elem| result = block.call(result, elem) }
    result 
  end
/



