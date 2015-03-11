case platform?
  when 'ubuntu'

  when 'centos'
    bash "fix vbox setup" do
      user 'vagrant'
      group 'vagrant'
      code <<-EOC
        sudo yum -y update kernel
        sudo yum -y install kernel-devel kernel-headers dkms gcc gcc-c++
        export KERN_DIR=`ls -t /usr/src/kernels/|head -1`
        sudo /etc/init.d/vboxadd setup
      EOC
    end

end