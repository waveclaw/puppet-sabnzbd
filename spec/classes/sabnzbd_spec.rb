require 'spec_helper'
lsbdist = {:Debian => 'Ubuntu', :RedHat => 'CentOS', :Suse => 'openSUSE project' }
lcd = {:Debian => 'precise', :RedHat => 'Final', :Suse => 'Harlequin' }
pkg = {:Debian => [ 'sabnzbdplus', 'sabnzbdplus-theme-mobile' ], 
       :RedHat => [ 'sabnzbd' ], :Suse => [ 'sabnzbd' ] }
svc = {:Debian => 'sabnzbdplus', :RedHat => 'sabnzbd' , :Suse => 'sabnzbd' }
confile = {:Debian => 'sabnzbdplus', :RedHat => 'sabnzbd' , :Suse => 'sabnzbd' }
confpath = {:Debian => '/etc/defaults', :RedHat => '/etc/sysconfig' , :Suse => '/etc/sysconfig' }

describe 'sabnzbd' do
  context 'supported operating systems' do
    ['RedHat', 'Suse'].each do |osfamily|
      describe "without any parameters on #{osfamily}" do
        let(:params) {{ }}
        let(:facts) {{
          :osfamily => osfamily,
          :operatingsystem => lsbdist[osfamily.to_sym],
          :lsbdistid => lsbdist[osfamily.to_sym],
          :lsbdistcodename => lcd[osfamily.to_sym],
          :os_maj_version => 6,
          :architecture => 'x68_64'
        }}
        let('apt::xfacts') {{
          :lsbdistcodename => lcd[osfamily.to_sym],
        }}

        it { is_expected.to compile.with_all_deps }

        it { is_expected.to contain_class('sabnzbd') }
        it { is_expected.to contain_class('sabnzbd::defaults') }
        it { is_expected.to contain_class('sabnzbd::users').that_comes_before('sabnzbd::repo') }
        it { is_expected.to contain_class('sabnzbd::repo').that_comes_before('sabnzbd::install') }
        it { is_expected.to contain_class('sabnzbd::install').that_comes_before('sabnzbd::sysconfig') }
        it { is_expected.to contain_class('sabnzbd::sysconfig').that_comes_before('sabnzbd::config') }
        it { is_expected.to contain_class('sabnzbd::config') }
        it { is_expected.to contain_class('sabnzbd::service').that_subscribes_to('sabnzbd::config') }
        it { is_expected.to contain_user('sabnzbd') }
        it { is_expected.to contain_group('sabnzbd') }
        it { is_expected.to contain_file('/var/lib/sabnzbd') }
        it { is_expected.to contain_file('/var/lib/sabnzbd/logs') }
        it { is_expected.to contain_file('/var/lib/sabnzbd/Downloads') }
        it { is_expected.to contain_file('/var/lib/sabnzbd/Incomplete') }
        it { is_expected.to contain_file('/var/lib/sabnzbd/.config') }
        it { is_expected.to contain_file('/var/lib/sabnzbd/.config/sabnzbd.ini') }

        it { is_expected.to contain_service(svc[osfamily.to_sym]) }
        it { is_expected.to contain_file(confpath[osfamily.to_sym] + '/' + confile[osfamily.to_sym]) }
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
          it { is_expected.to contain_sabnzbd__repo__zyp('http://download.opensuse.org/repositories/Archiving/SLE_12') }
          it { is_expected.to contain_sabnzbd__repo__zyp('http://download.opensuse.org/repositories/home:/waveclaw:/HTPC/SLE_12') }
          it { is_expected.to contain_zypprepo('http__download.opensuse.org_repositories_Archiving_SLE_12') }
          it { is_expected.to contain_zypprepo('http__download.opensuse.org_repositories_home_waveclaw_HTPC_SLE_12') }
        end
     end
      describe "with parameters on #{osfamily}" do
        let(:params) {{
  :user_name           =>'bar',
  :user_home           =>'/tmp',
  :group_name          =>'baz',
  :repo_name           =>'file://wheezy',
  :package_name        =>'moany',
  :service_name        =>'sleepy',
  :config_file_path    =>'/not/top',
  :sysconfig_file_path =>'/some/where',
  :sysconfig_file_name =>'sabnzbd',
  :download_dir        =>'/up',
  :incomplete_dir      =>'/you',
  :apikey              =>'12345',
  :rating_api_key      =>'12345',
  :nzb_key             =>'12345',
  :webuser             =>'fool',
  :webpass             =>'mostly',
  :servers             =>{ 'foo' => { 'setting' => 'a' } }
        }}
        let(:facts) {{
          :osfamily => osfamily,
          :operatingsystem => lsbdist[osfamily.to_sym],
          :lsbdistid => lsbdist[osfamily.to_sym],
          :lsbdistcodename => lcd[osfamily.to_sym],
          :os_maj_version => 6,
          :architecture => 'x68_64'
        }}
        let('apt::xfacts') {{
          :lsbdistcodename => lcd[osfamily.to_sym],
        }}

        it { is_expected.to compile.with_all_deps }

        it { is_expected.to contain_class('sabnzbd') }
        it { is_expected.to contain_class('sabnzbd::defaults') }
        it { is_expected.to contain_class('sabnzbd::users').that_comes_before('sabnzbd::repo') }
        it { is_expected.to contain_class('sabnzbd::repo').that_comes_before('sabnzbd::install') }
        it { is_expected.to contain_class('sabnzbd::install').that_comes_before('sabnzbd::sysconfig') }
        it { is_expected.to contain_class('sabnzbd::sysconfig').that_comes_before('sabnzbd::config') }
        it { is_expected.to contain_class('sabnzbd::config') }
        it { is_expected.to contain_class('sabnzbd::service').that_subscribes_to('sabnzbd::config') }
        it { is_expected.to contain_user('bar') }
        it { is_expected.to contain_group('baz') }

        it { is_expected.to contain_file('/some/where/sabnzbd') }
        it { is_expected.to contain_file('/up') }
        it { is_expected.to contain_file('/you') }
        if osfamily == 'RedHat'
          it { is_expected.to contain_sabnzbd__repo__yum('file://wheezy') }
          it { is_expected.to contain_yumrepo('file__wheezy') }
        end
        if osfamily == 'Suse'
         it { is_expected.to contain_sabnzbd__repo__zyp('file://wheezy') }
         it { is_expected.to contain_zypprepo('file__wheezy') }
        end
        if osfamily == 'Debian'
          # do nothing
        end
        it { is_expected.to contain_service('sleepy') }
        #it { is_expected.to contain_file('/not/top') }
        it { is_expected.to contain_package('moany').with_ensure('present') }
      end
    end
  end
  
  context 'unsupported operating system' do
    describe 'sabnzbd class without any parameters on Solaris/Nexenta' do
      let(:facts) {{
        :osfamily        => 'Solaris',
        :operatingsystem => 'Nexenta',
      }}

      it { expect { is_expected.to contain_class('sabnzbd') }.to raise_error(Puppet::Error, /Nexenta not supported/) }
    end
  end
end
