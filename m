From: Ross Boylan <RossBoylan@stanfordalumni.org>
Subject: Serial port shuts down APC UPS
Date: Thu, 23 Jan 2003 17:39:02 -0800
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <20030124013902.GF765@wheat.boylan.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Content-Disposition: inline
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Ross Boylan <RossBoylan@stanfordalumni.org>

When I connect my APC BackUPS 650 to ttyS1 the unit turns off when
Linux starts up.  APC tells me (after several days) that a different
cable is necessary for Unixy systems than for windows.  Apparently
some voltage on the serial port gets transmitted back to the unit,
which interprets it as a shut down signal.  (That is, I continue to
get power, but if the wall power fails the battery won't kick in).

Since the hardware works under Windows, I assume there is a software
solution, and I would like to find it.

APC further says the port should be at 2400 baud, with Flow set to
XON/XOFF (which might also be known as no FIFO).  I find baud control
but no flow control in setserial, and at any rate my understanding is
that it doesn't reprogram the physical device.

serial.c appears to set FIFO on, so that's probably part of the
problem.  Is it safe to turn it off, or would that require
rearchitecting things?  (Also, I don't know how to turn it off).

As a final complication, I get "LSR safety check engaged" on ttyS1
when I start, even if the cable is disconnected.  My suspicion is that
this indicates I have the wrong IO range or IRQ in setserial.

I've built my kernel from source (2.4.19 under Debian), so it would be
relatively easy for me to modify serial.c (for example)--if I knew
what to do!

Gigabyte GI-7IXE4 motherboard, using the AMD 751/756 chipset.  Athlon
processor.  I've looked around for the ports in /proc/isapnp and
lspci, but haven't found anything.  A mouse is on the other port, and
I have an internal modem using another port.  Also using USB scanner.
There are quite a lot of peripherals; interrupts are in short supply.

In case you can't tell, I'm no hardware expert.  I'd appreciate any
help.  What do I need to do to get the serial port to work with my
UPS?

Thanks.

P.S. I just subscribed to the list.  I'd appreciate it if you cc'd me
in case the subscription hasn't taken yet.
