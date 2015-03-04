#デプロイ用ユーザーの設定
group 'deploy' do
  group_name 'deploy'  
  action :create
end

user 'deploy' do
  comment 'deploy user'
  group 'deploy'
  home '/home/deploy'
  shell '/bin/bash'
  password '$1$MUrjZAgv$fJj4i7fr7A.gXf11/aTZS/'
  supports :manage_home => true
  action :create
end

group 'wheel' do
  action [:modify]
  members ['deploy']
  append true
end

#公開鍵の登録
directory "/home/deploy/.ssh/" do
  owner 'deploy'
  group 'deploy'
  mode 0755
end

cookbook_file "/home/deploy/.ssh/authorized_keys" do
  owner 'deploy'
  mode 0600
  source "rails-env.pem.pub"
end

#sudo権限の設定
cookbook_file "/etc/sudoers.d/deploy" do
  source 'deploy'
  mode   '0440'
  owner  'root'
end

#デプロイ先ディレクトの設定
directory "/var/www" do
  owner 'deploy'
  group 'deploy'
end

directory "#{node['app']['deploy_to']}" do
  owner 'deploy'
  group 'deploy'
end

bash "SetupForDeployDirectory" do
  user 'deploy'
  cwd "#{node['app']['deploy_to']}"
  command "umask 0002"
  command "chmod g+s #{node['app']['deploy_to']}"
end

directory "#{node['app']['deploy_to']}/releases" do
  owner 'deploy'
  group 'deploy'
end

directory "#{node['app']['deploy_to']}/shared" do
  owner 'deploy'
  group 'deploy'
end

directory "#{node['app']['deploy_to']}/shared/config" do
  owner 'deploy'
  group 'deploy'
end

directory "#{node['app']['deploy_to']}/shared/log" do
  owner 'deploy'
  group 'deploy'
end

directory "#{node['app']['deploy_to']}/shared/tmp" do
  owner 'deploy'
  group 'deploy'
end

directory "#{node['app']['deploy_to']}/shared/tmp/pids" do
  owner 'deploy'
  group 'deploy'
end

directory "#{node['app']['deploy_to']}/shared/tmp/sockets" do
  owner 'deploy'
  group 'deploy'
end
