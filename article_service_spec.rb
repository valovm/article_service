# frozen_string_literal: true

require 'rspec'
require './article_service'

describe ArticleService do
  let(:articles) { %i[a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11] }
  let(:news) { %i[n1 n2 n3 n4 n5 n6 n7 n8 n9 n10 n11 n12] }

  let(:output) do
    [
      %i[a1 n3 n5 a4 n9 n11 a7 a10],
      %i[n1 a2 n6 n7 a5 n12 a8 a11],
      [:n2, :n4, :a3, :n8, :n10, :a6, :a9, nil]
    ]
  end

  around(:all) do |example|
    @article_service = ArticleService.new
    example.run
  end

  it 'run' do
    res = @article_service.build(articles, news, 3)
    expect(res).to eq(output)
  end

  it 'integration' do
    @article_service.build(articles, news, 3)
    @article_service.build(articles, news, 3)
    @article_service.build(articles, news, 3)
    res = @article_service.build(articles, news, 3)
    expect(res).to eq(output)
  end
end
