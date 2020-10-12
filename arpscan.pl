#--------------------------------------------------------------------------------
#Description: This Perl script uses sub routines to scan for ARP Replies 
#             and requests and runs them simultaneously.
#
#
# Name: Aditya Patel
# Student ID: 10197165
# Date: 6/29/2018
#
#---------------------------------------------------------------------------------



#!/usr/bin/perl -w


use Net::Pcap::eEasy;
use Net::ARP;
use Net::Netmask;


#  I made a table for myself so I know which variable to assign to which process, while refering to the 
#  previous labs code.
#      child     parent
#      listen    tshark 

pipe (ARPREPLY, ARPREQUEST);
autoflush ARPREQUEST 1;

#Setting up the parent ID
my $parent = $$;

sleep 1;  #using sleep whenever neccessary throughout the script to pause some commands

my $child = fork // die "Cannot fork. Aborted. $! \n";


if($child) {
#invoking the subroutine for the arp request 
	&arprequest($child);
	close ARPREQUEST;
	waitpid($child,1);
	sleep 5;
	print "Killing child $child. \nExiting parent $$. \n";
	sleep 4;
	kill ('KILL', $child);
	exit();
	
}

else {
	&arpreply($parent);

}

	
#creating the subroutine to capture the packets
sub arpreply {
	#the code block from the lecture 
	my $listener = Net::Pcap::Easy->new(
		dev => 'eth0',
		filter => "arp",
		packets_per_loop => 1,
		arp_callback => sub {
			my ($npe, $ether, $arp, $header ) = @_;
			if ($arp->{opcode} ==2) {
			$iphex = $arp->{spa};
			my @ip = ($iphex =~ /(..)(..)(..)(..)/);
			$ipstr = hex($ip[0]) . "." . hex($ip[1]) . "." . hex($ip[2]) . "." . hex($ip[3]);
			print "$ipstr is alive.\n";
			}
		}
	);
	#looping the listener so it keeps looking for replies
	close ARPREQUEST;
	$listener->loop while 1;
	
}	
close ARPREPLY;

&arprequest;
#assigning the subroutine for ARP requests

sub arprequest {
	sleep 2;
	
	#assigning my computers network to the variable 
	my $network = "192.168.0.113/24";
	print "Scanning $network\n";
	print "Starting child $child with parent $$.\n";
	print "Starting child PID: $_[0]\n";
	
	#code block from lecture slides
	my $networkobject = new Net::Netmask($network);
		for my $remoteip ($networkobject->enumerate) {
			my ( $npe, $ether , $arp, $header) = @_;
			Net::ARP::send_packet (
			"eth0",
			"192.168.0.113",
			"$remoteip",
			"00:0c:29:89:ec:fb", #using my MAC address found by using the ifconfig command in linux.
			"ff:ff:ff:ff:ff:ff",
			"request");
		}	

}			

















