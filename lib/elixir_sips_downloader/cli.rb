require_relative '../elixir-sips-downloader'

# The Command Line Interface for Ruby Tapas Downloader.
class ElixirSipsDownloader::CLI
  # @param email [String] the e-mail for the user.
  # @param password [String] the password for the user.
  # @param download_path [String] the path in which the download is performed.
  def initialize email, password, download_path
    @email         = email
    @password      = password
    @download_path = download_path
  end

  # Perform complete download procedure.
  def download
    create_agent
    login
    fetch_feed
    create_catalog
    download_catalog
  end

  private

  def create_agent
    @agent = Mechanize.new
  end

  def login
    ElixirSipsDownloader::Login.new(@agent, @email, @password).login
  end

  def fetch_feed
    @feed = ElixirSipsDownloader::FeedFetcher.new(@agent, @email, @password)
                                                                         .fetch
  end

  def create_catalog
    @catalog = ElixirSipsDownloader::Extractors::Catalog.new.extract @feed
  end

  def download_catalog
    @catalog.download @download_path, @agent
  end
end
