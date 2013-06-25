require 'formula'

class Cvs < Formula
  homepage 'http://cvs.nongnu.org'
  url 'http://ftp.gnu.org/non-gnu/cvs/source/stable/1.11.17/cvs-1.11.17.tar.bz2'
  sha1 'd64282e744424ec7c5f92b66e78e5a6fded90ff9'

  depends_on :automake
  def patches
#    [
#     "https://trac.macports.org/export/82549/trunk/dports/devel/cvs/files/patch-getline"
     DATA
#    ]
  end
  def install
    # build fails if these don't exist
    cd "src" do
      system "./configure", "--prefix=#{prefix}"
      system "make install"
    end
  end
end

# First patch is because "wrap_clean_fmt_str" has a return without declaring a type (void).
# second patch is from macports, https://trac.macports.org/browser/trunk/dports/devel/cvs/files/patch-getline?rev=82549 also see https://trac.macports.org/ticket/30785.
# both patches are needed to make CVS build on OSX with clang.
__END__
--- src/wrapper.c.orig	2004-06-09 16:34:55.000000000 +0200
+++ src/wrapper.c	2013-06-25 13:55:38.000000000 +0200
@@ -240,6 +240,7 @@
  * Remove fmt str specifier other than %% or %s. And allow
  * only max_s %s specifiers
  */
+void
 wrap_clean_fmt_str(char *fmt, int max_s)
 {
     while (*fmt) {
--- lib/getline.c.orig	2011-07-26 09:06:04.000000000 +0930
+++ lib/getline.c	2011-07-26 09:06:17.000000000 +0930
@@ -155,7 +155,7 @@
 }
 
 int
-getline (lineptr, n, stream)
+_getline (lineptr, n, stream)
      char **lineptr;
      size_t *n;
      FILE *stream;
--- lib/getline.h.orig	2011-07-26 09:06:08.000000000 +0930
+++ lib/getline.h	2011-07-26 09:06:23.000000000 +0930
@@ -12,7 +12,7 @@
 #define GETLINE_NO_LIMIT -1
 
 int
-  getline __PROTO ((char **_lineptr, size_t *_n, FILE *_stream));
+  _getline __PROTO ((char **_lineptr, size_t *_n, FILE *_stream));
 int
   getline_safe __PROTO ((char **_lineptr, size_t *_n, FILE *_stream,
                          int limit));
