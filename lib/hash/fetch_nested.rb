class Hash
	#nil safe version of Hash#[].
	# h.fetch_nested(*['hello','world']) is basically the same as h['hello'].try.send(:[],'world').
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
