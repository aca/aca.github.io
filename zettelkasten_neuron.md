---
title: "neuron: Zettelkasten"
date: 2020-11-18T19:20
tags:
  - timeline
  - neuron
  - zettelkasten
---

This site is generated by [Neuron](https://neuron.zettel.page/).

For my entire life, I had a hard time organizing my log, memo, and thoughts. I tried 
[Microsoft Sticky Notes](https://en.wikipedia.org/wiki/Sticky_Notes),
[Google Keep](https://keep.google.com),
[Boost Note](https://boostnote.io/),
[Evernote](https://evernote.com/),
[Notion](https://www.notion.so/) ... But I just couldn't settle down and kept hopping around different solutions on the market. 

Systems like these have a lot of power features and fairly complex systems. But none of it actually helped me to 
organize my mind. As my notes grow, I had to waste a lot of time re-organizing things in a
way I wanted, which also changes quickly.
At some point, I just gave up and wrote simple text
documents with directory-based hierarchies. 
By using just "files", I was able to achieve ...
- Systems that I can fully control(data sync(syncthing), git, security..)
- Plain file, which can easily be exported/imported, able to use my own search engine(rg, fzf)
- No file format limitation
- VIM as an editor
- Fast, I don't want to wait for seconds to load/write a short memo

However, to connect each memo and organize it, I needed some other way to add metadata to the document,
directory was obviously not enough. And I found
[Zettelkasten](https://en.wikipedia.org/wiki/Zettelkasten) and
[Neuron](https://neuron.zettel.page/). 

As far as I understand, zettelkasten is just a plain note taking system that has no hierarchies. 
Notes are connected by some structured metadata, or just writing links to other notes. For linking, neuron use [Wiki-Style links](https://github.com/srid/neuron/pull/351).

And ... that's it!  
[Knowledge Management software](https://en.wikipedia.org/wiki/Knowledge_management_software) like neuron will connect them together.

<img src="https://upload.wikimedia.org/wikipedia/commons/1/1a/Zettelkasten_paper_schematic.png?centerme" width="700" style='padding: 2rem;'>

Here are articles I found interesting related to Zettelkasten.
- [https://zettelkasten.de/posts/overview/](https://zettelkasten.de/posts/overview/)
- [https://notes.andymatuschak.org/Evergreen_notes](https://notes.andymatuschak.org/Evergreen_notes)

There are actually multiple zettelkasten method implementations like
[Roam](https://roamresearch.com/), [Foam](https://github.com/foambubble/foam).
But I really love decisions made by [@srid](https://www.srid.ca/) for neuron.
- Multiple format support powered by [pandoc](https://www.srid.ca/cbf057a6.html).
- Pretty html publishing, just like [Emacs Org-mode](https://orgmode.org/worg/org-tutorials/org-publish-html-tutorial.html), [vim-wiki](https://github.com/vimwiki/vimwiki).
- Opensource, that doesn't go anywhere.
- Command line support.
- Editor of your own, powered by [LSP](https://github.com/srid/neuron/issues/213).  
  But there's no official LSP support yet, but till then you can try [my own implementation in go](https://github.com/aca/neuron-language-server). 

I believe my life-long struggle has ended and excited to see how it will grow 10 years later.  
One day I might also write my own version of neuron.