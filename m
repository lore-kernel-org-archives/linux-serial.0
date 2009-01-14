From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: [patch 2/3] atmel_serial might lose modem status change
Date: Wed, 14 Jan 2009 12:13:39 +0900 (JST)
Message-ID: <20090114.121339.118371076.nemoto@toshiba-tops.co.jp>
References: <200901092217.n09MHfmS021131@imap1.linux-foundation.org>
	<20090112104202.5ea628f6@hskinnemoen-d830>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from fwtops.0.225.230.202.in-addr.arpa ([202.230.225.126]:39929 "EHLO
	topsms.toshiba-tops.co.jp" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752848AbZANDqF (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 13 Jan 2009 22:46:05 -0500
In-Reply-To: <20090112104202.5ea628f6@hskinnemoen-d830>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: haavard.skinnemoen@atmel.com
Cc: akpm@linux-foundation.org, alan@lxorguk.ukuu.org.uk, linux-serial@vger.kernel.org, linux@bohmer.net, marc.pignat@hevs.ch, itai.levi.devel@gmail.com

On Mon, 12 Jan 2009 10:42:02 +0100, Haavard Skinnemoen <haavard.skinnemoen@atmel.com> wrote:
> > +++ a/drivers/serial/atmel_serial.c
> > @@ -877,6 +877,9 @@ static int atmel_startup(struct uart_por
> >  		}
> >  	}
> >  
> > +	/* Save current CSR for comparison in atmel_tasklet_func() */
> > +	atmel_port->irq_status_prev = UART_GET_CSR(port);
> > +
> 
> ...Itai Levi pointed out that we need to initialize
> atmel_port->irq_status as well here. His analysis is as follows:
> 
> > Regarding the second part of the patch (which resets irq_status_prev),
> > it turns out that both versions of the patch (mine and Atsushi's)
> > still leave enough room for faulty behavior when opening the port.
> > 
> > This is because we are not resetting both irq_status_prev and
> > irq_status in atmel_startup() to CSR, which leads faulty behavior in
> > the following sequences:
...

> @@ -805,6 +805,9 @@ static int atmel_startup(struct uart_por
>  	 */
>  	UART_PUT_IDR(port, -1);
> 
> +	atmel_port->irq_status_prev = UART_GET_CSR(port);
> +	atmel_port->irq_status = atmel_port->irq_status_prev;
> +
>  	/*
>  	 * Allocate the IRQ
>  	 */

Looks correct for me too.  Then, what is preffered final fix?

Put irq_status initialization into my patch, or replace with Itai's
patch?  These patch put initialization in another place.  Any comments
for preferred place to fix?

---
Atsushi Nemoto
