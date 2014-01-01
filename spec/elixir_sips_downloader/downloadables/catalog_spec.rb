require 'spec_helper'

describe ElixirSipsDownloader::Downloadables::Catalog do
  subject(:catalog) {
    ElixirSipsDownloader::Downloadables::Catalog.new episodes
  }

  let(:episodes) { [double(download: true), double(download: true)] }

  specify('#episodes') { expect(catalog.episodes).to eq(episodes) }

  it 'is downloadable' do
    expect(catalog).to be_a ElixirSipsDownloader::Downloadable
  end

  describe '#download' do
    let(:basepath)     { '/tmp/ruby-tapas' }
    let(:agent)        { double }

    before { allow(FileUtils).to receive(:mkdir_p) }

    it 'creates folder for catalog' do
      expect(FileUtils).to receive(:mkdir_p).with(basepath)

      catalog.download basepath, agent
    end

    it 'calls #download on each episode' do
      episodes.each do |episode|
        expect(episode).to receive(:download).with(basepath, agent)
      end

      catalog.download basepath, agent
    end
  end

  describe '#==' do
    it 'compares episodes' do
      expect(catalog).to eq(
                      ElixirSipsDownloader::Downloadables::Catalog.new episodes)
    end
  end

  describe '#eql?' do
    it 'compares episodes' do
      expect(catalog.eql?(
         ElixirSipsDownloader::Downloadables::Catalog.new episodes)).to be_true
    end
  end

  describe '#hash' do
    it 'is based on episodes' do
      expect(catalog.hash).to eq(episodes.hash)
    end
  end
end
