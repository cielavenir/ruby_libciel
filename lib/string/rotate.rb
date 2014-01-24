class String
	#Rotate string to the left with count.
	#Specifying negative number indicates rotation to the right.
	def rotate(count=1)
		count+=self.length if count<0
		self.slice(count,self.length-count)+self.slice(0,count)
	end
	#Destructive version of String#rotate
	def rotate!(count=1) self.replace(self.rotate(count)) end
end
