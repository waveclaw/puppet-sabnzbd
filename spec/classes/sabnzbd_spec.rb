require 'spec_helper'

describe 'sabnzbd' do
  context 'supported operating systems' do
    ['Debian', 'RedHat'].each do |osfamily|
      describe "sabnzbd class without any parameters on #{osfamily}" do
        let(:params) {{ }}
        let(:facts) {{
          :osfamily => osfamily,
        }}

        it { is_expected.to compile.with_all_deps }

        it { is_expected.to contain_class('sabnzbd::defaults') }
        it { is_expected.to contain_class('sabnzbd::install').that_comes_before('sabnzbd::config') }
        it { is_expected.to contain_class('sabnzbd::config') }
        it { is_expected.to contain_class('sabnzbd::service').that_subscribes_to('sabnzbd::config') }

        it { is_expected.to contain_service('sabnzbd') }
        it { is_expected.to contain_package('sabnzbd').with_ensure('present') }
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
