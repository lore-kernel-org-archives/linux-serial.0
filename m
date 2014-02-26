From: Grant Edwards <grant.b.edwards@gmail.com>
Subject: Re: API to flush rx fifo?
Date: Wed, 26 Feb 2014 17:51:13 +0000 (UTC)
Message-ID: <lel9ih$p6i$1@ger.gmane.org>
References: <kpak75$9ko$1@ger.gmane.org>
 <51BB2C2A.9050601@hurleysoftware.com> <kpfc5k$5u4$1@ger.gmane.org>
 <51BB3AD0.50201@hurleysoftware.com> <530E20EF.7070609@hurleysoftware.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:35678 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752061AbaBZRvl (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 26 Feb 2014 12:51:41 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <lnx-linux-serial@m.gmane.org>)
	id 1WIidu-0000Rv-8t
	for linux-serial@vger.kernel.org; Wed, 26 Feb 2014 18:51:38 +0100
Received: from dsl.comtrol.com ([64.122.56.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Wed, 26 Feb 2014 18:51:38 +0100
Received: from grant.b.edwards by dsl.comtrol.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Wed, 26 Feb 2014 18:51:38 +0100
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

On 2014-02-26, Peter Hurley <peter@hurleysoftware.com> wrote:
> Hi Grant,
>
> I know this is old but I had marked this for re-review in my mail,
> and after re-looking at this problem, I realized I gave you some bad info.
>
> Since you were referring to uart_ops, I'll assume this is for your
> serial-core mini-driver(s).

Yup.

Upon review of this thread, I see that you had warned me that
tty->receive_room was going away, and I completely forgot about that
warning and didn't do anything about it about that until my drivers
actually broke 8 months later.

Shame on me.

>>>>> How does the rx fifo get flushed when the user calls tcflush(TCIFLUSH)?
>>>>
>>>> It doesn't.
>
> The ioctl(TCIFLUSH) does in fact flush the tty buffers.
>
> If you want to flush your hardware rx fifo, you can define the
> .ioctl() method in your struct uart_ops and handle TCIFLUSH there.
>
> Note: be sure to return -ENOIOCTLCMD so that TCIFLUSH processing
> still gets seen by the ldisc!
>
> Like this (apologies in advance for formatting; my mailer is
> dain-bramaged),
>
> /* called with port->mutex held */
> static int xxxxxx_ioctl(struct uart_port *port, unsigned int cmd,
> 			unsigned long arg)
> {
> 	if (cmd == TCFLSH) {
> 		switch (arg) {
> 		case TCIFLUSH:
> 		case TCIOFLUSH:
> 			spin_lock_irq(&port->lock);
> 			xxxxxx_empty_rx_fifo(port);
> 			spin_unlock_irq(&port->lock);
> 			/* fall-through */
> 		}
> 	}
> 	return -ENOIOCTLCMD;
> }
>
> Sorry, hope this isn't too late :(

Great!  That's certalinly simple enough.

It turns out the customer's problem had nothing to do with the UART's
rx fifos not getting flushed when TCIFLUSH was done, so I put that
issue on the list of things to be worried about later (and that's
where it still is).

I'll add the above handling to my drivers just to be complete, but I
don't think it's actually ever caused any problems.

-- 
Grant Edwards               grant.b.edwards        Yow! I was making donuts
                                  at               and now I'm on a bus!
                              gmail.com            

