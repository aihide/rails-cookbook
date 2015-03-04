rbenv_ruby "#{node['ruby']['version']}" do
  ruby_version node['ruby']['version']
  global true
end

rbenv_gem "bundler" do
  ruby_version node['ruby']['version']
end
