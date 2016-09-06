require File.expand_path(File.dirname(__FILE__)+'/array/fetch_nested')
require File.expand_path(File.dirname(__FILE__)+'/array/permutation2')
require File.expand_path(File.dirname(__FILE__)+'/array/squeeze')
require File.expand_path(File.dirname(__FILE__)+'/enumerable/squeeze')
require File.expand_path(File.dirname(__FILE__)+'/enumerator/lazy/squeeze')
require File.expand_path(File.dirname(__FILE__)+'/hash/fetch_nested')
require File.expand_path(File.dirname(__FILE__)+'/kernel/zip')
require File.expand_path(File.dirname(__FILE__)+'/object/extract')
require File.expand_path(File.dirname(__FILE__)+'/string/phpass')
require File.expand_path(File.dirname(__FILE__)+'/string/rotate')

#DBI stuff will be dropped in the future (maybe)
require File.expand_path(File.dirname(__FILE__)+'/dbi/connect_transaction')

module LibCiel
	#Version string
	VERSION='0.0.0.5'
end
