From: Tobias Klauser <tklauser@distanz.ch>
Subject: Re: [smatch stuff] altera_uart: inconsistent checks for null
Date: Sat, 19 Feb 2011 14:22:17 +0100
Message-ID: <20110219132217.GH759@distanz.ch>
References: <20110219093107.GC4384@bicker>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from symlink.to.noone.org ([85.10.207.172]:39507 "EHLO sym.noone.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752318Ab1BSNWT (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sat, 19 Feb 2011 08:22:19 -0500
Content-Disposition: inline
In-Reply-To: <20110219093107.GC4384@bicker>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Dan Carpenter <error27@gmail.com>
Cc: linux-serial@vger.kernel.org, nios2-dev@sopc.et.ntust.edu.tw

Hi Dan,

On 2011-02-19 at 10:31:07 +0100, Dan Carpenter <error27@gmail.com> wrote:
> Patch 2780ad42f5fe67 "tty: serial: altera_uart: Use port->regshift to
> store bus shift" added a NULL check for platp in altera_uart_probe() but
> not consistently through out the function.
> 
> drivers/tty/serial/altera_uart.c +553 altera_uart_probe(43)
> 	error: we previously assumed 'platp' could be null.
> 
>    545          if (platp)
>                    ^^^^^^^
> checked here.
> 
>    546                  port->regshift = platp->bus_shift;
>    547          else
>    548                  port->regshift = 0;
>    549
>    550          port->line = i;
>    551          port->type = PORT_ALTERA_UART;
>    552          port->iotype = SERIAL_IO_MEM;
>    553          port->uartclk = platp->uartclk;
>                                 ^^^^^^^
> potential NULL dereference?

Not at the moment, because everybody is using platform data at the
momenti, so platp should never be NULL. Still this is inconsistent and
shouldn't be there like this. The dereference on line 553 will go away
with the patch introducing device tree support to altera_uart [1].

[1] https://lkml.org/lkml/2011/2/18/100

>    554          port->ops = &altera_uart_ops;
> 
> I don't know the right way to address this.

I guess either Greg or Grant will take the above mentioned patch (it
depends on a commit in Grant's tree).

Or do you think we should fix this in another way until the patch is
merged?

Thanks a lot for pointing this out
Tobias
