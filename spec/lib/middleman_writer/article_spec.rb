require 'spec_helper'

describe MiddlemanWriter::Article do
  let(:article) {
    MiddlemanWriter::Article.new "Lorem ipsum", "title" => "An Article"
  }

  let(:article_one) { File.open(fixture('article_one.html.markdown'), "rb").read }

  it "exists as a class within the MiddlemanWriter module" do
    MiddlemanWriter::Article.class.should eq Class
  end

  describe "#new" do
    it "returns the proper class" do
      expect(article).to be_a_kind_of MiddlemanWriter::Article
    end
  end

  describe "#frontmatter" do
    it "is set from the :frontmatter initialization option" do
      expect(article.frontmatter).to eq({ "title" => "An Article" })
    end
  end

  describe "#content" do
    it "is set from the :content initialization option" do
      expect(article.content).to eq "Lorem ipsum"
    end
  end

  context "article_one" do
    let (:article) { MiddlemanWriter::Article.new }

    it "roundtrips without any changes" do
      expect(article.deserialize(article_one).serialize).to eq article_one
    end
  end

  describe ".from_string" do
    let(:article_from_string) { MiddlemanWriter::Article.from_string article_one }

    it "creates a new article from a string" do
      expect(article_from_string).to be_a_kind_of MiddlemanWriter::Article
    end

    it "has the frontmatter of the input string" do
      frontmatter =
      expect(article_from_string.frontmatter['title']).to eq "Article One"
    end

    it "has the content of the input string" do
      expect(article_from_string.content).to start_with "I was down in Back Bay today"
    end

  end

end
