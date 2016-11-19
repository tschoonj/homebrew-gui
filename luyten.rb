class Luyten < Formula
  desc "Java decompiler GUI for Procyon"
  homepage "https://deathmarine.github.io/Luyten/"
  url "https://github.com/deathmarine/Luyten/releases/download/v0.5.0/luyten-0.5.0.jar", :using => :nounzip
  sha256 "2ef5f677a193eaf2a04fbeefc3f6ff480a34067dec22af5cb3cc63f6bc95ebdc"

  head do
    url "https://github.com/deathmarine/Luyten.git"
    depends_on "maven" => :build
  end

  bottle :unneeded

  depends_on :java => "1.7+"

  def install
    if build.head?
      ENV.java_cache

      ver = `mvn org.apache.maven.plugins:maven-help-plugin:evaluate -Dexpression=project.version`.split.grep(/^\d+\.\d+\.\d+/).uniq.first
      system "mvn", "clean", "package"
      libexec.install "target/luyten-#{ver}.jar"
    else
      ver = version.to_s
      libexec.install "luyten-#{ver}.jar"
    end
    bin.write_jar_script libexec/"luyten-#{ver}.jar", "luyten"
  end

  test do
    assert File.exist?(bin/"luyten"), "I'm an untestable GUI app."
  end
end
