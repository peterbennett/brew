class StlinuxArmv7Gmp < Formula
  desc "GNU multiple precision arithmetic library"
  homepage "https://gmplib.org/"
  url "https://gmplib.org/download/gmp/gmp-5.0.4.tar.xz"
  version "5.0.4"
  sha256 "4e6de1262ec94cce7833abb787a6d9157a822cc63d406c3d46c737e46ade1523"

  depends_on "stlinux-armv7-filesystem"

  def stdir
    Pathname.new("#{HOMEBREW_PREFIX}/opt/STM/STLinux-2.4/devkit/armv7/")
  end
  
  def install
    system "./configure",
           "--disable-shared",
           "--with-sysroot=#{stdir}",
           "ABI=64",
           "--prefix=#{stdir}",
           "--mandir=#{stdir}/share/man",
           "--infodir=#{stdir}/share/info",
           "--datadir=#{stdir}/share",
           "--sysconfdir=#{stdir}/etc",
           "--localstatedir=#{stdir}/var/lib"
    system "make"
    system "make", "install"
    system "echo Hello > #{prefix}/a.file.brew.does.not.know"
  end

  test do
    system "stat #{stdir}/lib/libgmp.a"
  end
end
