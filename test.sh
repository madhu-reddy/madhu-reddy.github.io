ruby -r rubygems -e '
  require "jekyll-import";
  JekyllImport::Importers::WordpressDotCom.run({
    "source" => "madhututorials.WordPress.2026-02-24.xml",
    "no_fetch_images" => false,
    "assets_folder" => "assets"
  })'
