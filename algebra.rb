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
			return "e"
		end

		if ltemp == rtemp 
			if !(ltempopr && rtempopr) 
				return "e"
			end
		end


		temp = Literal.new(ltemp,rtemp,ltempopr,rtempopr).to_s

	end

	def union_literal x
			
		if (self.inter_literal(x) == "e")
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


		temp = Literal.new(ltemp,rtemp,ltempopr,rtempopr).to_s

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
			return "e"
		end

		temp = Literal.new(ltemp,self.rvalue,ltempopr,self.ropenopr).to_s
	end

	def union_rightinf x
	end
	
	def inter_leftinf x	
	end

	def union_leftinf x
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
			puts "(,#{lvalue})"
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
		
		temp = RightInfinite.new(ltemp,ltempopr).to_s
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
		
		temp = RightInfinite.new(ltemp,ltempopr).to_s
	end

	def inter_literal x 
		x.inter_rightinf(self)
=begin
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

		if ltemp > x.rvalue
			return "e"
		end

		temp = Literal.new(ltemp,x.rvalue,ltempopr,x.ropenopr).to_s
=end
	end

	def union_literal x
		if inter_literal(x) == "e"
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

		temp = RightInfinite.new(ltemp,ltempopr).to_s
	end

	def inter_leftinf x
	end

	def union_leftinf x
	end

end

class LeftInfinite < Interval
end

class AllReals < Interval
end

class Empty < Interval
end
