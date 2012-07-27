maintainer       "RightScale, Inc."
maintainer_email "robert@rightscale.com"
license          "All rights reserved"
description      "Installs/Configures cde"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.rdoc'))
version          "0.0.1"


# Best practice includes using rightscale_marker :begin|:end
depends "rightscale"

recipe "cde::config_shell", "Configures a basic shell environment"
recipe "cde::config_git", "Configures basic git environment"
recipe "cde::config_knife", "Configures basic knife environment"
recipe "cde::config_chef", "Installs CHEF gem"

attribute "git/username",
  :display_name => "Git user name",
  :description => "Your full name used with git",
  :required => true,
  :type => "string",
  :recipes => [ "cde::config_git" ]

attribute "git/email",
  :display_name => "Git email address",
  :description => "Your email address used for git",
  :type => "string",
  :required => true,
  :recipes => [ "cde::config_git" ]
 
attribute "git/ssh_key",
  :display_name => "Git SSH key used for read/write access",
  :description  => "Git SSH key used for read/write access",
  :required     => true,
  :type         => "string",
  :recipes      => [ "cde::config_git" ]


attribute "git/git_repo",
  :display_name => "Git Repository",
  :description  => "Code to pull down to instance automatically",
  :required     => false,
  :type         => "string",
  :recipes      => [ "cde::config_git" ]


attribute "git/git_branch",
  :display_name => "Git branch",
  :description  => "Git branch to checkout",
  :required     => false,
  :type         => "string",
  :recipes      => [ "cde::config_git" ]
