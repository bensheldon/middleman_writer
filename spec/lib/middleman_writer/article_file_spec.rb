require 'spec_helper'

describe MiddlemanWriter::ArticleFile do

  describe ".load" do
    it "returns an array if loading a directory" do
      articles = MiddlemanWriter::ArticleFile.load fixture

      expect(articles).to be_a_kind_of Array

      puts articles[0].inspect
    end
  end

end
