package NetObj::Block;

do Config;

sub new {
  my ($class, %args) = @_;
  my $self = {};
  $self->{'Object'} = $args{'Object'};
  bless $self, $class;
}

sub createblock {
  my ($self, %args) = @_;
  print "Creating Remote Block\n";
  open(FH, "$NetObj::Config::asmdir/$self->{'Object'}.asm") || print "Could not open file!\n";
  my @data = <FH>;
  close FH;
  my $block = join(/\n/,@data);
  return $block;
}

1;
