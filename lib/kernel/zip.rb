module Kernel
	#Pythonic zip. The same as a.shift.zip(*a).
	def zip(_a)
		a=_a.dup
		a.shift.zip(*a)
	end
end
