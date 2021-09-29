require 'English'

Facter.add(:cbsd_version) do
  confine osfamily: 'FreeBSD'
  setcode do
    if File.exist?('/usr/local/bin/cbsd')
      cbsd_version = `/usr/local/bin/cbsd version | tr -d '\n'`
      #Facter::Core::Execution.execute('/usr/bin/needs-restarting --reboothint')
      #!$CHILD_STATUS.success?
    end
  end
end
