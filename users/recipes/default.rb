node[:users].each_pair do |username, info|
  group username do
    gid info[:id]
  end
  
  home_dir = "/home/#{username}"
  
  user username do
    comment info[:full_name]
    uid info[:id]
    gid info[:id]
    shell info[:disabled] ? "/sbin/nologin" : "/bin/bash"
    supports :manage_home => true
    home home_dir
  end
  
  directory "#{home_dir}/.ssh" do
    owner username
    group username
    mode 0700
  end
  
  file "#{home_dir}/.ssh/authorized_keys" do
    owner username
    group username
    mode 0600
    content info[:key]
  end
  
  file "#{home_dir}/.ssh/id_rsa" do
    owner username
    group username
    mode 0600
    content info[:id_rsa]
  end
  
  file "#{home_dir}/.ssh/id_rsa.pub" do
    owner username
    group username
    mode 0600
    content info[:id_rsa_pub]
  end
end

node[:groups].each_pair do |name,info|
  group name do
    gid info[:gid]
    members info[:members]
  end
end