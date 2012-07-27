# Install chef gem

rightscale_marker :begin

log "Installing Chef outside of sandbox"

gem_package "chef" do 
  gem_binary "/usr/bin/gem"
  action :install
  options("--no-ri --no-rdoc")
end

rightscale_marker :end


