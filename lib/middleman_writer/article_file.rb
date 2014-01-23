require 'pathname'

module MiddlemanWriter
  class ArticleFile
    extend Forwardable

    attr_accessor :path
    attr_reader :article
    def_delegator :@article, :content, :frontmatter

    def initialize(article=nil, options={})
      if article
        @article = article
      else
        @article = Article.new
      end

      self.path = options.fetch(:path)
    end

    def self.load(path, match="*.html*")
      pathname = Pathname(path)

      if pathname.directory?
        article_files = []

        pathname.each_child.select do |pn|
          pn.file? && pn.fnmatch?(match)
        end.each do |pn|
          article = Article.from_string(pn.open 'rb')
          puts article.inspect
          article_files << new(article, path: pn)
        end

        article_files
      elsif pathname.file?
        article = Article.from_string(pathname.open 'rb')
        new(article, path: pathname)
      else
        nil
      end
    end

  end
end
