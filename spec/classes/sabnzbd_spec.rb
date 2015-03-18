require 'spec_helper'
lsbdist = {:Debian => 'Ubuntu', :RedHat => 'CentOS', :Suse => 'openSUSE project' }
lcd = {:Debian => 'precise', :RedHat => 'Final', :Suse => 'Harlequin' }
pkg = {:Debian => [ 'sabnzbdplus', 'sabnzbdplus-theme-modile' ], 
       :RedHat => [ 'sabnzbd' ], :Suse => [ 'sabnzbd' ] }
svc = {:Debian => 'sabnzbdplus', :RedHat => 'sabnzbd' , :Suse => 'sabnzbd' }

describe 'sabnzbd' do
  context 'supported operating systems' do
    ['Debian', 'RedHat', 'Suse'].each do |osfamily|
      describe "sabnzbd class without any parameters on #{osfamily}" do
        let(:params) {{ }}
        let(:facts) {{
          :osfamily => osfamily,
          :lsbdistid => lsbdist[osfamily.to_sym],
          :lsbdistcodename => lcd[osfamily.to_sym]
        }}

        it { is_expected.to compile.with_all_deps }

        it { is_expected.to contain_class('sabnzbd') }
        it { is_expected.to contain_class('sabnzbd::defaults') }
        it { is_expected.to contain_class('sabnzbd::install').that_comes_before('sabnzbd::config') }
        it { is_expected.to contain_class('sabnzbd::config') }
        it { is_expected.to contain_class('sabnzbd::service').that_subscribes_to('sabnzbd::config') }

        it { is_expected.to contain_service(svc[osfamily.to_sym]) }
        pkg[osfamily.to_sym].each do |pack| 
         it { is_expected.to contain_package(pack).with_ensure('present') }
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
