class Chef
  class Recipe
    def monitrc(name, variables={})
      Chef::Log.info("Making monitrc for: #{name}")
      template "/etc/monit.d/#{name}.#{variables[:app_name]}.monitrc" do
        owner "root"
        group "root"
        mode 0644
        source "#{name}.monitrc.erb"
        variables variables
        notifies :run, resources(:execute => "restart-monit")
        action :create
      end
    end
  end
end  