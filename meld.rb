class Meld < Formula
  desc "A visual diff tool for developers"
  homepage "http://meldmerge.org"
  url "https://download.gnome.org/sources/meld/3.14/meld-3.14.2.tar.xz"
  sha256 "4a3c0951cd3b7e7ae2480f66adfb0e50b3bd301821d6e2adb518130446231873"

  bottle do
    cellar :any_skip_relocation
    sha256 "a6e9e4c68d52cf72ab451b5a319c1207af1c4840b19493023e03d3a9152b0563" => :el_capitan
    sha256 "0bfcae31b88b623cced5c3f6de060f70fe7fde35cbf7b641fca31cddea3c0cca" => :yosemite
    sha256 "6f6754050775367b8f81e69794edb306424c5cb870cd9e9c5d60e578fd9ad898" => :mavericks
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
