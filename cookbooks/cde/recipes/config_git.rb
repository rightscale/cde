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


branch = node[:git][:git_branch] || "master"

if node[:git][:git_repo]
  # The git resource clones then switches to a disconnected "deploy" branch.
  # This is heavy handed, but we want to make sure we're on the specified
  # branch instead.
  bash "Switch to specified git branch" do
    user "root"
    cwd "/opt/development"
    code "git checkout #{branch}"
    action :nothing
  end

  git "/opt/development" do
    user "root"
    repository node[:git][:git_repo]
    revision branch
    action :checkout
    notifies :run, "bash[Switch to specified git branch]", :immediately
  end
end

rightscale_marker :end
