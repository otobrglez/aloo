# Aloo
[Aloo] is simple way to create and share real-time analytical dashboards with others.
Think of it as **GIST for data**. [Aloo] is open-source and also available on [http://aloo.io][Aloo].

- [Oto Brglez](https://github.com/otobrglez)

## Why?
[Aloo] was build for [Rails Rumble 2014][rumble] in 48 hours time frame. Please read my [blog post](http://otobrglez.opalab.com/rails/2014/10/24/aloo-on-rails-rumble-2014.html) to get some more details.

## Setup for development

    brew install redis
    foreman start -f Procfile.development
    powder link ; powder open
    guard

## Licence

[LGPL](https://www.gnu.org/copyleft/lesser.html)

[Aloo]:http://aloo.io
[rumble]: http://railsrumble.com/entries/153-aloo-business-analytics-fast
