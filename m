From: Dan Carpenter <error27@gmail.com>
Subject: Re: [smatch stuff] altera_uart: inconsistent checks for null
Date: Sat, 19 Feb 2011 17:02:05 +0300
Message-ID: <20110219140204.GE4384@bicker>
References: <20110219093107.GC4384@bicker>
 <20110219132217.GH759@distanz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-bw0-f52.google.com ([209.85.214.52]:42895 "EHLO
	mail-bw0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754385Ab1BSOHn (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 19 Feb 2011 09:07:43 -0500
Received: by bwz4 with SMTP id 4so4329783bwz.11
        for <linux-serial@vger.kernel.org>; Sat, 19 Feb 2011 06:07:41 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110219132217.GH759@distanz.ch>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Tobias Klauser <tklauser@distanz.ch>
Cc: linux-serial@vger.kernel.org, nios2-dev@sopc.et.ntust.edu.tw

On Sat, Feb 19, 2011 at 02:22:17PM +0100, Tobias Klauser wrote:
> Hi Dan,
> 
> On 2011-02-19 at 10:31:07 +0100, Dan Carpenter <error27@gmail.com> wrote:
> > Patch 2780ad42f5fe67 "tty: serial: altera_uart: Use port->regshift to
> > store bus shift" added a NULL check for platp in altera_uart_probe() but
> > not consistently through out the function.
> > 
> > drivers/tty/serial/altera_uart.c +553 altera_uart_probe(43)
> > 	error: we previously assumed 'platp' could be null.
> > 
> >    545          if (platp)
> >                    ^^^^^^^
> > checked here.
> > 
> >    546                  port->regshift = platp->bus_shift;
> >    547          else
> >    548                  port->regshift = 0;
> >    549
> >    550          port->line = i;
> >    551          port->type = PORT_ALTERA_UART;
> >    552          port->iotype = SERIAL_IO_MEM;
> >    553          port->uartclk = platp->uartclk;
> >                                 ^^^^^^^
> > potential NULL dereference?
> 
> Not at the moment, because everybody is using platform data at the
> momenti, so platp should never be NULL. Still this is inconsistent and
> shouldn't be there like this. The dereference on line 553 will go away
> with the patch introducing device tree support to altera_uart [1].
> 
> [1] https://lkml.org/lkml/2011/2/18/100
> 
> >    554          port->ops = &altera_uart_ops;
> > 
> > I don't know the right way to address this.
> 
> I guess either Greg or Grant will take the above mentioned patch (it
> depends on a commit in Grant's tree).
> 

Sounds good.

regards,
dan carpenter
