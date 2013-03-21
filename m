From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: Add hardware handshaking to pseudo-tty and USB serial gadget
Date: Thu, 21 Mar 2013 18:22:44 -0400
Message-ID: <1363904564.4488.47.camel@thor.lan>
References: <5D7CD300-386D-4AA1-B48A-0051D17C1F1F@beamcommunications.com>
	 <kifr4e$kc5$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout01.c08.mtsvc.net ([205.186.168.189]:43762 "EHLO
	mailout01.c08.mtsvc.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751398Ab3CUWWt (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 21 Mar 2013 18:22:49 -0400
In-Reply-To: <kifr4e$kc5$1@ger.gmane.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Grant Edwards <grant.b.edwards@gmail.com>, Craig McQueen <craig.mcqueen@beamcommunications.com>
Cc: linux-serial@vger.kernel.org

On Thu, 2013-03-21 at 20:38 +0000, Grant Edwards wrote:
> On 2013-03-21, Craig McQueen <craig.mcqueen@beamcommunications.com> wrote:
> 
> > I'm interested in having support for hardware handshaking lines for
> > both pseudo-tty (Unix 98 style) and USB serial gadget drivers. Unless
> > I've missed something, it looks as though they don't support the
> > hardware handshaking lines.
> >
> > Has anyone worked on this already, for either pseudo-tty or USB
> > serial gadget?
> 
> For years, I've wanted to be able to implement serial-ports in
> user-space, but the pseudo-tty implments too small a subset of the tty
> API to make it usable for that.  In addition to the TIOCMSET/TIOCMGET
> support, it would need to support all the other standard serial-port
> configuration options (character len, parity, baud rate, RTS/CTS flow
> control, etc.).
> 
> I asked several years ago if such enhancements to the pseudo-tty
> driver would be accepted, but I never got any response, so I took that
> as a "no".

Anything tacked onto the pty driver is a non-starter because any app
that mis-handles termios for a pty will be in for a shock. There's a lot
of weird legacy behavior that must continue to work.

> > It sounds as though people have done pseudo-ttys with HW handshaking
> > support--eg tty0tty project. However I'd rather implement this
> > function in the kernel pseudo-terminal driver itself. Is there any
> > reason not to do that?
> 
> No reason other than you and I are the only two people who care about
> it. :)

Assuming you're leaning toward an in-kernel solution, why not just
implement a new tty driver that behaves like a local serial port?

For the firewire-over-serial staging driver, I did a software-only
loopback driver that does all that (simulate MCTRL, etc.) as a way to
test and isolate firewire/dma problems from data handling and tty driver
problems.

> > I was wondering how to handle the HW lines on the master side of the
> > pseudo-tty, and on the USB gadget device. It's the opposite way to a
> > regular serial port (DCE rather than DTE), so you _write_ DSR, CTS,
> > DCD and RING, and _read_ DTR and RTS. There could be two ways to do
> > this:
> >
> > 1) Reverse normal operations, so do TIOCMSET of TIOCM_DSR, TIOCM_CD
> > etc.
> 
> That's what I'd vote for.
> 
> > 2) Act like a normal port, and "cross-over" signals. So do
> >
> > TIOCMSET of TIOCM_DTR, which changes DSR on the slave; TIOCMGET of
> > TIOCM_DSR to read the state of DTR set by the slave. Etc. What about
> > setting the slave's DCD and RING? Maybe do TIOCMSET of TIOCM_OUT1 and
> > TIOCM_OUT2 on the master.

This is the approach I took for simulating HW flow control over
firewire. Software null-modem cable.

Regards,
Peter Hurley



