From: Tim <delt@gate-way.net>
Subject: port speeds >115k
Date: Mon, 24 Feb 2003 12:57:38 -0500
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <20030224175738.GA349@jats9>
References: <Pine.LNX.4.44.0302232044110.5171-100000@deadrat.localdomain> <20030224071136.GA495@lafn.org> <20030221200939.GA1543@jats9> <Pine.LNX.4.44.0302232044110.5171-100000@deadrat.localdomain> <20030221200939.GA1543@jats9> <20030221.235743.8.0.whitnl73@juno.com> <20030222092008.GA492@lafn.org> <20030221200939.GA1543@jats9> <20030221224119.GD350@lafn.org> <20030221200939.GA1543@jats9>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20030222092008.GA492@lafn.org> <20030221.235743.8.0.whitnl73@juno.com> <20030221224119.GD350@lafn.org> <20030221200939.GA1543@jats9> <20030223104525.A206@lnx2.w8mch.ampr.org> <20030224071136.GA495@lafn.org> <Pine.LNX.4.44.0302232044110.5171-100000@deadrat.localdomain>
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

[cc's not required]

> > > stty returns an error.
> > 
> > What error?  Quote exactly please.

stty -F /dev/ttyS3 230400
stty: /dev/ttyS3: unable to perform all requested operations

> > If the doco says it can run faster than 115200, it should also tell
> > what you have to do to make it do so.
> 
> Yes.  It will likely say (or imply) to use a driver they supply for
> Windows only.                                       ^^^^^^^^^^^

Ha! ~"All our 56k modems are capable of supporting 230k ... go find
a driver from someone else", actually.  Or try to ID the chipset &
find the datasheet.

> > > If my modem was detected as a modem by Linux,
> > > would setserial -a show something more?
> > 
> > It was detected as a serial port.  Linux does not detect modems at
> > startup.

I guess all that modem stuff in serial.c is just for PnP addr/irq init.

> > There seems to be a "quickie test to see how big the FIFO is".
> > How can I cause the results of that test to be logged?
> Is this test done by some Linux utility?

grep quickie drivers/char/serial.c

> > Internal modems usually just have a simulated uart for software
> > compatibility and baud rate is irrelevant (same for parity, stop bits,
> > FIFO, etc). Set to 5 baud and see if you get same performance.

Well I noticed stty <anyspeed> makes no dif in an xterm, or the 
getty on a vc, but with 
http://members.gate-way.net/delt/test/500k.html
my hardware ISA modem behaves like:

CARRIER	PORT	AVG.RATE
=======	====	========
46k	115k	10.5kB/s
26k	115k	10.5kB/s
14k	115k	10.5kB/s
46k	 57k	 5.3kB/s

For viewing large html text tables with a fast browser like Dillo,
230k could ~double the speed of the whole process.

> I set to 300 baud and couldn't connect.  Then at 1200 baud it connected but
> download speeds were around 60 bytes/sec.  I estimated the received rate
> from the /proc dir and it was close to 1200 baud.  So mine must have a
> real UART.
> 
> Some modems brag that they can do 230.4k baud.  This is a serial port
> speed.  So it seems like a real UART.  So what percent of internal
> modems will operate at a high baud rate when one specifies low baud rate?

I've seen non-rigorous test results on the net indicating that some
softmodems have no port-speed bottleneck.  It'd be great to have a GPL
HSP modem for Linux, now that GHz CPUs are the norm.  This groveling
for 230kbits/s through a device sitting directly on the system bus,
and being hobbled by hostile hw/sw producers is hard to take.  Wonder
what the absolute minimum hardware for a modem is...
