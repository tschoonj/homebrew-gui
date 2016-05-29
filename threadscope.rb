require "language/haskell"

class Threadscope < Formula
  include Language::Haskell::Cabal
  desc "Tool for performance profiling of parallel Haskell programs"
  homepage "https://wiki.haskell.org/ThreadScope"
  url "https://hackage.haskell.org/package/threadscope-0.2.7/threadscope-0.2.7.tar.gz"
  sha256 "cc5653831252d55b3ba7506ea648e770b2c4489cdf4d78828f07dc24ea7ffdb6"
  revision 1

  bottle do
    sha256 "0044dd4cd50768ee1260e8cf835aef369f5495b6df2de7c394a90f5fe41aa4d9" => :el_capitan
    sha256 "49d59338f6f2223109f2636914c1492ca64c9a426e9e7acef2378c0efbd171d4" => :yosemite
    sha256 "393128cf0b17ee8a482b9a306d0f7698503c1ce6781fe145321103b4da379094" => :mavericks
  end

  depends_on "cabal-install" => :build
  depends_on "pkg-config" => :build
  depends_on "cairo"
  depends_on "fontconfig"
  depends_on "freetype"
  depends_on "gettext"
  depends_on "ghc"
  depends_on "glib"
  depends_on "gmp"
  depends_on "gtk+"
  depends_on "pango"

  def install
    install_cabal_package "ghc-events", :using => ["alex", "happy"] do
      cabal_install "--flags=have-quartz-gtk", "gtk"
      install_cabal_package
    end
  end

  test do
    system "#{bin}/threadscope", "--version"
  end
end
