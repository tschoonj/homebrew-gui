class Meld < Formula
  desc "A visual diff tool for developers"
  homepage "http://meldmerge.org"
  url "https://download.gnome.org/sources/meld/3.14/meld-3.14.2.tar.xz"
  sha256 "4a3c0951cd3b7e7ae2480f66adfb0e50b3bd301821d6e2adb518130446231873"

  bottle do
    cellar :any_skip_relocation
    sha256 "c5028e6b49cc3e10296ddd0bfa857bd847192e9ee513e2fb02e6d7d90608d512" => :el_capitan
    sha256 "919ea6d850de768c1ed5a499c56c080b777f75ef687097fac623106dfddaa18f" => :yosemite
    sha256 "687a6ab9a890de3f2a260cb2f82aaacbf841b2a78da01f83c0265aa643b2b433" => :mavericks
  end

  depends_on "intltool" => :build
  depends_on "itstool" => :build
  depends_on "libxml2" => [:build, "with-python"]
  depends_on :python
  depends_on "gtksourceview3"
  depends_on "pygobject3"
  depends_on "gobject-introspection"
  depends_on "hicolor-icon-theme"
  depends_on "gnome-icon-theme"

  def install
    ENV.append_path "PYTHONPATH", "#{Formula["libxml2"].opt_lib}/python2.7/site-packages"
    system "python", "setup.py", "--no-update-icon-cache",
           "--no-compile-schemas", "install", "--prefix=#{prefix}"
  end

  def post_install
    system "#{Formula["glib"].opt_bin}/glib-compile-schemas", "#{HOMEBREW_PREFIX}/share/glib-2.0/schemas"
    system "#{Formula["gtk+3"].opt_bin}/gtk3-update-icon-cache", "-f", "-t", "#{HOMEBREW_PREFIX}/share/icons/hicolor"
  end

  test do
    system "#{bin}/meld", "--version"
  end
end
