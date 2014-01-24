class Object
	#PHPic extract(). Hash will be injected into self as instance variables (@var).
	def extract(h,overwrite=false)
		h.each{|k,v|
			if overwrite || !self.instance_variable_defined?('@'+k) then
				self.instance_variable_set('@'+k,v) #k should always be String
			end
		}
	end
end
