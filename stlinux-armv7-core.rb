class StlinuxArmv7Core < Formula
  desc "Core binaries and development files for ARMV7 target filesystem"
  homepage "http://www.stlinux.com"
  url "https://bitbucket.org/elkton/brew-patches/raw/master/stlinux-armv7-patch/target-core-armv7-2.4.tar.bz2"
  sha256 "81a0c5a58d22c5bd7300495ee718c24fed10f7b89d4af815ad575409d0d95524"
  version "2.4"
  
  depends_on "stlinux-armv7-filesystem"
  
  def stdir
    Pathname.new("#{HOMEBREW_PREFIX}/opt/STM/STLinux-2.4/devkit/armv7/")
  end
  
  def install
    system "pushd ..; cp -prf target #{stdir}; popd"
    system "rm -rf #{stdir}/target/.brew_home"
    system "echo Hello > #{prefix}/a.file.brew.does.not.know"
  end

  test do
    system "stat #{stdir}/target/etc/fstab"
    system "stat #{stdir}/target/tmp"
  end
end
