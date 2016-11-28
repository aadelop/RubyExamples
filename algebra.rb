require "singleton"

class Interval
end

class Literal < Interval
	attr_accessor  :lvalue, :rvalue, :lopenopr, :ropenopr
	
	def initialize(l,r,lopr,ropr)
		@lvalue = l
		@rvalue = r
		@lopenopr = lopr
		@ropenopr = ropr 
	end

	def to_s
		message = ""
		
		if lopenopr then
			message = message + "[#{self.lvalue},"
		else
			message = message + "(#{self.lvalue},"
		end

		if ropenopr then
			message = message + "#{self.rvalue}]"
		else 
			message = message + "#{self.rvalue})"
		end

		message
	end

	def intersection other
		other.inter_literal(self)
	end

	def union other
		other.union_literal(self)
	end 

	def inter_literal x
		if self.lvalue >= x.lvalue then
			ltemp = self.lvalue
			if ltemp == x.lvalue then
				ltempopr = self.lopenopr && x.lopenopr
			else
			 	ltempopr = self.lopenopr
			end  
		else
			ltemp = x.lvalue
			ltempopr = x.lopenopr
		end

		if self.rvalue <= x.rvalue then
			rtemp = self.rvalue
			if rtemp == x.rvalue then
				rtempopr = self.ropenopr && x.ropenopr
			else
				rtempopr = self.ropenopr
			end
		else
			rtemp = x.rvalue
			rtempopr = x.ropenopr
		end

		if ltemp > rtemp
			return Empty.instance
		end

		if ltemp == rtemp 
			if !(ltempopr && rtempopr) 
				return Empty.instance
			end
		end


		temp = Literal.new(ltemp,rtemp,ltempopr,rtempopr)
	end

	def union_literal x
			
		if (self.inter_literal(x) == Empty.instance)
			raise "Error: interseccion vacia "
		end	

		if self.lvalue <= x.lvalue then
			ltemp = self.lvalue
			if ltemp == x.lvalue then
				ltempopr = self.lopenopr && x.lopenopr
			else
			 	ltempopr = self.lopenopr
			end  
		else
			ltemp = x.lvalue
			ltempopr = x.lopenopr
		end

		if self.rvalue >= x.rvalue then
			rtemp = self.rvalue
			if rtemp == x.rvalue then
				rtempopr = self.ropenopr && x.ropenopr
			else
				rtempopr = self.ropenopr
			end
		else
			rtemp = x.rvalue
			rtempopr = x.ropenopr
		end


		temp = Literal.new(ltemp,rtemp,ltempopr,rtempopr)
	end

	def inter_rightinf x
		if self.lvalue >= x.lvalue then
			ltemp = self.lvalue
			if ltemp == self.lvalue then
				ltempopr = self.lopenopr && x.lopenopr
			else 
				ltempopr = self.lopenopr
			end
		else 
			ltemp = x.lvalue
			ltempopr = x.lopenopr
		end

		if ltemp > self.rvalue
			return Empty.instance
		end

		temp = Literal.new(ltemp,self.rvalue,ltempopr,self.ropenopr)
	end

	def union_rightinf x
		if x.inter_literal(self) == Empty.instance
			raise = "Error: Intersccion vacia"
		end

		if self.lvalue <= x.lvalue then
			ltemp = self.lvalue
			if ltemp == x.lvalue then
				ltempopr = self.lopenopr && x.lopenopr
			else 
				ltempopr = self.lopenopr
			end
		else 
			ltemp = x.lvalue
			ltempopr = x.lopenopr
		end

		temp = RightInfinite.new(ltemp,ltempopr)
	end
	
	def inter_leftinf x	
		if self.rvalue <= x.rvalue then
			rtemp = self.rvalue
			if rtemp == x.rvalue then
				rtempopr = self.ropenopr && x.ropenopr
			else 
				rtempopr = self.ropenopr
			end
		else 
			rtemp = x.rvalue
			rtempopr = x.ropenopr
		end

		if rtemp < self.lvalue
			return Empty.instance
		end

		temp = Literal.new(self.lvalue,rtemp,self.lopenopr,rtempopr)
	end

	def union_leftinf x
		if x.inter_literal(self) == Empty.instance
			raise = "Error: Intersccion vacia"
		end

		if self.rvalue >= x.rvalue then
			rtemp = self.rvalue
			if rtemp == x.rvalue then
				rtempopr = self.ropenopr && x.ropenopr
			else 
				rtempopr = self.ropenopr
			end
		else 
			rtemp = x.rvalue
			rtempopr = x.ropenopr
		end

		temp = LeftInfinite.new(rtemp,rtempopr)
	end
	
	def inter_allr x
		return self.clone
	end

	def union_allr x
		return AllReals.instance
	end

	def inter_empty x
		return Empty.instance
	end

	def union_empty x
		return self.clone
	end
end

class RightInfinite < Interval
	attr_accessor  :lvalue, :lopenopr
	def initialize (l,lopr)
		@lvalue = l
		@lopenopr = lopr
	end

	def to_s
		if lopenopr then
			puts "[#{lvalue},)"	
		else
			puts "[#{lvalue},)"
		end
	end

	def intersection other
		other.inter_rightinf(self)
	end

	def union other
		other.union_rightinf(self)
	end

	def inter_rightinf x
		if self.lvalue >= x.lvalue then
			ltemp = self.lvalue
			if ltemp == x.lvalue then
				ltempopr = self.lopenopr && x.lopenopr
			else
				ltempopr = self.lopenopr
			end
		else
			ltemp = x.lvalue
			ltempopr = x.lopenopr
		end
		
		temp = RightInfinite.new(ltemp,ltempopr)
	
	end

	def union_rightinf x
		if self.lvalue <= x.lvalue then
			ltemp = self.lvalue
			if ltemp == x.lvalue then
				ltempopr = self.lopenopr && x.lopenopr
			else
				ltempopr = self.lopenopr
			end
		else
			ltemp = x.lvalue
			ltempopr = x.lopenopr
		end
		
		temp = RightInfinite.new(ltemp,ltempopr)
	end

	def inter_literal x 
		x.inter_rightinf(self)
	end

	def union_literal x
		x.union_rightinf(self)
	end

	def inter_leftinf x
		if self.lvalue == x.rvalue
			if !(self.lopenopr && x.ropenopr) 
				return Empty.instance
			end
		end
		
		if self.lvalue > x.rvalue then
			return Empty.instance
		else
			return Literal.new(self.lvalue,x.rvalue,self.lopenopr,x.ropenopr)
		end
	end

	def union_leftinf x
		if self.inter_leftinf(x) == Empty.instance
			raise "Error: Interseccion vacia"
		end
		
		return AllReals.instance
	end	

	def inter_allr x
		return self.clone
	end

	def union_allr x
		return AllReals.instance
	end

	def inter_empty x
		return Empty.instance
	end

	def union_empty x
		return self.clone
	end
end

class LeftInfinite < Interval
	attr_accessor  :rvalue, :ropenopr
	def initialize (r,ropr)
		@rvalue = r
		@ropenopr = ropr
	end

	def to_s
		if ropenopr then
			puts "(,#{rvalue}]"	
		else
			puts "(,#{rvalue})"
		end
	end

	def intersection other
		other.inter_leftinf(self)
	end

	def union other
		other.union_leftinf(self)
	end

	def inter_leftinf x
		if self.rvalue <= x.rvalue
			rtemp = self.rvalue
			if rtemp == x.rvalue then
				rtempopr = self.lopenopr && x.lopenopr
			else
				rtempopr = self.lopenopr
			end
		else
			rtemp = x.rvalue
			rtempopr = x.ropenopr
		end
		
		temp = LeftInfinite.new(rtemp,rtempopr)
	end

	def union_leftinf x
		if self.rvalue >= x.rvalue then
			rtemp = self.rvalue
			if rtemp == x.rvalue then
				rtempopr = self.ropenopr && x.ropenopr
			else
				rtempopr = self.ropenopr
			end
		else
			rtemp = x.rvalue
			rtempopr = x.ropenopr
		end
		
		temp = LeftInfinite.new(rtemp,rtempopr)
	end

	def inter_literal x
		x.inter_leftinf(self)
	end

	def union_literal x
		x.union_leftinf(self)
	end

	def inter_rightinf x
		x.inter_leftinf(self)
	end

	def union_rightinf x
		x.union_leftinf(self)
	end

	def inter_allr x
		return self.clone
	end

	def union_allr x
		return AllReals.instance
	end

	def inter_empty x
		return Empty.instance
	end

	def union_empty x
		return self.clone
	end
end

class AllReals < Interval
	include Singleton
	def initializer
	end

	def to_s
		return "(,)"
	end

	def intersection other
		other.inter_allr(self)
	end

	def union other
		other.union_allr(self)
	end

	def inter_empty x
		return Empty.instance
	end

	def union_empty x
		return AllReals.instance
	end

	def inter_allr x
		return AllReals.instance
	end

	def union_allr x
		return AllReals.instance
	end

	def inter_literal x
		x.inter_allr(self)
	end 

	def inter_rightinf x
		x.inter_allr(self)
	end

	def inter_leftinf x	
		x.inter_allr(self)
	end

	def union_literal x
		x.union_allr(self)
	end 

	def union_rightinf x
		x.union_allr(self)
	end

	def union_leftinf x		
		x.union_allr(self)
	end

end

class Empty < Interval
	include Singleton
	def initializer
	end

	def to_s
		return "∅"
	end

	def intersection other
		other.inter_empty(self)
	end

	def union other
		other.union_empty(self)
	end

	def inter_empty x
		return Empty.instance
	end

	def union_empty x
		return Empty.instance
	end

	def inter_allr x
		return Empty.instance
	end

	def union_allr x
		return AllReals.instance
	end


	def inter_literal x
		x.inter_empty(self)
	end 

	def inter_rightinf x
		x.inter_empty(self)
	end

	def inter_leftinf x	
		x.inter_empty(self)
	end

	def union_literal x
		x.union_empty(self)
	end 

	def union_rightinf x
		x.union_empty(self)
	end

	def union_leftinf x		
		x.union_empty(self)
	end

end


