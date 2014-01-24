module Enumerable
	#Squeezes the same element. This behaves like C++ unique().
	#To get the similar result to Array#uniq, you need to sort it prior.
	# Calculation order is O(n).
	def squeeze
		r=[]
		cur=nil
		self.each{|e|
			if r.empty?||cur!=e
				r<<e
				cur=e
			end
		}
		r
	end
end
