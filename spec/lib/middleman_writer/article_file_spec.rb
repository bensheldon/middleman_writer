require 'spec_helper'

describe MiddlemanWriter::ArticleFile do
  let(:file) { MiddlemanWriter::ArticleFile.load_file fixture('article_one.html.markdown') }

  describe "#frontmatter" do
    it "delegates to @article" do
      expect(file.frontmatter).to eq(file.frontmatter)
    end

    it "is modifiable as a hash" do
      file.frontmatter['title'] = "update title"
      expect(file.article.frontmatter['title']).to eq "update title"
    end
  end

  describe "#content" do
    it "delegates to @article" do
      file.content = "update content"
      expect(file.article.content).to eq "update content"
    end
  end

  describe "#content=" do
    it "delegates to @article" do
      file.content = "update content"
      expect(file.article.content).to eq "update content"
    end
  end

  describe '.load_file' do
    it "loads an ArticleFile from a path" do
      file = MiddlemanWriter::ArticleFile.load_file fixture('article_one.html.markdown')
      expect(file).to be_a_kind_of MiddlemanWriter::ArticleFile
    end

    it "populates the ArticleFile's with content and frontmatter from loaded file" do
      file = MiddlemanWriter::ArticleFile.load_file fixture('article_one.html.markdown')
      expect(file.article.frontmatter['title']).to eq "Article One"
      expect(file.article.content).to start_with "I was down in Back Bay today"
    end

  end

  describe ".load" do
    it "returns an array of ArticleFiles if loading a directory" do
      files = MiddlemanWriter::ArticleFile.load fixture

      expect(files).to be_a_kind_of Array
      expect(files[0]).to be_a_kind_of MiddlemanWriter::ArticleFile
    end

    it "returns an ArticleFile if loading an individual file" do
      file = MiddlemanWriter::ArticleFile.load fixture('article_one.html.markdown')
      expect(file).to be_a_kind_of MiddlemanWriter::ArticleFile
    end
  end

end
