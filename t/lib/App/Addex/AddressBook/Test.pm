#!perl
use strict;
use warnings;

package App::Addex::AddressBook::Test;
use base qw(App::Addex::AddressBook);

use App::Addex::Entry;
use App::Addex::Entry::EmailAddress;

my %DATASET = (
  _default => [
    {
      name   => 'Ricardo SIGNES',
      nick   => 'rjbs',
      emails => [
        { address => 'rjbs@example.com', label => 'work' },
        { address => 'rjbs@example.org', label => 'home' },
        { address => 'rjbs@example.biz', label => 'work' },
      ],
    },
    {
      name   => 'John Cappiello',
      nick   => 'jcap',
      emails => [ 'jcap@example.com' ],
      fields => { folder => 'co-workers/jcap' },
    },
  ],
);

sub entries {
  my ($self) = @_;
  
  my $setname = $self->{dataset} || '_default';
  my $set = $DATASET{ $setname };

  my @people;
  for my $person (@$set) {
    push @people, App::Addex::Entry->new({
      %$person,
      emails => [
        map { App::Addex::Entry::EmailAddress->new($_) } @{ $person->{emails} }
      ],
    });
  }

  return @people;
}

1;
