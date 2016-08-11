class Gsmartcontrol < Formula
  desc "Graphical user interface for smartctl"
  homepage "http://gsmartcontrol.sourceforge.net/home/index.php"
  url "https://downloads.sourceforge.net/project/gsmartcontrol/0.8.7/gsmartcontrol-0.8.7.tar.bz2"
  sha256 "708fa803243abb852ed52050fc82cd3592a798c02743342441996e77f19ffec6"
  revision 2

  bottle do
    sha256 "120270b91a39a926d0d6a67ae60fe1defd0f5159abe046f0940adb49ae42ec72" => :el_capitan
    sha256 "f91ec72bc3ca5669ea15d887f29ac9c6cecb83aefb2c7f89a9153764bfe856dd" => :yosemite
    sha256 "939e4dec3c2f0e764bc196a10b0a115b621a98d25ebf8947a6493f76dd261ac6" => :mavericks
  end

  depends_on "pkg-config" => :build
  depends_on "smartmontools"
  depends_on "gtkmm"
  depends_on "pcre"

  needs :cxx11

  # Fix bad includes with gtkmm-2.24.3
  # Check if this is still needed with new versions of gsmartcontrol and gtkmm
  patch :DATA

  def install
    ENV.cxx11
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end

  test do
    system "#{bin}/gsmartcontrol", "--version"
  end
end

__END__
diff --git a/src/applib/cmdex_sync_gui.cpp b/src/applib/cmdex_sync_gui.cpp
index d253a17..83b2e11 100644
--- a/src/applib/cmdex_sync_gui.cpp
+++ b/src/applib/cmdex_sync_gui.cpp
@@ -9,6 +9,7 @@
 /// \weakgroup applib
 /// @{

+#include <glibmm.h>
 #include <gtkmm/main.h>  // Gtk::Main

 #include "hz/fs_path.h"
diff --git a/src/gsc_init.cpp b/src/gsc_init.cpp
index 0ded7bc..6fb1bb7 100644
--- a/src/gsc_init.cpp
+++ b/src/gsc_init.cpp
@@ -15,6 +15,7 @@
 #include <cstdio>  // std::printf
 #include <vector>
 #include <sstream>
+#include <glibmm.h>
 #include <gtkmm/main.h>
 #include <gtkmm/messagedialog.h>
 #include <gtk/gtk.h>  // gtk_window_set_default_icon_name, gtk_icon_theme_*
