From: David Lawyer <dave@lafn.org>
Subject: Re: serial port speeds >115k; PnP modem ID must contain modem substring
Date: Sun, 23 Feb 2003 23:11:36 -0800
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <20030224071136.GA495@lafn.org>
References: <20030221200939.GA1543@jats9> <Pine.LNX.4.44.0302232044110.5171-100000@deadrat.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from localhost (mail@host-66-81-195-49.rev.o1.com [66.81.195.49])
	by zoon.lafn.org (8.12.3/8.11.3) with ESMTP id h1O7OJ9D062835
	for <linux-serial@vger.kernel.org>; Sun, 23 Feb 2003 23:24:19 -0800 (PST)
	(envelope-from dave@lafn.org)
Received: from dave by localhost with local (Exim 3.36 #1 (Debian))
	id 18nCm0-00008T-00
	for <linux-serial@vger.kernel.org>; Sun, 23 Feb 2003 23:11:36 -0800
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0302232044110.5171-100000@deadrat.localdomain>
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

On Sun, Feb 23, 2003 at 09:59:57PM -0800, rich+ml@lclogic.com wrote:
> Internal modems usually just have a simulated uart for software
> compatibility and baud rate is irrelevant (same for parity, stop bits,
> FIFO, etc). Set to 5 baud and see if you get same performance.

I set to 300 baud and couldn't connect.  Then at 1200 baud it connected but
download speeds were around 60 bytes/sec.  I estimated the received rate
from the /proc dir and it was close to 1200 baud.  So mine must have a
real UART.

Some modems brag that they can do 230.4k baud.  This is a serial port
speed.  So it seems like a real UART.  So what percent of internal
modems will operate at a high baud rate when one specifies low baud rate?

> 
> == Rich
> 
> On Fri, 21 Feb 2003, Tim wrote:
> 
> > Date: Fri, 21 Feb 2003 15:09:39 -0500
> > From: Tim <delt@gate-way.net>
> > To: linux-serial@vger.kernel.org
> > Subject: serial port speeds >115k; PnP modem ID must contain modem
> >     substring
> > 
> > I have a Diamond/Supra v90 ISA modem (model SUP2124) in my
> > Linux system running 2.4.20.  I've noticed that for the
> > type of file I commonly access (large html text table) 115k
> > port speed seems to be a significant bottleneck.  (These
> > files compress to <10% of raw size.  Transfer speed is
> > reported as ~10.5kByte/s, even if I reduce my modem speed
> > from the typical 45kbps to 28.8.)  The modem documentation
> > says it is capable of 230k port speed, so I tried specifying
> > 230400 in my ppp config, which resulted in 9600 baud port
> > speed; stty returns an error.
> > 
> > At this point in my education, my guess is that the modem is
> > being treated like a 16550A without extended FIFOs or 230k
> > port speed.  If my modem was detected as a modem by Linux,
> > would setserial -a show something more?
> > 
> > # setserial -a /dev/ttyS3
> > /dev/ttyS3, Line 3, UART: 16550A, Port: 0x02e8, IRQ: 10
> >         Baud_base: 115200, close_delay: 50, divisor: 0
> >         closing_wait: 3000
> >         Flags: spd_normal skip_test
> > 
> > I am not a programmer, but have been looking at the comments
> > in serial.c:
> > 
> > There seems to be an ISA PnP device device search, the success
> > of which depends on finding the string "modem" in PnP id:
> >   dev->name or dev->bus->name must contain "modem" substring;
> > 
> > However, the modem in this system was installed with PnP
> > disabled and does not have modem in its string:
> > # ANSI string -->SupraExpress 56i Voice<--
> > 
> > What are the consequences of failing this test?  If the
> > string were changed, could the test succeed with the modem
> > jumper not in PnP mode?
> > 
> > There seems to be a "quickie test to see how big the FIFO is".
> > How can I cause the results of that test to be logged?
> > 
> > I now have CONFIG_SERIAL=y.
> > If I compile serial as a module, are there parameters that
> > can be added to modules.conf to enable available features
> > beyond what a 16550A has, or perhaps someone has patches
> > that would enable these features?
> > 
> > TIA,
> > Tim.
> > 
> > -
			David Lawyer
