From: Haavard Skinnemoen <haavard.skinnemoen@atmel.com>
Subject: Re: [patch 2/3] atmel_serial might lose modem status change
Date: Wed, 14 Jan 2009 16:42:58 +0100
Message-ID: <20090114164258.6373db9d@hskinnemoen-d830>
References: <200901092217.n09MHfmS021131@imap1.linux-foundation.org>
	<20090112104202.5ea628f6@hskinnemoen-d830>
	<20090114.121339.118371076.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from nat-132.atmel.no ([80.232.32.132]:62510 "EHLO relay.atmel.no"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751268AbZANPpQ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 14 Jan 2009 10:45:16 -0500
In-Reply-To: <20090114.121339.118371076.nemoto@toshiba-tops.co.jp>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: akpm@linux-foundation.org, alan@lxorguk.ukuu.org.uk, linux-serial@vger.kernel.org, linux@bohmer.net, marc.pignat@hevs.ch, itai.levi.devel@gmail.com

Atsushi Nemoto wrote:
> > @@ -805,6 +805,9 @@ static int atmel_startup(struct uart_por
> >  	 */
> >  	UART_PUT_IDR(port, -1);
> > 
> > +	atmel_port->irq_status_prev = UART_GET_CSR(port);
> > +	atmel_port->irq_status = atmel_port->irq_status_prev;
> > +
> >  	/*
> >  	 * Allocate the IRQ
> >  	 */  
> 
> Looks correct for me too.  Then, what is preffered final fix?
> 
> Put irq_status initialization into my patch, or replace with Itai's
> patch?  These patch put initialization in another place.  Any comments
> for preferred place to fix?

I don't think it matters as long as it happens before the interrupts
are enabled. But it's probably enough to do it once ;-)

So the easiest solution is probably to drop your patch
(atmel_serial-might-lose-modem-status-change.patch) and keep Itai's
patch (atmel_serial-might-lose-modem-status-change-fix.patch).

Andrew, if it makes things easier, feel free to drop both patches and
I'll send you a new one.

Haavard
