# hyperdata gem - turn hypertext from web pages into structured data (supports Feed.HTML n friends)


* home  :: [github.com/feedhtml/hyperdata](https://github.com/feedhtml/hyperdata)
* bugs  :: [github.com/feedhtml/hyperdata/issues](https://github.com/feedhtml/hyperdata/issues)
* gem   :: [rubygems.org/gems/hyperdata](https://rubygems.org/gems/hyperdata)
* rdoc  :: [rubydoc.info/gems/hyperdata](http://rubydoc.info/gems/hyperdata)
* forum :: [groups.google.com/group/wwwmake](http://groups.google.com/group/wwwmake)


## What's Feed.HTML? - A Free Feeds Format in HyperText Markup Language (HTML) w/ Structured Meta Data

What's Feed.HTML? Let's start with an example from the Microformats v2 `h-entry` spec:

``` html
<article class="h-entry">
  <h1 class="p-name">Microformats are amazing</h1>
  <p>Published by <a class="p-author h-card" href="http://example.com">W. Developer</a>
     on <time class="dt-published" datetime="2013-06-13 12:00:00">13<sup>th</sup> June 2013</time>
 
  <p class="p-summary">In which I extoll the virtues of using microformats.</p>
 
  <div class="e-content">
    <p>Blah blah blah</p>
  </div>
</article>
```

Let's try to make it simpler and easier. Why in 2017 still (re)use `class` for microformats / microdata? 
Let's use `o` for object types / structs / scopes and `x` for (object) props / property keys:

``` html
<article o=item>
  <h1 x=title>Microformats are amazing</h1>
  <p>Published by <a o=card x=author href="http://example.com">W. Developer</a>
     on <time x=published datetime="2013-06-13 12:00:00">13<sup>th</sup> June 2013</time>
 
  <p x=summary>In which I extoll the virtues of using microformats.</p>
 
  <div x=content>
    <p>Blah blah blah</p>
  </div>
</article>
```

Why `o` and `x`? and not let's say `p` and `q`? The idea is to use letters that are not already used in single-letter tags
and that are easy to remember - think: tic-tac-toe-like ;-)


Parsed to JSON resulting in:

``` json
{
   "title": "Microformats are amazing",
   "author": "W. Developer",
   "card":   { "name": "W. Developer",
               "url":  "http://example.com"
             },
   "published": "2013-06-13 12:00:00",
   "summary": "In which I extoll the virtues of using microformats.",
   "content": "<p>Blah blah blah</p>"
}

```

### Shortcuts / Alternatives

#### Use hfeed / hitem / hcard

As an alternative you can use  `hfeed` or `feed` (for `o=feed`), `hitem` or `item` (for `o=item`), 
`hcard` or `item` (for `o=card`) shortcuts. Let's (re)try:

``` html
<article item>
  <h1 title>Microformats are amazing</h1>
  <p>Published by <a card author href="http://example.com">W. Developer</a>
     on <time published datetime="2013-06-13 12:00:00">13<sup>th</sup> June 2013</time>
 
  <p summary>In which I extoll the virtues of using microformats.</p>
 
  <div content>
    <p>Blah blah blah</p>
  </div>
</article>
```


#### Use "predefined" convention over configuration structures

As an alternative you can use the "recommend" predefined convention over configuration
structure. Let's (re)try:

``` html
<article>
  <h1>Microformats are amazing</h1>
  <p>Published by <a href="http://example.com">W. Developer</a>
     on <time datetime="2013-06-13 12:00:00">13<sup>th</sup> June 2013</time>
 
  <p>In which I extoll the virtues of using microformats.</p>
 
  <div>
    <p>Blah blah blah</p>
  </div>
</article>
```

E.g.:

- Use article for your item.
- Use heading (h1) for your title.
- The first paragraph (p) for your metadata block with author and published date.
  - The first time (time) is the published date.
  - The first anchor link (a) is the author.
- Optional: The second paragraph (p) is the summary.
- The first division (div) is the content.



## Usage

To be done.


## License

![](https://publicdomainworks.github.io/buttons/zero88x31.png)

The Feed.HTML format & conventions
and the `hyperdata` scripts are dedicated to the public domain.
Use it as you please with no restrictions whatsoever.

## Questions? Comments?

Send them along to the [wwwmake Forum/Mailing List](http://groups.google.com/group/wwwmake).
Thanks!

