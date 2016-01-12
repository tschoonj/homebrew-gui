class Gobby < Formula
  desc "A collaborative editor supporting multiple documents a multi-use chatbox"
  homepage "http://gobby.0x539.de"
  url "http://releases.0x539.de/gobby/gobby-0.5.0.tar.gz"
  sha256 "8ceb3598d27cfccdf9c9889b781c4c5c8e1731ca6beb183f5d4555644c06bd98"
  revision 2

  head "git://git.0x539.de/git/gobby.git"

  bottle do
    sha256 "a60a3212c50e11f1a3fb1997bb2d9105d16b3e70c453a7c9615e140cd427926f" => :el_capitan
    sha256 "293979a8259880fc1652425af13df03bd31eba70fa7e75cf5453e6c959c90954" => :yosemite
    sha256 "471b70aa53d01f8c545876d52380eafbbafe34626bdaca33c9f3d7ec4d230cc3" => :mavericks
  end

  # necessary to remove mandatory gtk-mac-integration
  # it's badly broken as it depends on an ancient version of ige-mac-integration
  # since it depends on gtk3, it doesn't even need gtk-mac-integration anymore
  # This has already been fixed upstream: gtk2 support has been dropped completely
  # and all traces of ige-mac-integration have been removed from the code
  patch :DATA

  depends_on "pkg-config" => :build
  depends_on "intltool" => :build
  depends_on "gtkmm3"
  depends_on "gsasl"
  depends_on "libxml++"
  depends_on "gtksourceview3"
  depends_on "gettext"
  depends_on "hicolor-icon-theme"
  depends_on "libinfinity"

  needs :cxx11

  def install
    ENV.cxx11
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}", "--with-gtk3"
    system "make", "install"
  end

  test do
    # executable (GUI)
    system "gobby-0.5", "--version"
  end
end
__END__
diff --git a/code/core/header.cpp b/code/core/header.cpp
index eba2fb1..510608e 100644
--- a/code/core/header.cpp
+++ b/code/core/header.cpp
@@ -24,10 +24,6 @@
 #include <gtksourceview/gtksourcelanguage.h>
 #include <gdk/gdkkeysyms.h>

-#ifdef PLATFORM_OSX_NATIVE
-#include <ige-mac-menu.h>
-#endif
-
 namespace {
	Glib::ustring ui_desc =
		"<ui>"
@@ -519,28 +515,7 @@ Gobby::Header::Header(Preferences& preferences,
		);
	}

-#ifdef PLATFORM_OSX_NATIVE
-	ige_mac_menu_set_menu_bar(GTK_MENU_SHELL(m_menubar->gobj()));
-
-	ige_mac_menu_set_quit_menu_item(GTK_MENU_ITEM(
-		m_ui_manager->get_widget(
-			"/MenuMainBar/MenuFile/FileQuit")->gobj()));
-
-	ige_mac_menu_add_app_menu_item(
-		ige_mac_menu_add_app_menu_group(), GTK_MENU_ITEM(
-			m_ui_manager->get_widget(
-				"/MenuMainBar/MenuHelp/HelpAbout")->gobj()),
-		NULL);
-
-	 ige_mac_menu_add_app_menu_item(
-	 	ige_mac_menu_add_app_menu_group(), GTK_MENU_ITEM(
-			m_ui_manager->get_widget(
-				"/MenuMainBar/MenuEdit/EditPreferences")
-			->gobj()),
-		NULL);
-#else
	pack_start(*m_menubar, Gtk::PACK_SHRINK);
-#endif
	pack_start(*m_toolbar, Gtk::PACK_SHRINK);

	m_toolbar->set_toolbar_style(preferences.appearance.toolbar_style);
diff --git a/configure b/configure
index 7dabb26..0987444 100755
--- a/configure
+++ b/configure
@@ -4955,7 +4955,7 @@ $as_echo "#define PLATFORM_OSX 1" >>confdefs.h

 $as_echo "#define PLATFORM_OSX_NATIVE 1" >>confdefs.h

-    required_libs="$required_libs ige-mac-integration"
+    required_libs="$required_libs"
   fi
 fi
 cat >confcache <<\_ACEOF
