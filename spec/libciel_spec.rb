require File.expand_path(File.dirname(__FILE__)+'/spec_helper')

describe Object do
	specify 'extract' do
		a=Class.new{
			def greet() @message end
		}.new
		a.extract({'message'=>'hello'})
		a.greet.should eq 'hello'
	end
end

describe Kernel do
	context 'zip' do
		specify 'basic case' do
			a=[[1,2],[3,4]]
			zip(a).should eq [[1,3],[2,4]]
			a.transpose.should eq [[1,3],[2,4]]
		end
		specify 'awkward case' do
			a=[[1,2,3],[4,5]]
			zip(a).should eq [[1, 4],[2, 5],[3, nil]]
			lambda{a.transpose}.should raise_error
		end
	end
end

describe Enumerable do
	context 'squeeze' do
		specify 'example' do
			[1,2,2,3,3,2,1].squeeze.should eq [1,2,3,2,1]
		end
		specify 'sort.squeeze eq uniq' do
			[1,2,2,3,3,2,1].sort.squeeze.should eq [1,2,3]
		end
	end
end

describe Enumerator::Lazy do
	specify 'squeeze enum' do
		[1,2,2,3,3,2,1].lazy.squeeze.select(&:odd?).to_a.should eq [1,3,1]
	end
end

describe Array do
	context 'permutation2' do
		specify 'example' do
			[1,1,2,2,3].permutation2(2).to_a.should eq [
				[1, 1], [1, 2], [1, 3], [2, 1], [2, 2], [2, 3], [3, 1], [3, 2]
			]
		end
		it 'not eq permutation.to_a' do
			[1,1,2,3].permutation2.to_a.should_not eq [1,1,2,3].permutation.to_a
		end
		it 'eq permutation.to_a.uniq' do
			[1,1,2,3].permutation2.to_a.should eq [1,1,2,3].permutation.to_a.uniq
		end
	end
	specify 'squeeze!' do
		a=[1,2,2,3,3,2,1]
		a.squeeze!
		a.should eq [1,2,3,2,1]
	end	
end

describe String do
	context 'rotate' do
		it 'rotates left' do
			'abcdefgh'.rotate(2).should eq 'cdefghab'
		end
		it 'rotates right' do
			'abcdefgh'.rotate(-2).should eq 'ghabcdef'
		end
	end
	context 'rotate!' do
		it 'rotates left' do
			s='abcdefgh'
			s.rotate!(2)
			s.should eq 'cdefghab'
		end
		it 'rotates right' do
			s='abcdefgh'
			s.rotate!(-2)
			s.should eq 'ghabcdef'
		end
	end
end

describe Hash do
	context 'safe case' do
		h={'hello'=>{'world'=>42}}
		specify 'usual search' do
			h['hello']['world'].should eq 42
		end
		specify 'fetch_nested' do
			h.fetch_nested(*['hello','world']).should eq 42
		end
	end
	context 'dangerous case' do
		h={}
		specify 'usual search' do
			lambda{h['hello']['world']}.should raise_error
		end
		specify 'fetch_nested' do
			h.fetch_nested(*['hello','world']).should eq nil
		end
	end
end

describe DBI do
	specify 'connect and execute' do
		pending 'dbd-sqlite3 seems stopped working from Ruby 2.0' if RUBY_VERSION>='2.0'
		pending 'dbd-sqlite3 is not supported by jruby' if defined?(RUBY_ENGINE)&&RUBY_ENGINE=='jruby'
		DBI.connect_transaction('DBI:SQLite3:'+File.dirname(__FILE__)+'/test.sqlite',nil,nil,'AutoCommit'=>false){|dbi|
			#dbi.execute_immediate("create table test ( message varchar )")
			dbi.execute_immediate("select * from test"){|e|
				e.should eq ['hello']
			}
		}
	end
end
