class StlinuxSh4Gcc < Formula
  def arch
    if Hardware::CPU.type == :intel
      if MacOS.prefer_64_bit?
        "x86_64"
      else
        "i686"
      end
    elsif Hardware::CPU.type == :ppc
      if MacOS.prefer_64_bit?
        "powerpc64"
      else
        "powerpc"
      end
    end
  end

  def osmajor
    `uname -r`.chomp
  end
  
  desc "GNU compiler collection"
  homepage "https://gcc.gnu.org"
  url "http://ftpmirror.gnu.org/gcc/gcc-4.8.3/gcc-4.8.3.tar.bz2"
  mirror "https://ftp.gnu.org/gnu/gcc/gcc-4.8.3/gcc-4.8.3.tar.bz2"
  sha256 "6a8e4f11b185f4fe2ed9d7fc053e80f8c7e73f800c045f51f9d8bea33f080f1e"
  
  depends_on "stlinux-sh4-filesystem"
  depends_on "stlinux-sh4-gmp"
  depends_on "stlinux-sh4-mpc"
  depends_on "stlinux-sh4-mpfr"
  depends_on "stlinux-sh4-binutils"
  depends_on "stlinux-sh4-autoconf"
  depends_on "stlinux-sh4-core"

  patch :p1 do
    url "https://bitbucket.org/elkton/brew-patches/raw/master/stlinux-sh4-gcc/gcc-4.8.3-stm-140709.patch"
    sha256 "1a4cc52345bdefd7d65d52ae412a398bdd550608a6aa5bc693da59ba0867b0c9"
  end

  patch :p1 do
    url "https://bitbucket.org/elkton/brew-patches/raw/master/stlinux-sh4-gcc/gcc-4.7.0-sh-use-gnu-hash-style.patch"
    sha256 "a62f68a11da892c4b1570d37b762db1f4fbd6f2ae676bb06202c55f77be0fe2b"
  end

  patch :p1 do
    url "https://bitbucket.org/elkton/brew-patches/raw/master/stlinux-sh4-gcc/gcc-4.2.4-multilibpath.patch"
    sha256 "3ecd580024529d9ccfae3f3a153f3ebe969e15572720e523dd46be75c3b2cc99"
  end

  patch :p1 do
    url "https://bitbucket.org/elkton/brew-patches/raw/master/stlinux-sh4-gcc/gcc-4.5.2-sysroot.patch"
    sha256 "664edcb64f18c40dc0042e8527b0064d10747a6118ceb9480f7edd099fa08099"
  end
    
  patch :p1 do
    url "https://bitbucket.org/elkton/brew-patches/raw/master/stlinux-sh4-gcc/gcc-4.8.3-pr64749.patch"
    sha256 "48aa968abd2fbb262953a7e09193d02bb58a5f533555a86d3b87a52e92e97195"
  end
    
  patch :p1 do
    url "https://bitbucket.org/elkton/brew-patches/raw/master/stlinux-sh4-gcc/gcc-4.7.3-stack-protect-strong.patch"
    sha256 "1ae96bc18e49971a3ed7efe754fc089284e3cd95f3a163fbf398516772b0dce7"
  end
    
  def stdir
    Pathname.new("#{HOMEBREW_PREFIX}/opt/STM/STLinux-2.4/devkit/sh4/")
  end
  
  def install
    # GCC will suffer build errors if forced to use a particular linker.
    ENV.delete "LD"
    ENV.delete "CFLAGS"
    ENV.delete "CXXFLAGS"
    ENV.delete "LDFLAGS"

    system "#{stdir}/bin/sh4-linux-autoconf"
    system "mkdir", "../gcc-obj"
    system "cd ../gcc-obj; ../gcc-4.8.3/configure " \
           "--build=#{arch}-apple-darwin#{osmajor} " \
           "--host=#{arch}-apple-darwin#{osmajor} " \
           "--target=sh4-linux " \
           "--prefix=#{stdir} " \
           "--mandir=#{stdir}/share/man " \
           "--infodir=#{stdir}/share/info " \
           "--datadir=#{stdir}/share " \
           "--sysconfdir=#{stdir}/etc " \
           "--localstatedir=#{stdir}/var/lib " \
           "--with-gmp=#{stdir} " \
           "--with-mpfr=#{stdir} " \
           "--program-prefix=sh4-linux- " \
           "--with-local-prefix=#{stdir} " \
           "--with-sysroot=#{stdir}/target " \
           "--enable-target-optspace " \
           "--enable-languages=c,c++ " \
           "--enable-threads=posix " \
           "--disable-libstdcxx-pch " \
           "--enable-nls " \
           "--enable-c99 " \
           "--enable-long-long " \
           "--with-system-zlib " \
           "--enable-shared " \
           "--disable-libgomp " \
           "--with-pkgversion=\"GCC\" " \
           "--with-bugurl=\"https://bitbucket.org/elkton/brew/issues\" " \
           "--disable-libitm " \
           "--enable-multilib " \
           "--disable-multi-sysroot " \
           "--with-multilib-list=m4-nofpu " \
           "--enable-lto " \
           "--enable-symvers=gnu " \
           "--with-mpc=#{stdir} " \
           "--with-gmp=#{stdir} " \
           "--with-mpfr=#{stdir} " \
           "--without-ppl " \
           "--enable-__cxa_atexit " \
           "--with-cpu=sh4"
    system "cd ../gcc-obj; make all-gcc"
    system "cd ../gcc-obj; make"
    system "cd ../gcc-obj; make install"
    system "echo Hello > #{prefix}/a.file.brew.does.not.know"
    
    # We can't install any symlinks, we could do with wrappers for
    # all those tools.    
  end

  test do
    (testpath/"hello-c.c").write <<-EOS.undent
      #include <stdio.h>
      int main()
      {
        puts("Hello, world!");
        return 0;
      }
    EOS
    system "#{stdir}/bin/sh4-linux-gcc", "-o", "hello-c", "hello-c.c"

    (testpath/"hello-cc.cc").write <<-EOS.undent
      #include <iostream>
      int main()
      {
        std::cout << "Hello, world!" << std::endl;
        return 0;
      }
    EOS
    system "#{stdir}/bin/sh4-linux-g++", "-o", "hello-cc", "hello-cc.cc"
  end
end
