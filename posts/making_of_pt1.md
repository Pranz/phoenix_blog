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

![phoenix image](https://blog.carbonfive.com/wp-content/uploads/2016/04/phoenix-elixir-1.png)
{: .image}

We can easily control bleed over the margins. There's only 1 media query in the css for this page and it's on the grid container. No responsive helper classes and no column nor row classes.
{: .image-p title="Here's an image"}

As a professional web developer I really cannot praise grid enough. Not only does it make the
usual layouts currently strived for so much easier to make, it also facilitates entirely new layouts. If you're on a large screen (~1600w and up), try downsizing this window. Notice that the rightmost column
decreases in size much faster than the leftmost column. This is made purposefully since the
leftmost columns are for images and I'd like for them to take up more of the extra space available.

Actually did use grid at work today, just a few lines of css to fix a common ordering problem with a decent fallback.
{: .aside}

It can be a bit overwhelming at first thougn. I'll make a post in the near future about my thought process on applying grid.