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
	specify 'zip' do
		zip([[1,2],[3,4]]).should eq [[1,3],[2,4]]
	end
end

describe Enumerable do
	specify 'squeeze' do
		[1,2,2,3,3,2,1].squeeze.should eq [1,2,3,2,1]
	end
end

describe Enumerator::Lazy do
	specify 'squeeze' do
		[1,2,2,3,3,2,1].lazy.squeeze.select(&:odd?).to_a.should eq [1,3,1]
	end
end

describe Array do
	specify 'permutation2' do
		[1,1,2,3].permutation2.to_a.should_not eq [1,1,2,3].permutation.to_a
		[1,1,2,3].permutation2.to_a.should eq [1,1,2,3].permutation.to_a.uniq
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
		specify 'exists_rec?' do
			h.exists_rec?(['hello','world']).should eq 42
		end
	end
	context 'dangerous case' do
		h={}
		specify 'usual search' do
			lambda{h['hello']['world']}.should raise_error
		end
		specify 'exists_rec?' do
			h.exists_rec?(['hello','world']).should eq nil
		end
	end
	specify 'patch' do
		h={'hello'=>1,'world'=>2}
		h_dup=h.dup
		answer={'hello'=>1,'world'=>42}
		h.patch({'world'=>42}).should eq answer
		h_dup.should eq h
	end
end

describe DBI do
	specify 'connect and execute' do
		DBI.connect('DBI:SQLite3:'+File.dirname(__FILE__)+'/test.sqlite',nil,nil,'AutoCommit'=>false){|dbi|
			#dbi.execute_immediate("create table test ( message varchar )")
			dbi.execute_immediate("select * from test"){|e|
				e.should eq ['hello']
			}
		}
	end
end
