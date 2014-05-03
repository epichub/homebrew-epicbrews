require 'formula'
 
 class StockfishBook < Formula
   url 'http://cl.ly/3x333m0G173F/download/stockfish-231-book.zip'
   sha1 '8206b99ceb803b23980f1cb30ea41a450e21ae03'
 end
 
 class Stockfish < Formula
   homepage 'http://stockfishchess.org/'
   url 'https://github.com/mcostalba/Stockfish/archive/sf_2.3.1.zip'
   version '231'
   sha1 'e5b9bcb8ce7e89f44b9e491f7636b98c003368b5'
 
   def patches
     {:p0 => DATA}
   end
   
   def install
     cd('src')
     system "make", "clean"
     system "make", "profile-build", "ARCH=osx-x86-64", "COMP=clang"
     system "make", "testrun"
     system "make", "-e" , "PREFIX=#{prefix}", "install"
 
     ohai 'Installing opening book ...'
     StockfishBook.new.brew { bin.install Dir['*'] }
   end
 

 
   def test
     system "'quit' | stockfish"
   end
 end
 
__END__
--- src/Makefile.orig	2014-04-30 15:54:09.000000000 +0200
+++ src/Makefile	2014-04-30 15:56:24.000000000 +0200
@@ -466,13 +466,13 @@
 gcc-profile-make:
 	$(MAKE) ARCH=$(ARCH) COMP=$(COMP) \
 	EXTRACXXFLAGS='-fprofile-generate' \
-	EXTRALDFLAGS='-lgcov' \
+	EXTRALDFLAGS='' \
 	all
 
 gcc-profile-use:
 	$(MAKE) ARCH=$(ARCH) COMP=$(COMP) \
 	EXTRACXXFLAGS='-fprofile-use' \
-	EXTRALDFLAGS='-lgcov' \
+	EXTRALDFLAGS='' \
 	all
 
 gcc-profile-clean:
