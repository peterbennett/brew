class StlinuxArmv7Gcc < Formula
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
  
  depends_on "stlinux-armv7-filesystem"
  depends_on "stlinux-armv7-gmp"
  depends_on "stlinux-armv7-mpc"
  depends_on "stlinux-armv7-mpfr"
  depends_on "stlinux-armv7-binutils"
  depends_on "stlinux-armv7-autoconf"
  depends_on "stlinux-armv7-core"

  patch :p1 do
    url "https://bitbucket.org/elkton/brew-patches/raw/master/stlinux-armv7-patch/gcc-4.8.3-linaro-4.8-2014.11.patch"
    sha256 "ae685f9fff306ea79dfaa7a37204cfd63825c9639af0f020613ac09a25b9eceb"
  end
  
  patch :p1 do
    url "https://bitbucket.org/elkton/brew-patches/raw/master/stlinux-armv7-patch/gcc-4.8.3-linaro-4.8-2014.11-st.patch"
    sha256 "692a2788d6e153728dd836c5c9af938162832a27dc00c7facbd4e1de06ad6f79"
  end
    
  def stdir
    Pathname.new("#{HOMEBREW_PREFIX}/opt/STM/STLinux-2.4/devkit/armv7/")
  end
  
  def install
    # GCC will suffer build errors if forced to use a particular linker.
    #ENV.delete "LD"
    #ENV.delete "CFLAGS"
    #ENV.delete "CXXFLAGS"
    #Env.delete "LDFLAGS"

    #mpr = Package["stlinux-armv7-mpc"]
    #gmp = Package["stlinux-armv7-gmp"]
    #mpfr = Package["stlinux-armv7-mpfr"]

    ENV.append "CFLAGS", "-fbracket-depth=1024"
    ENV.append "CXXFLAGS", "-fbracket-depth=1024"
    #ENV["CC"]="gcc-4.8"
    #ENV["CXX"]="g++-4.8"

    ENV["LD_LIBRARY_PATH"] = "#{stdir}/lib"
    ENV.prepend_path "PATH", "#{stdir}/bin"

    #ENV["AS"]="armv7-linux-as"
    #ENV["LD"]="armv7-linux-ld"
    #ENV["AR"]="armv7-linux-ar"
    #ENV["CC"]="armv7-linux-gcc"
    #ENV["CXX"]="armv7-linux-g++"

    ENV["AR_FOR_TARGET"] = "#{stdir}/bin/armv7-linux-ar"
    ENV["LD_FOR_TARGET"] = "#{stdir}/bin/armv7-linux-ld"
    ENV["OBJDUMP_FOR_TARGET"] = "#{stdir}/bin/armv7-linux-objdump"
    ENV["NM_FOR_TARGET"] = "#{stdir}/bin/armv7-linux-nm"
    ENV["RANLIB_FOR_TARGET"] = "#{stdir}/bin/armv7-linux-ranlib"
    ENV["READELF_FOR_TARGET"] = "#{stdir}/bin/armv7-linux-readelf"
    ENV["STRIP_FOR_TARGET"] = "#{stdir}/bin/armv7-linux-strip"
    ENV["AS_FOR_TARGET"] = "#{stdir}/bin/armv7-linux-as"
    
    system "#{stdir}/bin/armv7-linux-autoconf"
    #system "autoconf"
    system "mkdir", "../gcc-obj"
    system "cd ../gcc-obj; ../gcc-4.8.3/configure " \
           "--build=#{arch}-apple-darwin#{osmajor} " \
           "--host=#{arch}-apple-darwin#{osmajor} " \
           "--target=arm-cortex-linux-gnueabi " \
           "--prefix=#{stdir} " \
           "--exec-prefix=#{stdir} " \
           "--mandir=#{stdir}/share/man " \
           "--infodir=#{stdir}/share/info " \
           "--datadir=#{stdir}/share " \
           "--sysconfdir=#{stdir}/etc " \
           "--localstatedir=#{stdir}/var/lib " \
           "--program-prefix=armv7-linux- " \
           "--with-local-prefix=#{stdir} " \
           "--with-sysroot=#{stdir}/target " \
           "--enable-target-optspace " \
           "--enable-languages=c,c++ " \
           "--enable-threads=posix " \
           "--disable-libstdcxx-pch " \
           "--disable-multilib " \
           "--enable-nls " \
           "--enable-c99 " \
           "--enable-long-long " \
           "--with-system-zlib " \
           "--enable-shared " \
           "--disable-libgomp " \
           "--with-pkgversion=\"GCC\" " \
           "--with-bugurl=\"https://bitbucket.org/elkton/brew/issues\" " \
           "--disable-libitm " \
           "--enable-symvers=gnu " \
           "--with-mpc=#{stdir} " \
           "--with-gmp=#{stdir} " \
           "--with-mpfr=#{stdir} " \
           "--without-ppl " \
           "--enable-__cxa_atexit " \
           "--with-float=hard " \
           "--with-fp " \
           "--enable-cxx-flags=-mhard-float " \
           "--disable-libsanitizer " \
           "--with-tls=gnu2 " \
           "--with-cpu=cortex-a9"
 
    system "cd ../gcc-obj; make all"
    #system "cd ../gcc-obj; make"
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
    system "#{stdir}/bin/armv7-linux-gcc", "-o", "hello-c", "hello-c.c"

    (testpath/"hello-cc.cc").write <<-EOS.undent
      #include <iostream>
      int main()
      {
        std::cout << "Hello, world!" << std::endl;
        return 0;
      }
    EOS
    system "#{stdir}/bin/armv7-linux-g++", "-o", "hello-cc", "hello-cc.cc"
  end
end
