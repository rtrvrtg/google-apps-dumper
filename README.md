# Google Apps Dumper

Dumps entire contents of Google Apps email accounts using OfflineIMAP.

by Geoffrey Roberts  
g.roberts@blackicemedia.com  
geoffrey.roberts@smash.org.au

v0.1 Sunday, 10 March 2013

## Requirements

* Ruby
* OfflineIMAP to be installed  
  Install it using aptitude, port, homebrew, or whatever 
  depending on your platform.

## Installation

Copy *config-example.rb* to *config.rb* 
and change dump_config[:host] to your domain.

## Usage

<code>./dump.rb username theirPassword</code>

Dumping a user's entire mailbox takes a long time, especially if they 
have a lot of messages in there. Make yourself several coffees. Read 
a book. Read a book. Read a mighty fine book.

Once done, you will have the user's entire email archive, both sent 
and received, in the folder named for their username. It will take 
up a lot of disk space, so find something to do with it.

## Version history

### v0.1 Sunday, 10 March 2013

Initial rough-as-guts release

## Roadmap

* Find some way to upload it to an archive account or an external 
  store as part of the app process.
* Better documentation.
* Auto-installation for OfflineIMAP.

## License

GPL v2. See LICENSE.txt.

Offtopic: Don't you wish they had a Markdown version instead?
