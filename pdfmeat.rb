require 'formula'

class PDFmeat < Formula
  homepage 'https://github.com/mankoff/pdfmeat'
  url 'https://github.com/mankoff/pdfmeat.git'
  sha1 '00437eed6bf5d3fede441aaa7e32a863fd2a27be'
  #  sha1 'd64282e744424ec7c5f92b66e78e5a6fded90ff9'

#  depends_on :automake
#  def patches
#  end
  def install
    system "cp" "pdfmeat.py" "#{HOMEBREW_PREFIX}/bin"
  end
end
