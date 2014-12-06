drmb
====

drmb is the source repository of [drbleichenbacher.ch] (http://www.drbleichenbacher.ch/)

### Install

* Ruby  Version > 1.9
* Bundler Bundlr: http://bundler.io/


### Configuration Management


  bundle [install | update]


### Generate Website

`nanoc`

See docs: http://nanoc.ws/docs/

Run a local webserver: `nanoc view`

### Deploy

  nanoc deploy --target [public | staging]
