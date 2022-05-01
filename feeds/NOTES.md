# Notes


## Todos

in news/wahingtionpost-lbogs.innovations.rss:

check:

```
assert in ./news/washingtonpost-blogs-innovations.rss: feed.items[0].title  ==  "Google's AlphaGo beats the world's best Go player - again".
--- expected
+++ actual
@@ -1,2 +1,2 @@
 # encoding: UTF-8
-"Google\u2019s AlphaGo beats the world\u2019s best Go player - again"
+"Google\u2019s AlphaGo beats the world\u2019s best Go player \u2014 again"

## feed.items[0].title:       Google’s AlphaGo beats the world’s best Go player — again

=> fix reader - do NOT (auto-)convert dashes!!!!!!
```


add support for multi-line with (preserved) newlines:

```
<description><![CDATA[
<div>
<a href="http://www.washingtonpost.com/blogs/innovations/wp/2017/05/26/googles-alphago-beats-the-worlds-best-go-player-again/" title="Google&#039;s AlphaGo beats the world&#039;s best Go player -- again"><img title="Google&#039;s AlphaGo beats the world&#039;s best Go player -- again" src="http://www.washingtonpost.com/rf/image_960w/2010-2019/WashingtonPost/2017/05/25/KidsPost/Images/AFP_OW1JP.jpg" alt="Google&#039;s AlphaGo beats the world&#039;s best Go player -- again" style="maxwidth: ; maxheight: ;" /></a>
</div>
<br/>
AI: 2, Humanity: 0. A computer designed by Google researchers has beaten the world&#8217;s top Go player for the second game in a row, capturing the best-of-three match in Wuzhen, China, and confirming AI&#8217;s supremacy in what many consider as one of humanity&#8217;s most complex boardgames. Ke Jie, a 19-year old Go grandmaster, began the [&#8230;]]]></description>
```


---

in news/nytimes.rss

check

```
##  todo: how to check for empty description - use empty string (or use nil) ???
## <description/>
>>> pp feed.description
```
