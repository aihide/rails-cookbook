template "/etc/nginx/sites-available/rails-env" do
  mode "0640"
  owner 'deploy'
  group 'deploy'
  source "rails-env.erb"
end

nginx_site 'rails-env' do
  enable true
  creates "/etc/nginx/sites-available/rails-env"
end

file "/etc/nginx/conf.d/default.conf" do
  action :delete
end

nginx_site 'default' do
  enable false
end
