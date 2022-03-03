
# Awesome Feeds > Meta Data

How many ways to add

- Author
- Title
- Date 

Let's count ;-)



## Person / People

- **creator**            -- Dublin Core Meta Data
- **publisher**          -- Dublin Core Meta Data
- **author**             -- RSS 2.0, Atom, JSON Feed
- **contributor**        -- Atom
- **managingEditor**     -- RSS 2.0 Channel
- **webMaster**          -- RSS 2.0 Channel


## Dates

- **published**         -- Atom
- **pubDate**           -- RSS 2.0
- **date_published**    -- JSON Feed
- **date**              -- Dublin Core Meta Data
- **updated**           -- Atom
- **date_modified**     -- JSON Feed
- **lastBuildDate**     -- RSS 2.0 Channel


## Title

- **title**             -- Atom / RSS 2.0 / JSON Feed
- **name**


_2nd Level Title_

- **subtitle**          -- Atom  
- **tagline**


## Summary

- **summary**          -- Atom / JSON Feed
- **description**      -- RSS 2.0
- **abstract**    
- **excerpt**


## Content

- **content**          -- Atom (Defaults to Text!), RSS Yahoo! Search (Media) Extension 
- **content type="text|html|xhtml"**   -- Atom (Defaults to Text!)
- **content_text**     -- JSON Feed
- **content_html**     -- JSON Feed
- **content:encoded**  -- RDF Content Module



## Tags / Categories

- **category**   -- RSS 2.0
- **category term=**  -- Atom
- **tags[]**     -- JSON Feed
- **keywords**

_Scheme_

- **scheme**     -- Atom
- **domain**     -- RSS 2.0


## Link

- **url**      -- JSON Feed
- **link**     -- RSS 2.0
- **link href=**   -- Atom 


_More Links_

- **home_page_url**   -- JSON Feed (site url)
- **feed_url**        -- JSON Feed (feed url)
- **link href= rel="self"**        -- Atom (feed url)
- **link href= rel="alternate"**   -- Atom (site url)


## ID

- **id**      -- Atom, JSON Feed
- **guid**    -- RSS 2.0
- **permalink**


## Attachments

- **attachments[] url=**            -- JSON Feed
- **enclosure url=**              -- RSS 2.0
- **link href= rel="enclosure"**   -- Atom

_Examples_

JSON Feed:

``` json
"attachments": [
                {
                    "url": "http://therecord.co/downloads/The-Record-sp1e1-ChrisParrish.m4a",
                    "mime_type": "audio/x-m4a",
                    "size_in_bytes": 89970236,
                    "duration_in_seconds": 6629
                }
            ]
```

RSS 2.0:

``` xml
<enclosure url="http://www.example.org/myaudiofile.mp3"
                 length="12345"
                 type="audio/mpeg" />
```

Atom:

``` xml
   <link rel="enclosure"
          type="audio/mpeg"
          title="MP3"
          href="http://www.example.org/myaudiofile.mp3"
          length="1234" />
    <link rel="enclosure"
          type="application/x-bittorrent"
          title="BitTorrent"
          href="http://www.example.org/myaudiofile.torrent"
          length="1234" />
```


## More - What's Missing?

- add banner image for item / entry?
- add image / cover for feed / channel?
- add (fav)icon for feed / channel?
- add language ?
- add expired yes/no or with date?

