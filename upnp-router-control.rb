class UpnpRouterControl < Formula
  desc "UPnP router monitor tool"
  homepage "https://launchpad.net/upnp-router-control"
  url "https://launchpad.net/upnp-router-control/trunk/0.2/+download/upnp-router-control-0.2.tar.gz"
  sha256 "c8a86a54687379fd7b85dc9156a3858897ee1d7af75354e68358243f03d03820"
  revision 1

  bottle do
    sha256 "3ceccf8fa6769da1d774259e1402e50a9c866b67782f8b1837efa3299f27f421" => :yosemite
    sha256 "75adbd8b58dccc704460e6354e7a94f43102806f54e31166702bfab7c628f444" => :mavericks
    sha256 "f5f105a0c1c85f2949431514105d56a050e671e47e9b43742276a2907d7e777e" => :mountain_lion
  end

  head do
    url "lp:upnp-router-control", :using => :bzr

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end

  depends_on "pkg-config" => :build
  depends_on "intltool" => :build
  depends_on "gettext"
  depends_on "gtk+"
  depends_on "gupnp"
  depends_on "gssdp"
  depends_on "curl" => :optional

  # Per Debian, patch to compile against newer gupnp
  patch :DATA

  def install
    system "./autogen.sh" if build.head?

    # Recent gupnp pc files don"t export symbols from gssdp
    # Bug Ref: https://bugs.launchpad.net/upnp-router-control/+bug/1100236
    unless build.head?
      ENV.append_to_cflags `pkg-config --cflags gssdp-1.0`.chomp
      ENV["LIBS"] = `pkg-config --libs gssdp-1.0`.chomp
    end

    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system "#{bin}/upnp-router-control", "--version"
  end
end

__END__
Description: Add -lm to LDADD to fix libm underlinkage.
Debian-Bug: http://bugs.debian.org/713706
Author: Barry deFreese <bdefreese@debian.org>
Index: upnp-router-control-0.2/src/Makefile.am
===================================================================
--- upnp-router-control-0.2.orig/src/Makefile.am	2010-10-14 18:02:51.000000000 -0400
+++ upnp-router-control-0.2/src/Makefile.am	2013-07-13 10:10:02.406318866 -0400
@@ -20,7 +20,7 @@
        urc-graph.c \
        urc-graph.h

-upnp_router_control_LDADD = @GTK_LIBS@ @INTLLIBS@ @GUPNP_LIBS@ @LIBCURL_LIBS@
+upnp_router_control_LDADD = @GTK_LIBS@ @INTLLIBS@ @GUPNP_LIBS@ @LIBCURL_LIBS@ -lm

 MAINTAINERCLEANFILES =				\
	*~			      				\
Index: upnp-router-control-0.2/src/Makefile.in
===================================================================
--- upnp-router-control-0.2.orig/src/Makefile.in	2010-10-14 18:07:44.000000000 -0400
+++ upnp-router-control-0.2/src/Makefile.in	2013-07-13 10:10:41.238511424 -0400
@@ -213,7 +213,7 @@
        urc-graph.c \
        urc-graph.h

-upnp_router_control_LDADD = @GTK_LIBS@ @INTLLIBS@ @GUPNP_LIBS@ @LIBCURL_LIBS@
+upnp_router_control_LDADD = @GTK_LIBS@ @INTLLIBS@ @GUPNP_LIBS@ @LIBCURL_LIBS@ -lm
 MAINTAINERCLEANFILES = \
	*~			      				\
	Makefile.in
