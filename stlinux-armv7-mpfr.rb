class StlinuxArmv7Mpfr < Formula
  desc "C library for multiple-precision floating-point computations"
  homepage "http://www.mpfr.org/"
  # Upstream is down a lot, so use mirrors
  url "https://mirrors.ocf.berkeley.edu/debian/pool/main/m/mpfr4/mpfr4_3.1.2.orig.tar.xz"
  mirror "https://ftp.gnu.org/gnu/mpfr/mpfr-3.1.2.tar.xz"
  sha256 "399d0f47ef6608cc01d29ed1b99c7faff36d9994c45f36f41ba250147100453b"
  version "3.1.2"
  
  depends_on "stlinux-armv7-filesystem"
  depends_on "stlinux-armv7-gmp"

  def stdir
    Pathname.new("#{HOMEBREW_PREFIX}/opt/STM/STLinux-2.4/devkit/armv7/")
  end
  
  def install
    system "./configure", "--disable-shared",
           "--with-sysroot=#{stdir}",
           "ABI=64",
           "--prefix=#{stdir}",
           "--mandir=#{stdir}/share/man",
           "--infodir=#{stdir}/share/info",
           "--datadir=#{stdir}/share",
           "--sysconfdir=#{stdir}/etc",
           "--localstatedir=#{stdir}/var/lib",
           "--with-gmp=#{stdir}"
    system "make", "install"
    system "echo Hello > #{prefix}/a.file.brew.does.not.know"
  end

  test do
    system "stat #{stdir}/lib/libmpfr.a"
  end
end
