class Gfal2Util< Formula
  desc "Grid file access library 2, command line tools"
  homepage "http://dmc.web.cern.ch/"
  url "https://gitlab.cern.ch/dmc/gfal2-util.git", 
      :tag => "v1.5.3"
  version "1.5.3"

  depends_on "gfal2-python"

  def install
    system "python", "setup.py", "install", "--prefix=#{prefix}"
  end

  test do
    system "#{bin}/gfal-ls file:///"
  end
end

