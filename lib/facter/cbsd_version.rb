cbsd_version = `/usr/local/bin/cbsd version | tr -d '\n'`

Facter.add(:cbsd_version) do
  setcode do
    cbsd_version
  end
end
