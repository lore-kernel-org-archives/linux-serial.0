From: rich+ml@lclogic.com
Subject: Re: serial port speeds >115k; PnP modem ID must contain modem
 substring
Date: Mon, 24 Feb 2003 14:50:37 -0800 (PST)
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.44.0302241027070.5171-100000@deadrat.localdomain>
References: <20030224071136.GA495@lafn.org>
Reply-To: rich+ml@lclogic.com
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <20030224071136.GA495@lafn.org>
List-Id: linux-serial@vger.kernel.org
To: David Lawyer <dave@lafn.org>
Cc: linux-serial@vger.kernel.org

On Sun, 23 Feb 2003, David Lawyer wrote:

> Date: Sun, 23 Feb 2003 23:11:36 -0800
> From: David Lawyer <dave@lafn.org>
> To: linux-serial@vger.kernel.org
> Subject: Re: serial port speeds >115k; PnP modem ID must contain modem
>     substring
> 
> On Sun, Feb 23, 2003 at 09:59:57PM -0800, rich+ml@lclogic.com wrote:
> > Internal modems usually just have a simulated uart for software
> > compatibility and baud rate is irrelevant (same for parity, stop bits,
> > FIFO, etc). Set to 5 baud and see if you get same performance.
 
> I set to 300 baud and couldn't connect.  Then at 1200 baud it connected but
> download speeds were around 60 bytes/sec.  I estimated the received rate
> from the /proc dir and it was close to 1200 baud.  So mine must have a
> real UART.
Or the emulation limits receive rda interrupt rate to the virtual baud and 
word size :) 

> 
> Some modems brag that they can do 230.4k baud.  This is a serial port
> speed.  So it seems like a real UART.  So what percent of internal
> modems will operate at a high baud rate when one specifies low baud rate?
Don't know, maybe none anymore, my experience with modem design is 
dated. 

Bear in mind that the baud rate is set as a baud clock divisor in the
16550, where the nominal baud clock is 115200Hz. So for example to get
9600 baud you program a divisor of 12. The divisor can't be less than 1,
so 115200 baud is the max.

But some uarts have double baud clock which doubles all baud rates.  
Setting the divisor to 12 gets you 19200 baud. The software won't
automatically know this, it will still be CALLED '9600'. (You can fix this
by setting setserial base_baud, but it only affects string-to-divisor
conversion, not the hardware).

So if you had a doubled baud clock then when you set '115200' you'd
actually get 230400. Except this doesn't seem to be the case. 

So either it's enabled via modem-dependent means (e.g. a jumper), or the
internal uart doesn't support it even though the core modem design does.

> 
> > 
> > == Rich
> > 
> > On Fri, 21 Feb 2003, Tim wrote:
> > 
> > > Date: Fri, 21 Feb 2003 15:09:39 -0500
> > > From: Tim <delt@gate-way.net>
> > > To: linux-serial@vger.kernel.org
> > > Subject: serial port speeds >115k; PnP modem ID must contain modem
> > >     substring
> > > 
> > > I have a Diamond/Supra v90 ISA modem (model SUP2124) in my
> > > Linux system running 2.4.20.  I've noticed that for the
> > > type of file I commonly access (large html text table) 115k
> > > port speed seems to be a significant bottleneck.  (These
> > > files compress to <10% of raw size.  Transfer speed is
> > > reported as ~10.5kByte/s, even if I reduce my modem speed
> > > from the typical 45kbps to 28.8.)  The modem documentation
> > > says it is capable of 230k port speed, so I tried specifying
> > > 230400 in my ppp config, which resulted in 9600 baud port
> > > speed; stty returns an error.
> > > 
> > > At this point in my education, my guess is that the modem is
> > > being treated like a 16550A without extended FIFOs or 230k
> > > port speed.  If my modem was detected as a modem by Linux,
> > > would setserial -a show something more?
> > > 
> > > # setserial -a /dev/ttyS3
> > > /dev/ttyS3, Line 3, UART: 16550A, Port: 0x02e8, IRQ: 10
> > >         Baud_base: 115200, close_delay: 50, divisor: 0
> > >         closing_wait: 3000
> > >         Flags: spd_normal skip_test
> > > 
> > > I am not a programmer, but have been looking at the comments
> > > in serial.c:
> > > 
> > > There seems to be an ISA PnP device device search, the success
> > > of which depends on finding the string "modem" in PnP id:
> > >   dev->name or dev->bus->name must contain "modem" substring;
> > > 
> > > However, the modem in this system was installed with PnP
> > > disabled and does not have modem in its string:
> > > # ANSI string -->SupraExpress 56i Voice<--
> > > 
> > > What are the consequences of failing this test?  If the
> > > string were changed, could the test succeed with the modem
> > > jumper not in PnP mode?
> > > 
> > > There seems to be a "quickie test to see how big the FIFO is".
> > > How can I cause the results of that test to be logged?
> > > 
> > > I now have CONFIG_SERIAL=y.
> > > If I compile serial as a module, are there parameters that
> > > can be added to modules.conf to enable available features
> > > beyond what a 16550A has, or perhaps someone has patches
> > > that would enable these features?
> > > 
> > > TIA,
> > > Tim.
> > > 
> > > -
> 			David Lawyer
> -
> To unsubscribe from this list: send the line "unsubscribe linux-serial" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


