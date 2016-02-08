class UpnpRouterControl < Formula
  desc "UPnP router monitor tool"
  homepage "https://launchpad.net/upnp-router-control"
  url "https://launchpad.net/upnp-router-control/trunk/0.2/+download/upnp-router-control-0.2.tar.gz"
  sha256 "c8a86a54687379fd7b85dc9156a3858897ee1d7af75354e68358243f03d03820"
  revision 1

  bottle do
    sha256 "417cb8bd581eea275f912ab449559d68a8b19223619d3b2bf95e8912876018c9" => :el_capitan
    sha256 "4f219dc5295a1c05ace1a2fcdb0d73d5bcc38a721155ff325433e79d653faaa5" => :yosemite
    sha256 "07d83a8956c678fadb14940b325a6db2e23a3e8159ba9e79cc6d2a8a722ecd30" => :mavericks
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
