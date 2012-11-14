#!/usr/bin/env perl
use strict;
use warnings;
use ZMQ;
use ZMQ::Constants qw/ZMQ_PUB/;
use Filesys::Notify::Simple;

my $cxt = ZMQ::Context->new();
my $pub = $cxt->socket(ZMQ_PUB);
my $port = $ENV{ZD_PORT} // 9999;
$pub->bind("tcp://*:$port");

my $path = $ARGV[0] or die;

my $watcher = Filesys::Notify::Simple->new([$path]);
print "watch aud publish about '$path'\n";
while (1) {
    $watcher->wait(sub {
        for my $event (@_) {
            print "publish path '$event->{path}'\n";
            $pub->send($event->{path});
        }
    });
}
