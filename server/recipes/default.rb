# 
#   A Basic Server configuration
#


execute "Update apt repositories" do
  command "apt-get update"
end

node[:base_packages].each do |pkg|
  package pkg do
    :upgrade
  end
end