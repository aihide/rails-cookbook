case platform?
  when 'ubuntu'
    include_recipe 'apt'
  when 'centos'
    include_recipe 'yum'
    include_recipe 'yum-epel'
end
include_recipe 'nginx'
include_recipe 'rbenv::default'
include_recipe 'rbenv::ruby_build'
include_recipe 'mysql::server'
include_recipe 'database::mysql'
