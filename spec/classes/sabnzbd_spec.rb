require 'spec_helper'
lsbdist = {:Debian => 'Ubuntu', :RedHat => 'CentOS', :Suse => 'openSUSE project' }
lcd = {:Debian => 'precise', :RedHat => 'Final', :Suse => 'Harlequin' }
pkg = {:Debian => [ 'sabnzbdplus', 'sabnzbdplus-theme-modile' ], 
       :RedHat => [ 'sabnzbd' ], :Suse => [ 'SABnzbd', 'cheeta','unrar','par2'] }
svc = {:Debian => 'sabnzbdplus', :RedHat => 'sabnzbd' , :Suse => 'sabnzbd' }
rcsrc = {:Debian => 'init.Debian', :RedHat => 'init.RedHat' , :Suse => 'systemd.Suse' }
rcfile = {:Debian => '/etc/init.d/sabnzbd', :RedHat => '/etc/init.d/sabnzbd' , :Suse => '/var/lib/systemd/migrated/sabnzbd' }

describe 'sabnzbd' do
  context 'supported operating systems' do
    ['Debian', 'RedHat', 'Suse'].each do |osfamily|
      describe "sabnzbd class without any parameters on #{osfamily}" do
        let(:params) {{ }}
        let(:facts) {{
          :osfamily => osfamily,
          :lsbdistid => lsbdist[osfamily.to_sym],
          :lsbdistcodename => lcd[osfamily.to_sym],
          :os_maj_version => 6,
          :architecture => 'x68_64'
        }}

        it { is_expected.to compile.with_all_deps }

        it { is_expected.to contain_class('sabnzbd') }
        it { is_expected.to contain_class('sabnzbd::defaults') }
        it { is_expected.to contain_class('sabnzbd::repo').that_comes_before('sabnzbd::install') }
        it { is_expected.to contain_class('sabnzbd::install').that_comes_before('sabnzbd::config') }
        it { is_expected.to contain_class('sabnzbd::config') }
        it { is_expected.to contain_class('sabnzbd::service').that_subscribes_to('sabnzbd::config') }

        it { is_expected.to contain_service(svc[osfamily.to_sym]) }
        it { is_expected.to contain_file(rcfile[osfamily.to_sym]).with_source("puppet:///modules/sabnzbd/#{rcsrc[osfamily.to_sym]}") }
        pkg[osfamily.to_sym].each do |pack| 
         it { is_expected.to contain_package(pack).with_ensure('present') }
        end
        if osfamily == 'Debian'
          it { is_expected.to contain_anchor('apt::source::ppajcfp_ppa') }
          it { is_expected.to contain_apt__source('ppajcfp_ppa') }
          it { is_expected.to contain_class('apt::params') }
          it { is_expected.to contain_class('apt::update') }
          it { is_expected.to contain_exec('apt_update') }
          it { is_expected.to contain_file('ppajcfp_ppa.list') }
          it { is_expected.to contain_sabnzbd__repo__ppa('ppa:jcfp/ppa') }
        end
        if osfamily == 'RedHat'

          it { is_expected.to contain_yumrepo('http__dl.fedoraproject.org_pub_epel_6_x68_64') }
          it { is_expected.to contain_yumrepo('http__packages.atrpms.net_dist_el6_unrar_') }
          it { is_expected.to contain_yumrepo('https__dl.dropboxusercontent.com_u_14500830_SABnzbd_RHEL-CentOS_6') }
          it { is_expected.to contain_sabnzbd__repo__yum('http://dl.fedoraproject.org/pub/epel/6/x68_64') }
          it { is_expected.to contain_sabnzbd__repo__yum('http://packages.atrpms.net/dist/el6/unrar/') }
          it { is_expected.to contain_sabnzbd__repo__yum('https://dl.dropboxusercontent.com/u/14500830/SABnzbd/RHEL-CentOS/6') }
        end
        if osfamily == 'Suse'
          it { is_expected.to contain_zypprepo('http__download.opensuse.org_repositories_Archiving_SLE_12') }
          it { is_expected.to contain_zypprepo('http__download.opensuse.org_repositories_home_jjfalling_branches_home_chenxiaolong_SABnzbd_openSUSE_13.2') }
          it { is_expected.to contain_sabnzbd__repo__zyp('http://download.opensuse.org/repositories/Archiving/SLE_12') }
          it { is_expected.to contain_sabnzbd__repo__zyp('http://download.opensuse.org/repositories/home:/jjfalling:/branches:/home:/chenxiaolong:/SABnzbd/openSUSE_13.2') }
        end
     end
    end
  end
  
  context 'unsupported operating system' do
    describe 'sabnzbd class without any parameters on Solaris/Nexenta' do
      let(:facts) {{
        :osfamily        => 'Solaris',
        :operatingsystem => 'Nexenta',
      }}

      it { expect { is_expected.to contain_package('sabnzbd') }.to raise_error(Puppet::Error, /Nexenta not supported/) }
    end
  end
end
