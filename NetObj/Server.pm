package NetObj::Server;

use IO::Socket;

sub debug {
  my ($self, %args) = @_;
  $self->{'Debug'} = $args{'Level'};
}

sub new {
  my ($class, %args) = @_;
  my $self = {};
  $self->{'Server'} = new IO::Socket    Bind => 8002,
					Listen => 5,
					Proto => 'tcp';

  if ($self->{'Server'} eq undef) {
	print "Unable to create a socket on port 8002!\n";
	exit(1);
  }

  $self->{'Server'}->autoflush();
  
  bless $self, $class;
}

sub open {
  my ($self, %args) = @_;
  $self->{'Socket'} = $self->{'Server'}->accept();
}

sub getrequest {
  my ($self, %args) = @_;
  my $data;
  chop($data = $self->{'Socket'}->getline());
  my ($request, $modulename) = split(/ /,$data);
  return $modulename;
}

sub putobj {
  my ($self, $block, %args) = @_;
  $self->{'Socket'}->print("$block");
}

sub close {
  my ($self, %args) = @_;
  $self->{'Socket'}->close();
}  

sub getconnectinfo {
  my ($self, %args) = @_;
  return ( $self->{'Socket'}->peerhost(), 
	   $self->{'Socket'}->peerport() 
         );
}

1;
