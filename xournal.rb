class Xournal < Formula
  desc "An application for notetaking and sketching using a stylus"
  homepage "http://xournal.sourceforge.net"
  url "https://downloads.sourceforge.net/xournal/xournal-0.4.8.tar.gz"
  sha256 "233887a38136452dcb4652c35d08366fc7355f57ed46753db83e3e0f3193ef30"
  revision 2

  bottle do
    sha256 "c6b061589a660dec906fe6dd9d766a89337fa04e126bff36e24affd98cb6544c" => :el_capitan
    sha256 "905312002cc878238e948d901a67fae44b8f88bfd92fdc3648f87e7efc527a66" => :yosemite
    sha256 "8fc4405fde0ef2ad343c299072f3c359fcd75cca7e767271650b5f07b6d0cf87" => :mavericks
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "pkg-config" => :build
  depends_on "gtk+"
  depends_on "poppler"
  depends_on "libgnomecanvas"

  # patch removes all the X11 stuff from the code
  # filed upstream as a bug: https://sourceforge.net/p/xournal/bugs/156/
  patch :DATA

  def install
    system "./autogen.sh", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system "xournal", "-h"
  end
end
__END__
diff --git a/src/Makefile.am b/src/Makefile.am
index 9f9f1a2..6b18256 100644
--- a/src/Makefile.am
+++ b/src/Makefile.am
@@ -31,6 +31,6 @@ if WIN32
   xournal_LDFLAGS = -mwindows
   xournal_LDADD = win32/xournal.res ttsubset/libttsubset.a @PACKAGE_LIBS@ $(INTLLIBS) -lz
 else
-  xournal_LDADD = ttsubset/libttsubset.a @PACKAGE_LIBS@ $(INTLLIBS) -lX11 -lz -lm
+  xournal_LDADD = ttsubset/libttsubset.a @PACKAGE_LIBS@ $(INTLLIBS) -lz -lm
 endif

diff --git a/src/xo-file.c b/src/xo-file.c
index a1c19c9..cc38d14 100644
--- a/src/xo-file.c
+++ b/src/xo-file.c
@@ -31,10 +31,6 @@
 #include <glib/gstdio.h>
 #include <poppler/glib/poppler.h>

-#ifndef WIN32
- #include <gdk/gdkx.h>
- #include <X11/Xlib.h>
-#endif

 #include "xournal.h"
 #include "xo-interface.h"
@@ -1275,50 +1271,8 @@ GList *attempt_load_gv_bg(char *filename)

 struct Background *attempt_screenshot_bg(void)
 {
-#ifndef WIN32
-  struct Background *bg;
-  GdkPixbuf *pix;
-  XEvent x_event;
-  GdkWindow *window;
-  GdkColormap *cmap;
-  int x,y,w,h;
-  Window x_root, x_win;
-
-  x_root = gdk_x11_get_default_root_xwindow();
-
-  if (!XGrabButton(GDK_DISPLAY(), AnyButton, AnyModifier, x_root,
-      False, ButtonReleaseMask, GrabModeAsync, GrabModeSync, None, None))
-    return NULL;
-
-  XWindowEvent (GDK_DISPLAY(), x_root, ButtonReleaseMask, &x_event);
-  XUngrabButton(GDK_DISPLAY(), AnyButton, AnyModifier, x_root);
-
-  x_win = x_event.xbutton.subwindow;
-  if (x_win == None) x_win = x_root;
-
-  window = gdk_window_foreign_new_for_display(gdk_display_get_default(), x_win);
-
-  gdk_window_get_geometry(window, &x, &y, &w, &h, NULL);
-  cmap = gdk_drawable_get_colormap(window);
-  if (cmap == NULL) cmap = gdk_colormap_get_system();
-
-  pix = gdk_pixbuf_get_from_drawable(NULL, window,
-     cmap, 0, 0, 0, 0, w, h);
-
-  if (pix == NULL) return NULL;
-
-  bg = g_new(struct Background, 1);
-  bg->type = BG_PIXMAP;
-  bg->canvas_item = NULL;
-  bg->pixbuf = pix;
-  bg->pixbuf_scale = DEFAULT_ZOOM;
-  bg->filename = new_refstring(NULL);
-  bg->file_domain = DOMAIN_ATTACH;
-  return bg;
-#else
   // not implemented under WIN32
   return FALSE;
-#endif
 }

 /************** pdf annotation ***************/
diff --git a/src/xo-misc.c b/src/xo-misc.c
index 2af7f43..f9003bd 100644
--- a/src/xo-misc.c
+++ b/src/xo-misc.c
@@ -2288,9 +2288,7 @@ void hide_unimplemented(void)
   }

   /* screenshot feature doesn't work yet in Win32 */
-#ifdef WIN32
   gtk_widget_hide(GET_COMPONENT("journalScreenshot"));
-#endif
 }

 // toggle fullscreen mode
