---
title: Making of this blog, part one
published_at: 2018-08-20
---

Welcome! This is my first blog post here, so if you're reading this around the 8th of August there's probably not a navbar or even an index site for this blog. But  i wanted to start writing
as soon as possible and thought it would be kinda fun to document the creation of this blog as it is happening.

My old blog was statically generated with a ~100 line `gulpfile`, 
which worked pretty good but I wanted
a place to put all kinds of different projects on, as well as an excuse to write more 
Elixir and use [Phoenix](https://phoenixframework.org/).

Elixir is a language built on top of the Erlang VM, a language developed by Ericsson for high-stability systems
{: .aside}

I also wanted to experiment more with **CSS Grid**. In fact, this article layout is made in grid.
At first I didn't really know if it was well suited for an article layout but it turns out it's perfect. I generate my blog posts from markdown and require no additional processing of the HTML.
Here's the markup for my second paragraph:

```
My old blog was statically generated with a ~100 line `gulpfile`,  which worked pretty good but I wanted a place to put all kinds of different projects on, as well as an excuse to write more Elixir and use [Phoenix](https://phoenixframework.org/).

Elixir is a language built on top of the Erlang VM, a language developed by Ericsson for high-stability systems
{: .aside}
```
{: description="What magic is this?"}

![streetlights](https://78.media.tumblr.com/8db43da06e8876f424c46bab64940b8e/tumblr_nt5e6jhyFo1tnlk6io1_1280.jpg)
{: .image}

We can easily control bleed over the margins. There's only 1 media query in the css for this page and it's on the grid container. No responsive helper classes and no column nor row classes.
<span class="image-credit">Lolirofle</span>
{: .image-p title="Here's an image"}

As a web developer I really cannot praise grid enough. Not only does it make the
usual layouts currently strived for so much easier to make, it also facilitates entirely new layouts. If you're on a large screen (~1600w and up), try downsizing this window. Notice that the rightmost column
decreases in size much faster than the leftmost column. This is made purposefully since the
leftmost columns are for images and I'd like for them to take up more of the extra space available.

Actually did use grid at work today, just a few lines of css to fix a common ordering problem with a decent fallback.
{: .aside}

It can be a bit overwhelming at first though, which is a word I thought I would never use to describe part of the CSS spec. I'll make a post in the near future about my thought process on applying grid.

Also trying out webpack and TypeScript. Haven't written any TS yet though, the only JS on the page right now is to load the styles and wow it feels weird including a sass file in a javascript file
but hey, the live reload is absolutely fantastic, although when it's instantly refreshed it's hard
for me to not endlessly tweak the styling.

For production the styles shouldn't be in the scripts of course, but was eager to push this blog
out and try it on production environment as soon as possible so that's not fixed yet.
{: .aside}

### What to expect from this blog
...

I don't really know.

At least some webdev and general programming, that much I can promise. I have a lot of other
interests<sup>1</sup> as well but not really sure if I know enough about them to write about them. 

1: Music, design, history to name some.
{: .aside}

Well, a little bit about me then: I'm originally from Gothenburg but moved to Stockholm to study
computer science at KTH, which I'm 2 years in. Also got a pretty sweet software engineering job over the summer and will continue with that part time. Has also freelanced as a web developer for
about 3 years on and off. If this has caught your attention, check back here in a day or two as
there will (probably) be an RSS feed right [here](/posts/xml.rss) and maybe even another post.