From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: Add hardware handshaking to pseudo-tty and USB serial gadget
Date: Thu, 21 Mar 2013 20:03:35 -0400
Message-ID: <1363910615.3395.9.camel@thor.lan>
References: <5D7CD300-386D-4AA1-B48A-0051D17C1F1F@beamcommunications.com>
	 <kifr4e$kc5$1@ger.gmane.org> <1363904564.4488.47.camel@thor.lan>
	 <DB8F1B3EEF94C3439BFFE674EB05E3CC23F2F537@SINPRD0211MB405.apcprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout01.c08.mtsvc.net ([205.186.168.189]:51995 "EHLO
	mailout01.c08.mtsvc.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752016Ab3CVADl (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 21 Mar 2013 20:03:41 -0400
In-Reply-To: <DB8F1B3EEF94C3439BFFE674EB05E3CC23F2F537@SINPRD0211MB405.apcprd02.prod.outlook.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Craig McQueen <craig.mcqueen@beamcommunications.com>
Cc: Grant Edwards <grant.b.edwards@gmail.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Jiri Slaby <jslaby@suse.cz>

[ +Jiri Slaby who doesn't read linux-serial ;) ]

On Thu, 2013-03-21 at 23:32 +0000, Craig McQueen wrote:
> 
> > From: Peter Hurley [mailto:peter@hurleysoftware.com]
> > On Thu, 2013-03-21 at 20:38 +0000, Grant Edwards wrote:
> > > On 2013-03-21, Craig McQueen <craig.mcqueen@beamcommunications.com>
> > wrote:
> > >
> > > > I'm interested in having support for hardware handshaking lines for
> > > > both pseudo-tty (Unix 98 style) and USB serial gadget drivers.
> > > > Unless I've missed something, it looks as though they don't support
> > > > the hardware handshaking lines.
> > > >
> > > > Has anyone worked on this already, for either pseudo-tty or USB
> > > > serial gadget?
> > >
> > > For years, I've wanted to be able to implement serial-ports in
> > > user-space, but the pseudo-tty implments too small a subset of the
> > tty
> > > API to make it usable for that.  In addition to the TIOCMSET/TIOCMGET
> > > support, it would need to support all the other standard serial-port
> > > configuration options (character len, parity, baud rate, RTS/CTS flow
> > > control, etc.).
> > >
> > > I asked several years ago if such enhancements to the pseudo-tty
> > > driver would be accepted, but I never got any response, so I took
> > that
> > > as a "no".
> > 
> > Anything tacked onto the pty driver is a non-starter because any app
> > that mis-handles termios for a pty will be in for a shock. There's a
> > lot of weird legacy behavior that must continue to work.
> 
> I understand that could be a concern.
> 
> How about we add the functionality to the pty driver, but it's
> disabled by default, and applications that want it can turn it on with
> an ioctl call?

It's not my place to say yes or no here.

FWIW the pty driver is still a maintenance burden -- I just fixed 2
problems with open()/close() this release.

> > > > It sounds as though people have done pseudo-ttys with HW
> > handshaking
> > > > support--eg tty0tty project. However I'd rather implement this
> > > > function in the kernel pseudo-terminal driver itself. Is there any
> > > > reason not to do that?
> > >
> > > No reason other than you and I are the only two people who care about
> > > it. :)
> > 
> > Assuming you're leaning toward an in-kernel solution, why not just
> > implement a new tty driver that behaves like a local serial port?
> 
> The pseudo-tty already provides most of the functionality I want, so I
> don't want to reinvent the wheel. I want to use it to simulate a modem
> device. Various other programs could benefit from an enhanced
> pseudo-tty, so they also don't have to implement their own kernel
> drivers--e.g.:

I should have been more specific: I didn't mean necessarily start from
scratch. As a starting point you could just dup pty.c, rip out the BSD
legacy support, and rename the driver/tty device base names.

Whatever that was would behave just like ptm/pts.

> * interceptty could be enhanced if the pseudo-tty could handle
> hardware handshaking as well as setting port speed etc.
> * Serial-over-Ethernet (RFC-2217) client drivers could use a
> pseudo-tty to implement the virtual tty device, including hardware
> handshaking and setting port speed etc.
> 
> > For the firewire-over-serial staging driver, I did a software-only
> > loopback driver that does all that (simulate MCTRL, etc.) as a way to
> > test and isolate firewire/dma problems from data handling and tty
> > driver problems.
> > 
> > > > I was wondering how to handle the HW lines on the master side of
> > the
> > > > pseudo-tty, and on the USB gadget device. It's the opposite way to
> > a
> > > > regular serial port (DCE rather than DTE), so you _write_ DSR, CTS,
> > > > DCD and RING, and _read_ DTR and RTS. There could be two ways to do
> > > > this:
> > > >
> > > > 1) Reverse normal operations, so do TIOCMSET of TIOCM_DSR, TIOCM_CD
> > > > etc.
> > >
> > > That's what I'd vote for.
> > >
> > > > 2) Act like a normal port, and "cross-over" signals. So do
> > > >
> > > > TIOCMSET of TIOCM_DTR, which changes DSR on the slave; TIOCMGET of
> > > > TIOCM_DSR to read the state of DTR set by the slave. Etc. What
> > about
> > > > setting the slave's DCD and RING? Maybe do TIOCMSET of TIOCM_OUT1
> > > > and
> > > > TIOCM_OUT2 on the master.
> > 
> > This is the approach I took for simulating HW flow control over
> > firewire. Software null-modem cable.
> 
> Perhaps there are pros and cons for both options. If we can't get a
> clear consensus, could we make this configurable with an ioctl call?

I was just sharing my experience. For this part, "the right way" is
whatever you implement.

Regards,
Peter Hurley

