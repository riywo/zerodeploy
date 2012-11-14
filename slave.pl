#!/usr/bin/env perl
use strict;
use warnings;
use ZMQ;
use ZMQ::Constants qw/ZMQ_SUB ZMQ_SUBSCRIBE/;

my $master = $ENV{ZD_MASTER} // 'localhost';
my $port   = $ENV{ZD_PORT} // 9999;

my $path   = $ARGV[0] or die;
my $cxt = ZMQ::Context->new();
my $sub = $cxt->socket(ZMQ_SUB);
$sub->connect("tcp://$master:9999");

$sub->setsockopt(ZMQ_SUBSCRIBE, '');

print "subscribe from $master:$port\n";
while (my $msg = $sub->recv()) {
    my $master_path = $msg->data();
    print "receive message '$master_path'. sync\n";
    system("rsync -az $master:$master_path $path");
}
