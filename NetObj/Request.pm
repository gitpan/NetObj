package NetObj::Request;

use IO::Socket;
use B;


sub new {
    my ($class, %args) = @_;
    my $self = {};
    # set up the object name to request.  This can be done later.
    bless $self, $class;
}

sub ObjectName {
    my ($self, $objectname, %args) = @_;
    $self->{'ObjectName'} = $objectname;
}

sub request {
    use B::Assembler;
    my ($self, %args) = @_;
    $self->{'Socket'} = new IO::Socket Peer => $args{'Remote'},
				       Port => 8002,
                                       Proto => 'tcp';
    if ($self->{'Socket'} eq undef) {
	my $mesg;
	if ($! =~ /bad file number/i) {
		$mesg = "no object server found!";
	}
	print("Cannot open socket: $mesg\n");
	exit(1)
    }
    $self->{'Socket'}->autoflush();
    $self->{'Socket'}->print("Request: " . $self->{'ObjectName'} . "\n");
    print "Assembling\n";
    my $asmdat;
    while ($line = $self->{'Socket'}->getline()) {
	$linenum++;
	chomp $line;
	if ($debug) {
	    my $quotedline = $line;
	    $quotedline =~ s/\\/\\\\/g;
	    $quotedline =~ s/"/\\"/g;
	    &$out(B::Assembler::assemble_insn("comment", qq("$quotedline")));
	}
	$line = B::Assembler::strip_comments($line) or next;
	($insn, $arg) = B::Assembler::parse_statement($line);
	$asmdat .= B::Assembler::assemble_insn($insn, $arg);
	if ($debug) {
	    $asmdat .= B::Assembler::assemble_insn("nop", undef);
	}
    }
    if ($errors) {
	die "Assembly failed with $errors error(s)\n";
    }
    B::byteload_string($asmdat);
    print "Assmbly done\n";
}


1;



