#
# Cookbook Name:: streamtools
# Recipe:: source
#

include_recipe "apt"
include_recipe "build-essential"
include_recipe "git"
include_recipe "golang"

# make sure the GOPATH directory structure exists
directory node['goproject']['gopath'] do
  action :create
  owner "ubuntu"
  recursive true
end

execute "fix_owner" do
  command "chown -R ubuntu #{node['goproject']['gopath']}"
end

destination_directory = ""
app_name = ""

https_repo_match = node['goproject']['repository'].match(/^https:\/\/(.*?)\/(.*?)\/(.*?)\.git/)
if https_repo_match && https_repo_match[1] && https_repo_match[2]
  destination_directory = File.join(node['goproject']['gopath'], "src", https_repo_match[1], https_repo_match[2])
  app_name = https_repo_match[3]
end

git_repo_match = node['goproject']['repository'].match(/^git@(.*?):(.*?)\/(.*?)\.git/)
if git_repo_match && git_repo_match[1] && git_repo_match[2]
  destination_directory = File.join(node['goproject']['gopath'], "src", git_repo_match[1], git_repo_match[2])
  app_name = git_repo_match[3]
end

if !destination_directory.nil?
  directory destination_directory do
    action :create
    owner "ubuntu"
    recursive true
  end

  git_destination_directory = File.join(destination_directory, app_name)
  # grab the specified repository and branch of streamtools
  # then notify the next block to build and run it
  git git_destination_directory do
    repository node['goproject']['repository']
    revision node['goproject']['branch']
    action :sync
    user "ubuntu"
  end

  bash "go_get_deps" do
    cwd git_destination_directory
    environment "PATH" => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/go/bin:/home/ubuntu/go/bin", "GOPATH" => "/home/ubuntu/go"
    user "ubuntu"
    code <<-EOH
     go get .
    EOH
  end
end
