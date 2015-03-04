# ConnectionInfo
mysql_connection_info = {:host => "localhost",
  :username => 'root',
  :password => node['mysql']['server_root_password']}

  # /etc/my.cnfを修正
  template "/etc/my.cnf" do
    owner "root"
    group "root"
    mode "0644"
  end

  database "#{node['app']['db']['staging']}" do
    connection mysql_connection_info
    provider   Chef::Provider::Database::Mysql
    action     :create
  end

  database "#{node['app']['db']['production']}" do
    connection mysql_connection_info
    provider   Chef::Provider::Database::Mysql
    action     :create
  end

  mysql_database_user "#{node['app']['db']['user']['staging']}" do
    connection mysql_connection_info
    password "#{node['app']['db']['user_pass']['staging']}"
    action :create
  end

  mysql_database_user "#{node['app']['db']['user']['production']}" do
    connection mysql_connection_info
    password "#{node['app']['db']['user_pass']['production']}"
    action :create
  end

  # grant all privileges on all tables in foo db
  mysql_database_user "#{node['app']['db']['user']['staging']}" do
    connection mysql_connection_info
    database_name "#{node['app']['db']['staging']}"
    host '%'
    privileges [:all]
    action :grant
  end

  mysql_database_user "#{node['app']['db']['user']['production']}" do
    connection mysql_connection_info
    database_name "#{node['app']['db']['production']}"
    host '%'
    privileges [:all]
    action :grant
  end
