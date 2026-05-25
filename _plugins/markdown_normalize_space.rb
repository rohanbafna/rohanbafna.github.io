module Jekyll
  class MarkdownNormalizeSpace < Converter
    priority :high

    def matches(ext)
      ext == ".md"
    end

    def output_ext(ext)
      ".md"
    end

    def convert(content)
      content.gsub(/\.( {2,}|\R(?!\R))/, ".  ")
    end
  end
end
