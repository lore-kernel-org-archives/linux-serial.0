From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/1] TTY: serial_core, fix dtr_rts NULL dereference
Date: Fri, 25 Mar 2011 20:49:22 +0000
Message-ID: <20110325204922.7ed9fd8c@lxorguk.ukuu.org.uk>
References: <4D8C7253.3040204@suse.cz>
	<1301049956-6933-1-git-send-email-jslaby@suse.cz>
	<20110325110040.6866d671@lxorguk.ukuu.org.uk>
	<4D8CAA0F.9040204@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:39508 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754157Ab1CYUs6 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 25 Mar 2011 16:48:58 -0400
In-Reply-To: <4D8CAA0F.9040204@suse.cz>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: Jiri Slaby <jirislaby@gmail.com>, gregkh@suse.de, linux-serial@vger.kernel.org

> > The uart helper layer assumes here (and a couple of other spots) that the
> > IRQ handler for the tty takes the port lock.
> 
> The oopsing path is through open BTW:
> -> uart_open
>  -> tty_port_block_til_ready
>   -> tty_port_raise_dtr_rts
>    -> uart_dtr_rts
> 
> > I think the *right* fix is probably to pass port not port->tty into the
> > helper in the first place but that seems to ripple into a lot of drivers.
> > 
> > (passing port->tty to things that then go tty->port is braindead and
> > causes half the mess in the tty/serial code)
> 
> I seem to miss the point. uart_update_termios needs tty, not port.


Actually I think it needs shooting having looked more closely

It does 3 things

1. It copies a flag across as part of a console hack. That should be done
elsewhere - eg in uart_startup

2. It sets the speed, which was already done by uart_startup

3. It goes poking around in the CBAUD flag before playing with DTR and
RTS which will have no effect as we *already* set the flags in
uart_dtr_rts

Am I missing something ?




