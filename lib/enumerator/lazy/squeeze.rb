class Enumerator
	begin
	Lazy.class_eval{
		#Enumerator.Lazy version of Enumerable#squeeze.
		#Enumerator.Lazy is evaluated as Enumerable::Lazy on Ruby 1.9 + enumerable/lazy, otherwise Enumerator::Lazy.
		# To use this method, on Ruby <2.0, you need to require enumerable/lazy or backports before requiring libciel.
		def squeeze
			first=true
			cur=nil
			self.class.new(self){|y,v|
				if first||cur!=v
					y<<v
					first=false
					cur=v
				end
			}
		end
	}
	rescue NameError=>e; end
end
