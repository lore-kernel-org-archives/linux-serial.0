From: David Lawyer <dave@lafn.org>
Subject: Re: serial port speeds >115k; PnP modem ID must contain modem substring
Date: Sat, 22 Feb 2003 01:20:08 -0800
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <20030222092008.GA492@lafn.org>
References: <20030221200939.GA1543@jats9> <20030221.235743.8.0.whitnl73@juno.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from localhost (mail@host-66-81-28-63.rev.o1.com [66.81.28.63])
	by zoon.lafn.org (8.12.3/8.11.3) with ESMTP id h1M9VZ6r071398
	for <linux-serial@vger.kernel.org>; Sat, 22 Feb 2003 01:31:40 -0800 (PST)
	(envelope-from dave@lafn.org)
Received: from dave by localhost with local (Exim 3.36 #1 (Debian))
	id 18mVpI-00009e-00
	for <linux-serial@vger.kernel.org>; Sat, 22 Feb 2003 01:20:08 -0800
Content-Disposition: inline
In-Reply-To: <20030221.235743.8.0.whitnl73@juno.com>
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

On Fri, Feb 21, 2003 at 11:56:00PM -0500, whitnl73@juno.com wrote:
> On Fri, 21 Feb 2003, Tim wrote:
> 
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
> 
> What error?  Quote exactly please.
It's clear that stty can't set 230.4k, likley because the 240.k feature
hasn't been enabled in the modem.
> If the doco says it can run faster than 115200, it should also tell
> what you have to do to make it do so.

Yes.  It will likely say (or imply) to use a driver they supply for
Windows only.  This will not be helpful for Linux.

> (this may involve setting register(s) in the modem, and will
> need in addition a setserial command to set baud_base (the serial
> driver's understanding of how to set the divisor for am app (pppd,
> FI) that requests a given speed) to get things to work
> as you would expect they should).

The above is not true in all cases since if you do the above, requesting
230.4k via stty etc., will simply send a divisor of value 1.  Some need
a certain high value of the divisor to work at 230.4k.

> I think you need to have programmed one of these things by hand to
> understand the doco so that you don't have to, but I don't know how to
> say it any better.

> >
> > At this point in my education, my guess is that the modem is
> > being treated like a 16550A without extended FIFOs or 230k
> > port speed.  If my modem was detected as a modem by Linux,
> > would setserial -a show something more?
> 
> It was detected as a serial port.  Linux does not detect modems at
> startup.

For ISA PNP (and PCI ?), the name of the device (the serial port built
into the modem) may include the name "modem" and Tim told me that
serial.c looks for the "modem" name for the ISA PNP case.

> As far as the OS can see, a modem is just a serial port.  As far as
> the serial driver can see, it is a 16550a with a 16 byte FIFO.  The
> serial driver can detect more modern UART's such as the 16950, but
> yours seems to behave as if it were a 16550A.  You need something
> beyond what the serial driver does by default to get the thing to run
> at a port speed >115200, I think.

The serial driver should ideally detect it by PnP, and enable it for
230.4k.  PnP identifies the device and then enables 230.4k for that
device.  But since Tim said in an email to me that had PnP disabled,
this can't possibly work.  
			David Lawyer
