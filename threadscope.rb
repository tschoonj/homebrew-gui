require "language/haskell"

class Threadscope < Formula
  include Language::Haskell::Cabal
  desc "Tool for performance profiling of parallel Haskell programs"
  homepage "https://wiki.haskell.org/ThreadScope"
  url "https://hackage.haskell.org/package/threadscope-0.2.7/threadscope-0.2.7.tar.gz"
  sha256 "cc5653831252d55b3ba7506ea648e770b2c4489cdf4d78828f07dc24ea7ffdb6"
  revision 1

  bottle do
    sha256 "cc98500fc15f9415bc3ee72fd0486d3e8c6c46025a436148a30fb4f5ed87547f" => :el_capitan
    sha256 "37453f9d0350cf9af17a7827e3e4bf14ab1afb19953c10d623f10a5367a1b9b6" => :yosemite
    sha256 "d9614ba57d0fcc3da58464beef32cdc4baf3241760f900a6a0b9e64498b32c44" => :mavericks
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
