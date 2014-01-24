module DBI
	#connect-transaction-disconnect triplet.
	# To use this method, you need to require dbi before requiring libciel.
	def self.connect_transaction(driver_url, user=nil, auth=nil, params=nil, &block)
		x=connect(driver_url, user, auth, params)
		begin
			x.transaction(&block)
		ensure
			x.disconnect
		end
	end

	class DatabaseHandle
		#execute-map,count-finish triplet.
		# To use this method, you need to require dbi before requiring libciel.
		def execute_immediate(stmt,*bindvars,&block)
			sth=execute(stmt,*bindvars)
			ret=0
			begin
				if block then ret=sth.map(&block).count end
			ensure
				sth.finish
			end
			ret
		end
	end
end
