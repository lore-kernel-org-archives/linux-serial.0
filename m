From: David Lawyer <dave@lafn.org>
Subject: Re: Serial/Parallel conflicts
Date: Sat, 22 Feb 2003 23:41:12 -0800
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <20030223074112.GA374@lafn.org>
References: <20030129170750.GA1066@wheat.boylan.org> <Pine.LNX.4.44.0301291034030.5171-100000@deadrat.localdomain> <20030131055640.GA763@wheat.boylan.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from localhost (mail@host-66-81-197-159.rev.o1.com [66.81.197.159])
	by zoon.lafn.org (8.12.3/8.11.3) with ESMTP id h1N8Ej9D059803
	for <linux-serial@vger.kernel.org>; Sun, 23 Feb 2003 00:14:45 -0800 (PST)
	(envelope-from dave@lafn.org)
Received: from dave by localhost with local (Exim 3.36 #1 (Debian))
	id 18mql6-00006l-00
	for <linux-serial@vger.kernel.org>; Sat, 22 Feb 2003 23:41:12 -0800
Content-Disposition: inline
In-Reply-To: <20030131055640.GA763@wheat.boylan.org>
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

On Thu, Jan 30, 2003 at 09:56:40PM -0800, Ross Boylan wrote:
> This is kind of a "please tell me it isn't so message."  
> My efforts to dislodge ttyS2 (aka COM3, my internal modem) from IRQ 5
> have been unsuccessful.  The BIOS offers no direct control over it,
> since it is not a built in serial port.
> 
> In particular, neither of the following worked, even with reboots:
> 1. reprogramming the card via /proc/isapnp.  If I set the IRQ to a
> value other than shown in the dmesg start up, I can't communicate with
> the modem at all.  This doesn't make any sense to me, since the serial
> port is actually part of the card (as I understand it), and presumably
> is reprogrammed by isapnp.
You need to use setserial to tell the driver what isapnp set it to.
isapnp doesn't tell the driver how you set the IRQ.
> 
> Is the problem that the serial driver can not adjust to changes in
> port locations after start up?
Yes and no.  It's yes after the the phase is completed where the driver
tries to detect the serial ports by PnP methods.

> 
> 2. I set the BIOS manually to use IRQ 5 for the parallel port.  I
> thought this would force it to put ttyS2 elsewhere, but it doesn't
> seem to.  The good news is that both the modem and the parallel port
> appear to work sharing the same interrupt, so I may have symptomatic
> relief.
> 
> 3. I also disabled COM1 in BIOS, hoping to get the system to use the
> newly available interrupt.  It put one of the ethernet cards there
> (IRQ4).
> 
> Anyway, please tell me this info isn't just buried in the ESCD with no
> way to kick it out short of flashing the whole thing!  Isn't there
> some other way to influence it?  Is the full story "ESCD sets
> location; serial driver reads it; nothing changes it"?

One thing you might try is to tell the BIOS that you have a PnP OS and
then whatever is in the ESCD will be ignored.

			David Lawyer
