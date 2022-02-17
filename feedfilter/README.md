# feedfilter gem - feed filter and rules for easy (re)use 

* home  :: [github.com/feedparser/feedfilter](https://github.com/feedparser/feedfilter)
* bugs  :: [github.com/feedparser/feedfilter/issues](https://github.com/feedparser/feedfilter/issues)
* gem   :: [rubygems.org/gems/feedfilter](https://rubygems.org/gems/feedfilter)
* rdoc  :: [rubydoc.info/gems/feedfilter](http://rubydoc.info/gems/feedfilter)
* forum :: [groups.google.com/group/wwwmake](http://groups.google.com/group/wwwmake)


## Usage


### `strip_ads`  (in `AdsFilter` module)

```
require 'feedfilter'

include FeedFilter::AdsFilter      # lets us use strip_ads


before_snippet =<<EOS
<div class="feedflare">
 <a href="http://feeds.feedburner.com/~ff/Rubyflow?a=1wUDnBztAJY:fzqBvTOGB9M:3H-1DwQop_U">
   <img src="http://feeds.feedburner.com/~ff/Rubyflow?i=1wUDnBztAJY:fzqBvTOGB9M:3H-1DwQop_U" border="0"></img>
 </a>
</div>
EOS


snippet = strip_ads( before_snippet )

puts snippet
```


### Use Text Patterns (Regex) for Filters

Ads Example:

```
FEEDFLARE_ADS = %r{
     <div[^>]*?
        class=("|')feedflare\1
        [^>]*?>
          .*?
     <\/div>
       }mix

FEEDBURNER_BUGS = %r{
      <img[^>]*?
         src=("|')(:?http:)?//feeds\.feedburner\.com/~r/[^>]+?\1
         .*?>
       }mix

...
```

or as one-liners (if you prefer)

```
FEEDFLARE_ADS   = %r{<div[^>]*?class=("|')feedflare\1[^>]*?>.*?<\/div>}mi
FEEDBURNER_BUGS = %r{<img[^>]*?src=("|')(:?http:)?//feeds\.feedburner\.com/~r/[^>]+?\1.*?>}mi
...
```


## License

![](https://publicdomainworks.github.io/buttons/zero88x31.png)

The `feedfilter` scripts are dedicated to the public domain.
Use it as you please with no restrictions whatsoever.

## Questions? Comments?

Send them along to the [wwwmake Forum/Mailing List](http://groups.google.com/group/wwwmake).
Thanks!
