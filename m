From: Grant Edwards <grant.b.edwards@gmail.com>
Subject: Re: Add hardware handshaking to pseudo-tty and USB serial gadget
Date: Thu, 21 Mar 2013 20:38:39 +0000 (UTC)
Message-ID: <kifr4e$kc5$1@ger.gmane.org>
References: <5D7CD300-386D-4AA1-B48A-0051D17C1F1F@beamcommunications.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:51943 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752057Ab3CUUi4 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 21 Mar 2013 16:38:56 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <lnx-linux-serial@m.gmane.org>)
	id 1UImGa-0003K7-MU
	for linux-serial@vger.kernel.org; Thu, 21 Mar 2013 21:39:16 +0100
Received: from dsl.comtrol.com ([64.122.56.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Thu, 21 Mar 2013 21:39:16 +0100
Received: from grant.b.edwards by dsl.comtrol.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Thu, 21 Mar 2013 21:39:16 +0100
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

On 2013-03-21, Craig McQueen <craig.mcqueen@beamcommunications.com> wrote:

> I'm interested in having support for hardware handshaking lines for
> both pseudo-tty (Unix 98 style) and USB serial gadget drivers. Unless
> I've missed something, it looks as though they don't support the
> hardware handshaking lines.
>
> Has anyone worked on this already, for either pseudo-tty or USB
> serial gadget?

For years, I've wanted to be able to implement serial-ports in
user-space, but the pseudo-tty implments too small a subset of the tty
API to make it usable for that.  In addition to the TIOCMSET/TIOCMGET
support, it would need to support all the other standard serial-port
configuration options (character len, parity, baud rate, RTS/CTS flow
control, etc.).

I asked several years ago if such enhancements to the pseudo-tty
driver would be accepted, but I never got any response, so I took that
as a "no".

> It sounds as though people have done pseudo-ttys with HW handshaking
> support--eg tty0tty project. However I'd rather implement this
> function in the kernel pseudo-terminal driver itself. Is there any
> reason not to do that?

No reason other than you and I are the only two people who care about
it. :)

> I was wondering how to handle the HW lines on the master side of the
> pseudo-tty, and on the USB gadget device. It's the opposite way to a
> regular serial port (DCE rather than DTE), so you _write_ DSR, CTS,
> DCD and RING, and _read_ DTR and RTS. There could be two ways to do
> this:
>
> 1) Reverse normal operations, so do TIOCMSET of TIOCM_DSR, TIOCM_CD
> etc.

That's what I'd vote for.

> 2) Act like a normal port, and "cross-over" signals. So do
>
> TIOCMSET of TIOCM_DTR, which changes DSR on the slave; TIOCMGET of
> TIOCM_DSR to read the state of DTR set by the slave. Etc. What about
> setting the slave's DCD and RING? Maybe do TIOCMSET of TIOCM_OUT1 and
> TIOCM_OUT2 on the master.

I think that would make code on the master side confusing. If I want
to set CD from the master side, I'd rather do ioctl(TIOCMSET,TIOCM_CD)
than ioctl(TIOCMSET,TIOCMOUT1).

> Same question for the USB serial gadget.

I'm afraid I don't know anything about USB serial gadgets.

> So which of those choices would be better? I think I prefer (2)
> because the user code stays more the same whether it's talking to a
> master device or slave device.

It depends on what you want to do with the resulting device-pair.  If
you want a peer-to-peer software "null-modem" cable to hook together
two applications that both expect to talk to serial ports via the
existing API, then (2) is definitely the way to go, but you've got do
decide how to wire the null-modem.  In real null-modem cables, it's
usually done something like this:

     DTR  ---+-- DSR
             |   
             +-- CD

     RTS  ---+-- CTS
             |
             +-- RI  (RI is sometimes left disconnected).

If you want to end up with something that's going to work with
existing apps, you should probably stick to the above and forget about
OUT1 and OUT2.
             
But, a virtual null-modem cable betwen two applications is not what
I've wanted to do in the past.  I've wanted to impliment a pseudo
serial port in user-space using code that, for example, communicates
with the read serial port hardware via Ethernet.  For that application,
I think (1) is better.

If you go with (1), then it's pretty simple to write a small app that
hooks together the master sides of two pairs to provide a virtual
null-modem cable (and it's easier to change the wiring of the
null-modem cable depending on the situation).

-- 
Grant Edwards               grant.b.edwards        Yow! All right, you
                                  at               degenerates!  I want
                              gmail.com            this place evacuated in
                                                   20 seconds!

