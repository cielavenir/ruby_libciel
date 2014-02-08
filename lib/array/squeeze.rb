class Array
	#Destructive version of Enumerable#squeeze
	def squeeze!
		replace(squeeze)
	end
end

