# Confluence to Markdown converter which is actually working

Convert [Confluence HTML export](#conflhowto) to Markdown


## Requirements

You must have [pandoc] command line tool installed. Check it by running:

```
pandoc --version
```

Install all project dependencies:

```
npm install
```


## Usage

In the converter's directory:

```
npm run start <pathResource> <pathResult>
```

### Using the Docker image

All you need installed on your computer is Docker. Then use the following command to run you conversion (this example
shares the current directory - `$PWD` on linux and Mac - and convert from the export subdirectory to the docs directory):

```
docker run -it -v $PWD:$PWD meridius/confluence-to-markdown npm run start $PWD/export $PWD/docs
```

### Parameters

parameter | description
--- | ---
`<pathResource>` | File or directory to convert with extracted Confluence export
`<pathResult>` | Directory to where the output will be generated to. Defaults to current working directory


## Process description<a name="process-description"></a>

- Confluence page IDs in HTML file names and links are replaced with that pages' heading
- overall index.md is created linking all Confluence spaces - their indexes
- images and other inserted attachments are linked to generated markdown
  - whole `images` and `attachments` directories are copied to resulting directory
    - there is no checking done whether perticular file/image is used or not
- markdown links to internal pages are generated without the trailing **.md** extension to comply to [gitit] expectations
  - this can be changed by finding all occurances of `gitit requires link to pages without .md extension` in the `.coffee` files and adding the extension there.
  - or you can send a PR ;)
- the pandoc utility can accept quite a few options to alter its default behavior
  - those can be passed to it by adding them to `@outputTypesAdd`, `@outputTypesRemove`, `@extraOptions` properties in the [`App.coffee`](src/App.coffee) file
  - or you can send a PR ;)
  - here is the [list of options][pandoc-options] pandoc can accept
- throughout the application a single console logger is used, its default verbosity is set to INFO
  - you can change the verbosity to one of DEBUG, INFO, WARNING, ERROR levels in the [`Logger.coffee`](src/App.coffee) file
  - or you can send a PR ;)
- a series of formatter rules is applied to the HTML text of Confluence page for it to be converted properly
  - you can view and/or change them in the [`Page.coffee`](src/Page.coffee) file
  - the rules themselves are located in the [`Formatter.coffee`](src/Formatter.coffee) file


### Room for improvement

If you happen to find something not to your liking, you are welcome to send a PR. Some good starting points are mentioned in the [Process description](#process-description) section above.


### Export to HTML

Note that if the converter does not know how to handle a style, HTML to Markdown typically just leaves the HTML untouched (Markdown does allow for HTML tags).


## Step by step guide for Confluence data export<a name="conflhowto"></a>

1. Go to the space and choose `Space tools > Content Tools on the sidebar`.
2. Choose Export. This option will only be visible if you have the **Export Space** permission.
3. Select HTML then choose Next.
4. Decide whether you need to customize the export:
  - Select Normal Export to produce an HTML file containing all the pages that you have permission to view.
  - Select Custom Export if you want to export a subset of pages, or to exclude comments from the export.
5. Extract zip

**WARNING**  
Please note that Blog will **NOT** be exported to HTML. You have to copy it manually or export it to XML or PDF. But those format cannot be processed by this utility.


# Attribution

Thanks to Eric White for a starting point.


[pandoc]: http://pandoc.org/installing.html
[pandoc-options]: http://hackage.haskell.org/package/pandoc
[gitit]: https://github.com/jgm/gitit/
