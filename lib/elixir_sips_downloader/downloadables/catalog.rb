# Catalog is the set of all Ruby Tapas Episodes.
class ElixirSipsDownloader::Downloadables::Catalog <
                                              ElixirSipsDownloader::Downloadable

  # @return [Set<ElixirSipsDownloader::Downloadables::Episode>] the Episodes.
  attr_reader :episodes

  def initialize episodes
    @episodes = episodes
  end

  # Download the Catalog.
  #
  # @param basepath [String] the path to place download.
  # @param agent [Mechanize] the Mechanize agent.
  def download basepath, agent
    ElixirSipsDownloader.logger.info 'Starting download of catalog in ' \
                                    "`#{ basepath }'..."
    FileUtils.mkdir_p basepath
    episodes.each { |episode| episode.download basepath, agent }
  end

  def == other
    episodes == other.episodes
  end

  def eql? other
    episodes.eql? other.episodes
  end

  def hash
    episodes.hash
  end
end
