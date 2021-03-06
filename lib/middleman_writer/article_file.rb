require 'pathname'

module MiddlemanWriter
  class ArticleFile
    extend Forwardable

    attr_accessor :path
    attr_reader :article
    def_instance_delegators :@article,
      :content,
      :content=,
      :frontmatter

    def initialize(article=nil, options={})
      if article
        @article = article
      else
        @article = Article.new
      end

      self.path = options.fetch(:path)
    end

    def self.load_file(path)
      pathname = Pathname(path)

      file_contents = pathname.open('rb').read
      article = Article.from_string(file_contents)
      new(article, path: pathname)
    end

    def self.load(path, match="*.html*")
      pathname = Pathname(path)

      if pathname.directory?
        article_files = []

        pathname.each_child.select do |pn|
          pn.file? && pn.fnmatch?(match)
        end.each do |pn|
          article_files << load_file(pn)
        end

        article_files
      elsif pathname.file?
        load_file(pathname)
      else
        nil
      end
    end

  end
end
