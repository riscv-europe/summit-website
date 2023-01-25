{-# LANGUAGE OverloadedStrings #-}

import           Data.Monoid     ((<>))
import qualified Data.Text       as T (pack)
import           Hakyll
import           System.Process  (readProcess)
import           Text.Pandoc

import           GHC.IO.Encoding

config :: Configuration
config = defaultConfiguration
  { destinationDirectory = "../site.tmp"
  , storeDirectory       = "../cache.tmp"
  , tmpDirectory         = "../cache.tmp/tmp"
  , providerDirectory    = "../site.src"
  }

main :: IO ()
main = do
  setLocaleEncoding utf8
  setFileSystemEncoding utf8
  setForeignEncoding utf8
  hakyllWith config $ do

    -- static content
    match ( "CNAME"
            .||. "css/*"
            .||. "fonts/*"
            .||. "js/*"
            .||. "media/images/*"
            .||. "media/slides/*"
            .||. "media/posters/*"
            .||. "media/logos/*"
            .||. "*.html"
          ) $ do
      route idRoute
      compile copyFileCompiler

    -- Static pages
    match ("pages/*.markdown" .||. "pages/*.md") $ do
        route $ gsubRoute "pages/" (const "") `composeRoutes` setExtension "html"
        compile $
            pandocCompiler
                >>= loadAndApplyTemplate "templates/default.html" builtPageCtx
                >>= relativizeUrls
    match "templates/*" $ compile templateCompiler

    match "pages/*.org" $ do
        route $ gsubRoute "pages/" (const "") `composeRoutes` setExtension "html"
        compile $
            pandocIOCompiler
                >>= loadAndApplyTemplate "templates/default.html" builtPageCtx
                >>= relativizeUrls
    match "templates/*" $ compile templateCompiler

    -- robots, etc.
    -- The contents of robots.txt is manually updated for now.
    -- MAYBE  automatically generate the contents of robots.txt
    match "assets/txt/*" $ do
        route $ gsubRoute "assets/txt/" (const "")
        compile copyFileCompiler

    -- static HTML pages.
    match "assets/html/*"$ do
        route $ gsubRoute "assets/html/" (const "")
        compile copyFileCompiler

    -- create ["sitemap.xml"] $ do
    --     route idRoute
    --     compile $ do
    --         let sitemapCtx = builtPageCtx <> lastGitModification
    --         makeItem ""
    --             >>= loadAndApplyTemplate "templates/sitemap.xml" sitemapCtx

feedConfiguration :: FeedConfiguration
feedConfiguration = FeedConfiguration
    { feedTitle = "RISC-V Summit Europe 2023"
      , feedDescription = "RISC-V Summit Europe 2023"
      , feedAuthorName = "Christian Fabre, Damien Couroussé, Nicolas Belleville"
      , feedAuthorEmail = "renc-riscv-orga@saxifrage.saclay.cea.fr "
      , feedRoot = "http://open-src-soc.org"
    }

-- Auxiliary compilers
--    the main page compiler
pandocIOCompiler :: Compiler (Item String)
pandocIOCompiler = writePandoc <$> (getResourceBody >>= readPandocIOWith def)

-- Hakyll's version of 'readPandoc', but replacing the pure instance
-- of 'PandocMonad' with the one running in 'IO'.  'PandocPure' does
-- not support all pandoc functionalities, in particular, org
-- includes.
-- https://github.com/jaspervdj/hakyll/issues/635
readPandocIOWith
  :: ReaderOptions -- ^ Parser options
  -> Item String -- ^ String to read
  -> Compiler (Item Pandoc) -- ^ Resulting document
readPandocIOWith ropt item =
  unsafeCompiler $
  runIO (traverse (reader ropt (itemFileType item)) (fmap T.pack item)) >>=
  \x -> case x of
    Left err ->
      fail $ "Hakyll.Web.Pandoc.readPandocWith: parse failed: " ++ show err
    Right item' -> return item'
  where
    reader ro t =
      case t of
        DocBook -> readDocBook ro
        Html -> readHtml ro
        LaTeX -> readLaTeX ro
        LiterateHaskell t' -> reader (addExt ro Ext_literate_haskell) t'
        Markdown -> readMarkdown ro
        MediaWiki -> readMediaWiki ro
        OrgMode -> readOrg ro
        Rst -> readRST ro
        Textile -> readTextile ro
        _ ->
          error $
          "Hakyll.Web.readPandocWith: I don't know how to read a file of " ++
          "the type " ++ show t ++ " for: " ++ show (itemIdentifier item)
    addExt ro e =
      ro {readerExtensions = enableExtension e $ readerExtensions ro}


-- Context builders
builtPageCtx :: Context String
builtPageCtx =  constField "siteroot" (feedRoot feedConfiguration)
             <> listField "entries" builtPageCtx (loadAll $ "pages/*" .||. "posts/*")
             <> dateField "date" "%A, %e %B %Y"
             <> dateField "isodate" "%F"
             <> gitTag
             <> lastGitModification
             <> defaultContext

-- | Extracts git commit info and render some html code for the page footer.
--
-- Adapted from
-- - Jorge.Israel.Peña at https://github.com/blaenk/blaenk.github.io
-- - Miikka Koskinen at http://vapaus.org/text/hakyll-configuration.html
gitTag :: Context String
gitTag = field "gitinfo" $ \item -> do
  let fp = toFilePath $ itemIdentifier item
      gitLog format =
        readProcess "git" ["log", "-1", "HEAD", "--pretty=format:" ++ format, "--", fp] ""
  unsafeCompiler $ do
    date    <- gitLog "%aI"
    return $ concat
             [ "Last modified on "
             , "<a href=https://github.com/open-src-soc/YYYY-MM-src/commits/gh-pages>"
             , date
             , "</a>."
             ]

-- | Extract the last modification date from the git commits
lastGitModification :: Context a
lastGitModification = field "lastgitmod" $ \item -> do
  let fp = toFilePath $ itemIdentifier item
  unsafeCompiler $
    readProcess "git" ["log", "-1", "HEAD", "--pretty=format:%ad", "--date=short", fp] ""
