---
title: The complete guide to CSS Grid
published_at: 2018-08-12
---

CSS Grid has a lot of new stuff. New properties, new units, but most importantly it
also requires you to think in a new way. This might sound a bit scary but I promise you
that it's gonna be worth it. This series of blog posts aims to be a comprehensive guide to
the wonder that is CSS Grid.

NOTE: This article is best read at a desktop. Not all examples will be mobile friendly. I will cover responsiveness in a later post.

## The old way
From the very early days of HTML and CSS, layout was very simple. Most of the stuff on the web
was actual documents, so the styling was very focused on a document-like structure. You had blocks (of text), inline-elements and lists (not even tables!). If you have the time I would suggest reading the [CSS 1 specification](https://www.w3.org/TR/CSS1/), it's pretty interesting to see what was available and the thoughts behind it.<sup>1</sup>

1: Especially Appendix E
{: .aside .footnotes}

CSS 2 had a lot more in it, but when it comes to layout it didn't change that much. It introduced tables, a layout with a two-dimensional structure but it wasn't really suitable for laying out
your page. It was instead floats, a property from the CSS 1 specification meant for having text wrap around an element that became the most popular solution for managing layouts.

It's pretty amazing to think that the modern web was created with only these simple primitives.
But it's also a bit scary, like if someone tried to recreate a poster from Photoshop or InDesign
in Microsoft Word. This is why grid requires you to think in a new way, because the old way to do
layout is fundamentally broken. It's time to learn it again, and learn it right.

## The new way
Enter flexbox and grid. I'm gonna pull straight from the specification here.

> The [flexbox] specification describes a CSS box model optimized for user interface design. In the flex layout model, the children of a flex container can be laid out in any direction, and can “flex” their sizes, either growing to fill unused space or shrinking to avoid overflowing the parent. Both horizontal and vertical alignment of the children can be easily manipulated. Nesting of these boxes (horizontal inside vertical, or vertical inside horizontal) can be used to build layouts in two dimensions.

> This CSS module defines a two-dimensional grid-based layout system, optimized for user interface design. In the grid layout model, the children of a grid container can be positioned into arbitrary slots in a predefined flexible or fixed-size layout grid.

What's the similiarity here? Notice the phrase "optimized for user interface design". We have
moved away from document land, here are the first two layout primitives for making actual user
interfaces. About time. Grid and Flex also work great together.

### Enough history and definitions, lets make something

Right on. Feature columns are still hot, right?

<div class="grid-guide feature-row">
  <div>
    <h3>Burn</h3>
    <p>This is some piece of text</p>
  </div>
  <div>
    <h3>Yeah</h3>
    <p>This is a longer piece of text. About double the size</p>
  </div>
  <div>
    <h3>Only title</h3>
  </div>
</div>

```
.grid-guide {
  &.feature-row {
    display: grid;
    grid-template-columns: 1fr 1fr 1fr;
    grid-gap: 15px;
    & > div {
      // item styling omitted. No grid-specific styling here!
    }
  }
}
```

Let's break this down

 * `display: grid` makes this item a grid container.
 * `grid-template-columns: ...` defines three grid lines, each with 1 *fraction* of the available space
 * `grid-gap` is the size between columns (and rows). Notice that this gap is not applied to the left of the first element or to the right of the last element, this spacing is only intended as the space between the columns & rows.

We haven't defined any rows, the browser has automatically created one row for us with a height of `auto`. If we would add a fourth item there would be a second row where it will be placed, since
we only defined 3 columns no more items can fit on the first row. But yeah, only having one row is
a bit boring, and this we could have pretty easily made in flexbox. Let's try something a little bit different.


<div class="grid-guide feature-row feature-row-2">
  <div>
    <h2>Burn</h2>
    <p>This is some piece of text</p>
  </div>
  <div>
    <h3>Yeah</h3>
    <p>This is now a short text.</p>
  </div>
  <div>
    <h3>Not only title</h3>
    <p>Lets write something more here now. to fill it out just a little bit. Apperently "The land divides, the sea unifies" is an old saying when there was no great transportation method by land.
  </div>
</div>

```
.grid-guide {
  // previous code omitted
  &.feature-row-2 {
    grid-template-columns: max-content 1fr;
    & > div {
      text-align: left;
      &:nth-child(1) {
        // background and text-shadow stripped
        grid-row-end: span 2;

        display: flex;
        flex-direction: column;
        justify-content: center;

        font-size: 1.2rem;
        padding: 0 2rem;
        font-weight: 700;
      }
    }
  }
}
```

Whew, there's a lot going on here. Lets start at the top. We redefine our column track with
`grid-template-columns: max-content 1fr`. Here we got a brand new unit! `max-content` says that
the track size should grow as large as it can until it can fit all content without wrapping. This sounds a little bit weird as a size unit but it can be incredibly handy and we will make use of it many times in this guide. Notice that the column is just as big as the line of text + padding. If we'd remove a word, the column would shrink and if we'd add a word it would grow. Then we have a
fractional unit again, saying that the second column should use up all the rest of the available space.

Wait, couldn't we have done this with flex too? Ah, yes attentive reader, this would work if we would wrap each column track in a wrapper element. But aside from making your HTML more bloated, it limits our options when it comes to collapsing. Imagine we would like to put the green box top, image center, and teal box bottom on a mobile view. It wouldn't work if we wrapped the green and teal box together!

{: .aside}

Then, the other only grid-specific css is telling the browser that the first child should span 2
rows. And you can see that it spans two rows. The rest is just some styling and standard flex
vertical centering. What I think is great in this example is the responsiveness to *content*
we see here. The height of the rows is determined by `auto`, which in this case is the height of
the two colored boxes together. And the width is determined by the line-length of the image box.
If we would use bootstrap framework, we'd just make the columns half the width and call it a day.
But grid allows us more flexibility to fine-tune our layouts but still make it responsive to the content.

### Explicit placement & controlled overlap

So far we've let the browser autoplace our grid-items. But we can also align our items to any grid
lines we would like. With this we can create some overlap between items as well.


<div class="grid-guide feature-row feature-row-2 feature-row-3">
  <div>
    <h2>Burn</h2>
    <p>This is some piece of <span>text</span></p>
  </div>
  <div>
    <h3>Yeah</h3>
    <p>This is now a short text.</p>
  </div>
  <div>
    <h3>Not only title</h3>
    <p>Lets write something more here now. to fill it out just a little bit. Apperently "The land divides, the sea unifies" is an old saying when there was no great transportation method by land.
  </div>
</div>

This is one of the coolest features. Why? This might not seem like much, but take a closer look to
where the green box aligns. I added an underline to make it a little bit clearer. Yep, to the last word. And the last word can be as long as we'd like, it would still line up perfectly. For this example, you might be scratching your head a little bit. Why would we like to do that? Well imagine we had a inline logo there for example, or a green button or whatever. This kind of fine grained control over the placement which is responsive to the content is something never seen in css and can be a bit tricky to do even with Javascript.

At the bottom you'll find the scss for this, and it *is* a bit tricky. Explaining it will have to wait until the next part of this series, so stay tuned! It will include how to think about
structuring layouts.

```
.grid-guide {
  &.feature-row-3 {
    grid-template-columns: max-content min-content 15px 1fr;
    grid-column-gap: 0;
    & > div {
      &:nth-child(1) {
        grid-column: 1 / 3;
        grid-row: 1 / 3;
        span {
          border-bottom: 4px solid material-color('green', '600');
        }
      }
      &:nth-child(2) {
        grid-column: 2 / 5;
        grid-row: 1 / 2;
        clip-path: none;
        z-index: 99;
      }
      &:nth-child(3) {
        grid-column: 4 / 5;
        grid-row: 2 / 3;
      }
    }
    
  }
}
```