class StlinuxSh4Mpc < Formula
  desc "C library for the arithmetic of complex numbers with arbitrarily high precision and correct rounding of the result"
  homepage "http://www.multiprecision.org/"

  #Use the gnu mirror it's easuer
  url "https://ftp.gnu.org/gnu/mpc/mpc-1.0.3.tar.gz"
  sha256 "617decc6ea09889fb08ede330917a00b16809b8db88c29c31bfbb49cbf88ecc3"
  version "1.0.3"
  
  depends_on "stlinux-sh4-filesystem"
  depends_on "stlinux-sh4-gmp"
  depends_on "stlinux-sh4-mpfr"

  def stdir
    Pathname.new("#{HOMEBREW_PREFIX}/opt/STM/STLinux-2.4/devkit/sh4/")
  end
  
  def install
    system "./configure", "--disable-shared",
           "ABI=64",
           "--prefix=#{stdir}",
           "--mandir=#{stdir}/share/man",
           "--infodir=#{stdir}/share/info",
           "--datadir=#{stdir}/share",
           "--sysconfdir=#{stdir}/etc",
           "--localstatedir=#{stdir}/var/lib",
           "--with-gmp=#{stdir}",
           "--with-mpfr=#{stdir}"
    system "make"
    system "make", "install"
    system "echo Hello > #{prefix}/a.file.brew.does.not.know"
  end

  test do
    system "stat #{stdir}/lib/libmpc.a"
  end
end
