#!/usr/bin/perl -w
# Output interface metrics
# Based on https://github.com/sensu-plugins/sensu-plugins-network-checks/blob/master/bin/metrics-interface.rb

use Getopt::Long qw(:config no_auto_abbrev no_ignore_case);
use Pod::Usage;
use Sys::Hostname;
use List::Util qw(any);

my $scheme = hostname() . '.interface';
my $excludeinterfaceregex;
my $includeinterfaceregex;
my @excludeinterface;
my @includeinterface;

GetOptions(
	'scheme|s=s' => \$scheme,
	'exclude-interface-regex|X=s' => \$excludeinterfaceregex,
	'include-interface-regex|I=s' => \$includeinterfaceregex,
	'exclude-interface|x=s' => \@excludeinterface,
	'include-interface|i=s' => \@includeinterface,
) or pod2usage(2);

@excludeinterface = split(/,/, join(',', @excludeinterface));
@includeinterface = split(/,/, join(',', @includeinterface));

@metrics = qw(rxBytes
	rxPackets
	rxErrors
	rxDrops
	rxFifo
	rxFrame
	rxCompressed
	rxMulticast
	txBytes
	txPackets
	txErrors
	txDrops
	txFifo
	txColls
	txCarrier
	txCompressed);

my $now = time();
open(my $fh, '<', '/proc/net/dev') or die("Cannot open /proc/net/dev");

while (my $line = <$fh>) {
	my ($interface, $stats_string) = $line =~ /^\s*([^:]+):\s*(.*)$/;
	next unless $interface;

	next if $excludeinterfaceregex && $interface =~ $excludeinterfaceregex;
	next if $includeinterfaceregex && $interface !~ $includeinterfaceregex;
	next if @excludeinterface && any { $_ eq $interface } @excludeinterface;
	next if @includeinterface && !any { $_ eq $interface } @includeinterface;

	$interface =~ s/\./_/;

	my @values = split(/\s+/, $stats_string);

	next if !any { $_ != 0 } @values;

	for (my $i = 0; $i <= $#values; $i++) {
		my $metric = $metrics[$i];
		my $value = $values[$i];

		print "$scheme.$interface.$metric $value $now\n";
	}
}

close($fh);
