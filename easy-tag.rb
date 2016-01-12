class EasyTag < Formula
  desc "Application for viewing and editing audio file tags"
  homepage "https://projects.gnome.org/easytag"
  url "https://download.gnome.org//sources/easytag/2.4/easytag-2.4.0.tar.xz"
  sha256 "b8d882bc168abca96b1b369b10e5b97fa29a7a43f7b33f34489768d111610c3d"

  bottle do
    sha256 "1000f29472e58ce6e4b7c076b2ce4ff25cd67fcef7cda40fc7a46d15f74d8435" => :yosemite
    sha256 "70d49235dc4e64c2bd8548e9154066cc8f9bb9c09fcabf409e812956e396a9c7" => :mavericks
    sha256 "8310b39c9f259b256c69a0213297281b76bbe5b784916b78f52fcbb82f99b3c3" => :mountain_lion
  end

  depends_on "pkg-config" => :build
  depends_on "intltool" => :build
  depends_on "itstool" => :build
  depends_on "gtk+3"
  depends_on "hicolor-icon-theme"
  depends_on "gnome-icon-theme"
  depends_on "id3lib"
  depends_on "libid3tag"
  depends_on "taglib"

  depends_on "libvorbis" => :recommended
  depends_on "flac" => :recommended
  depends_on "libogg" if build.with? "flac"

  depends_on "speex" => :optional
  depends_on "wavpack" => :optional

  # fixes unknown linker flag error: bug was filed as https://bugzilla.gnome.org/show_bug.cgi?id=750981
  # forces use of gtk3-update-icon-cache instead of gtk-update-icon-cache. No bugreport should
  # be filed for this since it only occurs because Homebrew renames gtk+3's gtk-update-icon-cache
  # to gtk3-update-icon-cache in order to avoid a collision between gtk+ and gtk+3.
  patch :DATA

  def install
    ENV.append_path "PYTHONPATH", "#{Formula["libxml2"].opt_lib}/python2.7/site-packages"
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--disable-schemas-compile"
    system "make"
    ENV.deparallelize # make install fails in parallel
    system "make", "install"
  end

  def post_install
    system "#{Formula["glib"].opt_bin}/glib-compile-schemas", "#{HOMEBREW_PREFIX}/share/glib-2.0/schemas"
  end

  test do
    system "#{bin}/easytag", "--version"
  end
end
__END__
diff --git a/Makefile.in b/Makefile.in
index 672f271..94e84a8 100644
--- a/Makefile.in
+++ b/Makefile.in
@@ -1121,7 +1121,7 @@ dist_appiconscalable_DATA = \
 dist_appiconsymbolic_DATA = \
	data/icons/symbolic/easytag-symbolic.svg

-UPDATE_ICON_CACHE = gtk-update-icon-cache --ignore-theme-index --force
+UPDATE_ICON_CACHE = gtk3-update-icon-cache --ignore-theme-index --force
 dist_noinst_DATA = \
	$(appdata_in_files) \
	$(desktop_in_files) \
diff --git a/configure b/configure
index 26a01f0..cfefab6 100755
--- a/configure
+++ b/configure
@@ -20466,77 +20466,6 @@ fi



-for flag in          -Wl,--no-as-needed              ; do
-  as_CACHEVAR=`$as_echo "ax_cv_check_cflags_$ax_compiler_flags_test_$flag" | $as_tr_sh`
-{ $as_echo "$as_me:${as_lineno-$LINENO}: checking whether C compiler accepts $flag" >&5
-$as_echo_n "checking whether C compiler accepts $flag... " >&6; }
-if eval \${$as_CACHEVAR+:} false; then :
-  $as_echo_n "(cached) " >&6
-else
-
-  ax_check_save_flags=$CFLAGS
-  CFLAGS="$CFLAGS $ax_compiler_flags_test $flag"
-  cat confdefs.h - <<_ACEOF >conftest.$ac_ext
-/* end confdefs.h.  */
-
-int
-main ()
-{
-
-  ;
-  return 0;
-}
-_ACEOF
-if ac_fn_c_try_compile "$LINENO"; then :
-  eval "$as_CACHEVAR=yes"
-else
-  eval "$as_CACHEVAR=no"
-fi
-rm -f core conftest.err conftest.$ac_objext conftest.$ac_ext
-  CFLAGS=$ax_check_save_flags
-fi
-eval ac_res=\$$as_CACHEVAR
-	       { $as_echo "$as_me:${as_lineno-$LINENO}: result: $ac_res" >&5
-$as_echo "$ac_res" >&6; }
-if eval test \"x\$"$as_CACHEVAR"\" = x"yes"; then :
-
-if ${WARN_LDFLAGS+:} false; then :
-
-  case $WARN_LDFLAGS in #(
-  "* $flag *|*$flag") :
-    { { $as_echo "$as_me:${as_lineno-$LINENO}: : WARN_LDFLAGS already contains \$flag"; } >&5
-  (: WARN_LDFLAGS already contains $flag) 2>&5
-  ac_status=$?
-  $as_echo "$as_me:${as_lineno-$LINENO}: \$? = $ac_status" >&5
-  test $ac_status = 0; } ;; #(
-  *) :
-
-     as_fn_append WARN_LDFLAGS " $flag"
-     { { $as_echo "$as_me:${as_lineno-$LINENO}: : WARN_LDFLAGS=\"\$WARN_LDFLAGS\""; } >&5
-  (: WARN_LDFLAGS="$WARN_LDFLAGS") 2>&5
-  ac_status=$?
-  $as_echo "$as_me:${as_lineno-$LINENO}: \$? = $ac_status" >&5
-  test $ac_status = 0; }
-     ;;
-esac
-
-else
-
-  WARN_LDFLAGS=$flag
-  { { $as_echo "$as_me:${as_lineno-$LINENO}: : WARN_LDFLAGS=\"\$WARN_LDFLAGS\""; } >&5
-  (: WARN_LDFLAGS="$WARN_LDFLAGS") 2>&5
-  ac_status=$?
-  $as_echo "$as_me:${as_lineno-$LINENO}: \$? = $ac_status" >&5
-  test $ac_status = 0; }
-
-fi
-
-else
-  :
-fi
-
-done
-

     if test "$ax_enable_compile_warnings" != "no"; then :
