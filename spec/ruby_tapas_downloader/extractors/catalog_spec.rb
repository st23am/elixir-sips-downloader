require 'spec_helper'

describe ElixirSipsDownloader::Extractors::Catalog do
  subject(:catalog_extractor) {
    ElixirSipsDownloader::Extractors::Catalog.new episode_extractor
  }

  let(:episode_extractor) { double }
  let(:episodes) { Set[first_episode, second_episode] }

  let(:first_episode)  {
    ElixirSipsDownloader::Downloadables::Episode.new(
      '129 Some episode',
      'http://example.com/some-episode',
      Set[
        ElixirSipsDownloader::Downloadables::File.new(
          'some-episode-file.html',
          'http://example.com/some-episode-file.html'),
        ElixirSipsDownloader::Downloadables::File.new(
          'some-episode-file.mp4',
          'http://example.com/some-episode-file.mp4'),
        ElixirSipsDownloader::Downloadables::File.new(
          'some-episode-file.rb',
          'http://example.com/some-episode-file.rb'),
      ]
    )
  }

  let(:second_episode)  {
    ElixirSipsDownloader::Downloadables::Episode.new(
      '130 Some other episode',
      'http://example.com/some-other-episode',
      Set[
        ElixirSipsDownloader::Downloadables::File.new(
          'some-other-episode-file.html',
          'http://example.com/some-other-episode-file.html'),
        ElixirSipsDownloader::Downloadables::File.new(
          'some-other-episode-file.mp4',
          'http://example.com/some-other-episode-file.mp4'),
        ElixirSipsDownloader::Downloadables::File.new(
          'some-other-episode-file.rb',
          'http://example.com/some-other-episode-file.rb'),
      ]
    )
  }

  let(:feed) { RSS::Parser.parse File.read('spec/fixtures/feed.xml') }

  let(:first_item)  { feed.items[0] }
  let(:second_item) { feed.items[1] }

  before do
    allow(episode_extractor).to receive(:extract).with(first_item)
                                                 .and_return(first_episode)
    allow(episode_extractor).to receive(:extract).with(second_item)
                                                 .and_return(second_episode)
  end


  it 'is an Extractor' do
    expect(catalog_extractor).to be_a ElixirSipsDownloader::Extractor
  end

  describe '#extract' do
    subject(:catalog) { catalog_extractor.extract feed }

    it 'uses Extractors::Episode' do
      expect(episode_extractor).to receive(:extract).with(first_item)
                                                    .and_return(first_episode)
      expect(episode_extractor).to receive(:extract).with(second_item)
                                                    .and_return(second_episode)
      catalog_extractor.extract feed
    end

    it 'returns a Catalog' do
      expect(catalog).to eq(
        ElixirSipsDownloader::Downloadables::Catalog.new episodes
      )
    end
  end
end
