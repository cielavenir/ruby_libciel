#Note: this file is exactly the same as Hash#fetch_nested except the class name.

class Array
	#nil safe version of Hash#[].
	# a.fetch_nested(*[0,1]) is basically the same as a[0].try.send(:[],1).
	def fetch_nested(*keys)
		begin
			keys.reduce(self){|accum, k| accum.fetch(k)}
		rescue (RUBY_VERSION<'1.9' ? IndexError : KeyError)
			block_given? ? yield(*keys) : nil
		end
	end

	# Ruby 2.3 feature
	# note: block yielding is libciel extention.
	unless Hash.method_defined? :dig
		alias :dig :fetch_nested
	end
end
