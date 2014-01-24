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
end
