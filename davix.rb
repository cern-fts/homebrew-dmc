class Davix < Formula
  desc "Library and tools for advanced file I/O with HTTP-based protocols"
  homepage "https://dmc.web.cern.ch/projects/davix/home"
  url "https://github.com/cern-fts/davix.git",
      :tag      => "R_0_7_5",
      :revision => "4b04a98027ff5ce94e18e3b110420f1ff912a32c"
  version "0.7.5"

  head "https://github.com/cern-fts/davix.git"

  depends_on "cmake" => :build
  depends_on "doxygen" => :build
  depends_on "gsoap"
  depends_on "openssl"
  depends_on "ossp-uuid"
  depends_on "pkg-config" => :build
 
  def install
    ENV.libcxx
  
    cp "release.cmake", "version.cmake"
    mkdir "build"
    system "cmake", "-DENABLE_THIRD_PARTY_COPY=ON", "-S",  ".", "-B", "build", *std_cmake_args
    system "make", "--directory", "build", "install"
  end

  test do
    system "#{bin}/davix-get", "https://www.google.com"
  end
end
