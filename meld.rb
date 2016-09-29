class Meld < Formula
  desc "Visual diff tool for developers"
  homepage "http://meldmerge.org"
  url "https://download.gnome.org/sources/meld/3.16/meld-3.16.3.tar.xz"
  sha256 "efcae1530bf78113dfad42785ecb03cc06e48cd6a325c3e9236d99948269884c"

  bottle do
    cellar :any_skip_relocation
    sha256 "8e16769b7466e17a8598c5c168c86cf268f50d73ec8ff94f7a148043aa9c4439" => :sierra
    sha256 "8e16769b7466e17a8598c5c168c86cf268f50d73ec8ff94f7a148043aa9c4439" => :el_capitan
    sha256 "8e16769b7466e17a8598c5c168c86cf268f50d73ec8ff94f7a148043aa9c4439" => :yosemite
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
