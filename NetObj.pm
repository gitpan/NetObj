package NetObj;

use NetObj::Request;
use NetObj::Server;

$VERSION = 1.00;


sub new {
    my ($class, @args) = @_;
    if ($args[0] eq 'Request') {
	return new NetObj::Request;
    } elsif ($args[0] eq 'Server') {
	return new NetObj::Server;
    } else {
	print("You must specify the type of netobject\n");
	exit(1);
    }
}


1;

=head2 NAME

  NetObj - allows you to create a distributed module platform for perl

=head2 SYNOPSIS

  ######  Server creation ######

  use NetObj;
  use NetObj::Block;
  
  my $server = new NetObj Server;

  $server->open();

  ($peer, $port) = $server->getconnectinfo();

  $objectname = $server->getrequest();
 
  $block = new NetObj::Block Object => $objectname;

  $module = $block->createblock();

  $server->putobj($module);

  $server->close();

  ##### To make a request #####

  use NetObj;
 
  my $req = new NetObj Request;

  $req->ObjectName($somemodulename);

  $req->request(Remote => $remotehostname);

  # [ .. you can then use the module like normal .. ]

=head2 DESCRIPTION

  NetObj allows you to distribute modules over a network in real time. 
  It's limitations are that of the B module,  so as of this moment,  it
  cannot do XSUBS,  and autoloading (I believe) and other funky stuff like
  that.

  More documentation will come as this moves beyond an Alpha release,  and
  into something more stable.

=head2 AUTHOR
 
  James Duncan <jduncan@hawk.igs.net>

=head2 THANKS TO...

  Felix Gallo, for providing some initial insight into this sort of thing.
  Malcolm Beattie, for the wonderful Perl Compiler (And more specifically
	the Bytecode->Asm part of it).

=cut