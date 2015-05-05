From: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: Re: earlycon: no match?
Date: Tue, 5 May 2015 18:32:17 +0200
Message-ID: <20150505163217.GK14416@pengutronix.de>
References: <20150503211054.GR15254@pengutronix.de>
 <55477BC1.6000805@hurleysoftware.com>
 <20150504194229.GR15254@pengutronix.de>
 <5547D4DB.8060300@hurleysoftware.com>
 <20150504205241.GT15254@pengutronix.de>
 <5547E447.9020604@hurleysoftware.com>
 <20150504215832.GW15254@pengutronix.de>
 <5547F350.7030405@hurleysoftware.com>
 <20150505045139.GY15254@pengutronix.de>
 <55489DF3.3070703@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55489DF3.3070703@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@pengutronix.de
List-Id: linux-serial@vger.kernel.org

On Tue, May 05, 2015 at 06:39:47AM -0400, Peter Hurley wrote:
> > > Further, I would ask how _you_ would programmatically distinguish
> > > misspellings amongst the following console strings?
> > >
> > > 	console=pl012,...
> > > 	console=_pl011,...
> > > 	console=pl,...
> > > 	console=ttyAMA0,...
> > 
> > Only the last line gives me output, but with the warning. All others are
> > misspellings but output nothing. The last one gives me a misspelling
> > warning, but it is the one that makes the output work.
> > 
> > Obviously this was not tested on an ARM device with a serial console,
> > because it doesn't work there.
> 
> The primary test platform was a ARM device with a serial console.
> And yes, it does work there.

Which ARM device was that, and which serial driver?
How did the kernel command line look like?

Maybe that helps me to understand how this is supposed to be used, which
is currently totally unclear.

> > Case A: console=ttyAMA0
> > 
> >   Result: - system boots with output on intended serial console
> >           - warning about having the earlycon misspelled
> >           - earlycon not operational, although driver supports it
> > 
> > Case B: console=pl011
> > 
> >   Result: - no output at all, because system doesn't output to its
> >             intented serial console.
> > 
> > Case C: ...?
> > 
> >   Are there other things I'm supposed to do in order to do it right?
> > 
> > So both cases A+B are not fully working as intented, right?
> > 
> > I'd like to fix it, but in order to do so, I want to learn how it is
> > actually *intended* to work.
> 
> What do you want to "fix"?
> 
> Please stop using the indefinite pronoun, "it". I have no idea to what
> you are referring, because I already supplied you with a patch to "fix"
> the loglevel of the message.

I have explained that above, under "Case A" and "Case B"...?

Sorry, I simply don't get it.

My task:

  I want to setup a vexpress system with a pl011 serial port in a
  way that the console + early console is configured to be on
  /dev/ttyAMA0.

My attempts:

  Case A from above -> doesn't set the earlycon to /dev/ttyAMA0.
  Case B from above -> doesn't output anything.

I fail to find out how this task is supposed to be done in a way that
the kernel doesn't complain, and with the result to have console and
earlycon on /dev/ttyAMA0.

rsc
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
