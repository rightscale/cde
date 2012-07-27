# Install the basic git package and configuration template to
# 

rightscale_marker :begin

package "git-core" do
  action :install
end

template "/root/.gitconfig" do
  source "gitconfig.erb"
end

template "/root/.ssh/id_rsa" do 
  owner "root"
  group "root"
  source "id_github.erb"
  mode 0600
end

bash "Disable HostKeyChecking" do
  code <<-EOH
  echo "host *" >> /root/.ssh/config
  echo "StrictHostKeyChecking=no" >> /root/.ssh/config
  chmod 0600 /root/.ssh/config
  EOH
end


branch = node[:git][:git_branc] || "master"

if node[:git][:git_repo]
  git "/opt/development" do
    user "root"
    repository node[:git][:git_repo]
    revision branch
    action :checkout
  end
end

rightscale_marker :end
