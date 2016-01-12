class Terminator < Formula
  desc "Multiple terminals in one window"
  homepage "http://gnometerminator.blogspot.com/p/introduction.html"
  url "https://launchpad.net/terminator/trunk/0.98/+download/terminator-0.98.tar.gz"
  sha256 "0a6d8c9ffe36d67e60968fbf2752c521e5d498ceda42ef171ad3e966c02f26c1"
  head "lp:terminator", :using => :bzr

  stable do
    # Patch to fix cwd resolve issue for OS X / Darwin
    # See: https://bugs.launchpad.net/terminator/+bug/1261293
    # Should be fixed in next release after 0.98
    patch :DATA
  end

  bottle do
    cellar :any_skip_relocation
    sha256 "f6da6d12c1b57c53936cb64d467fe70c509686e5393226216087a57c527de3d3" => :el_capitan
    sha256 "49b91589167893425ea2c7bdf700d9e6f47e72b7caacc2a4c06bab6d61d0760d" => :yosemite
    sha256 "7c6d3f693ee50ba43106f04fe746d6364404ce30b0fe73f8bedb12eeec254133" => :mavericks
  end

  depends_on "pkg-config" => :build
  depends_on "intltool" => :build
  depends_on :python if MacOS.version <= :snow_leopard
  depends_on "vte"
  depends_on "pygtk"
  depends_on "pygobject"
  depends_on "pango"

  def install
    ENV.prepend_create_path "PYTHONPATH", lib/"python2.7/site-packages"
    system "python", *Language::Python.setup_install_args(prefix)
  end

  def post_install
    system "#{Formula["gtk"].opt_bin}/gtk-update-icon-cache", "-f",
           "-t", "#{HOMEBREW_PREFIX}/share/icons/hicolor"
  end

  test do
    system "#{bin}/terminator", "--version"
  end
end

__END__
diff --git a/terminatorlib/cwd.py b/terminatorlib/cwd.py
index 7b17d84..e3bdbad 100755
--- a/terminatorlib/cwd.py
+++ b/terminatorlib/cwd.py
@@ -49,6 +49,11 @@ def get_pid_cwd():
         func = sunos_get_pid_cwd
     else:
         dbg('Unable to determine a get_pid_cwd for OS: %s' % system)
+        try:
+            import psutil
+            func = generic_cwd
+        except (ImportError):
+            dbg('psutil not found')

     return(func)

@@ -71,4 +76,9 @@ def sunos_get_pid_cwd(pid):
     """Determine the cwd for a given PID on SunOS kernels"""
     return(proc_get_pid_cwd(pid, '/proc/%s/path/cwd'))

+def generic_cwd(pid):
+    """Determine the cwd using psutil which also supports Darwin"""
+    import psutil
+    return psutil.Process(pid).as_dict()['cwd']
+
 # vim: set expandtab ts=4 sw=4:
