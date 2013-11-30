# Extract an Catalog from an Feed.
class ElixirSipsDownloader::Extractors::Catalog < ElixirSipsDownloader::Extractor
  # @param episode_extractor [ElixirSipsDownloader::Extractors::Episode] the
  #   Episode Extractor.
  def initialize episode_extractor =
                                   ElixirSipsDownloader::Extractors::Episode.new
    @episode_extractor = episode_extractor
  end

  # @param feed [RSS::Rss] the feed extracted with `RSS::Parser.parse`.
  # @return [ElixirSipsDownloader::Downloadables::Catalog] the Catalog extracted
  #   from feed.
  def extract feed
    episodes = Set.new

    feed.items.each { |item|
      episodes << @episode_extractor.extract(item)
    }

    ElixirSipsDownloader::Downloadables::Catalog.new episodes
  end
end
