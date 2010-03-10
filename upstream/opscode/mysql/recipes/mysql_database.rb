define :mysql_database, :user => nil, :password => nil do
  credentials = "-uroot -p#{node[:mysql][:server_root_password]}"
  execute "Create database #{params[:name]}" do
    command"mysqladmin #{credentials} create #{params[:name]}"
    not_if { `mysql #{credentials} -e 'show databases'`.include? params[:name] }
  end
  execute "Grant #{params[:user]} access to database #{params[:name]}" do
    command "mysql #{credentials} #{params[:name]} " +
            %(-e "grant all on #{params[:name]}.* to #{params[:user]}@localhost identified by '#{params[:password]}'")
    #not_if { `mysql -e 'show databases'`.include? params[:name] }
  end
end
