= Ken

* http://www.github.com/michael/ken

== DESCRIPTION:

Ken is a Data Layer for Knowledge Representation.

It's being built to access the Metaweb Services supplied by Freebase.com.
Just born, the project’s goals are the provision of a concise API for querying and writing.
Therefore it wraps the Metaweb Architecture to smart Ruby Objects (that represent the Metaweb Architecture).

You can navigate the Freebase Graph using a rubyish syntax.

You should be able to use this Library as a Data Layer (instead of or in addition to 
ActiveRecord/DataMapper) for your Web Framework of choice (Merb, Rails).


== FEATURES/PROBLEMS:

Features

* Fetching of single Resources
* Type inspection
* Attributes inspection
* Views on Resources to group Attributes based on the Resource's types
* Some specs

Roadmap

1. Much more specs
2. Support for querying of multiple Resources
3. Better Type Support
4. API for Set Based Browsing (see http://mqlx.com/~david/parallax/)
5. Accessing Properties/Attributes directly (e.g. resource.genres )
6. Write-Support

== SYNOPSIS:

resource = Ken.get('/en/new_order') # => <Resource id="/en/new_order" name="New Order">

== REQUIREMENTS:

- Ruby >=1.8.x
- RubyGems >=1.2.x
- Extlib >=0.9.x

== INSTALL:

$ gem sources -a http://gems.github.com (you only have to do this once)
$ sudo gem install michael-ken

== LICENSE:

(The MIT License)

Copyright (c) 2009 Michael Aufreiter

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
