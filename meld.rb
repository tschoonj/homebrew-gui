class Meld < Formula
  desc "Visual diff tool for developers"
  homepage "http://meldmerge.org"
  url "https://download.gnome.org/sources/meld/3.16/meld-3.16.1.tar.xz"
  sha256 "1bec697aa1ababa315ca8241ade65dc68ea87f0d316632f590975afcf967cfab"

  bottle do
    cellar :any_skip_relocation
    sha256 "7b9eac0297b57b9a57ffe5a303d2b2eeff7e0e45e156fe99c33a85c7b0ce2b15" => :el_capitan
    sha256 "bb2f2563bc312b8ab348f80a1ce46fda13c97b805acf44cf557cf1159611aacc" => :yosemite
    sha256 "2f7748ddd5f4994ac31fe4fc57ef92a7427faed2b7ab6dd65a84def15442dfe1" => :mavericks
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
