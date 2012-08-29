From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/2] serial: New serial driver SCCNXP
Date: Wed, 29 Aug 2012 21:15:38 +0100
Message-ID: <20120829211538.1a9c972a@pyramind.ukuu.org.uk>
References: <1345908260-6948-1-git-send-email-shc_work@mail.ru>
	<20120829144607.5cad63e2@pyramind.ukuu.org.uk>
	<20120829222642.bae75223.shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:37244 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751021Ab2H2ULD (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 29 Aug 2012 16:11:03 -0400
In-Reply-To: <20120829222642.bae75223.shc_work@mail.ru>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: linux-serial@vger.kernel.org, Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

On Wed, 29 Aug 2012 22:26:42 +0400
Alexander Shiyan <shc_work@mail.ru> wrote:

> On Wed, 29 Aug 2012 14:46:07 +0100
> Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> 
> Thanks for review.
> 
> > > +	baud = uart_get_baud_rate(port, termios, old, 50,
> > > +				  (s->flags & SCCNXP_HAVE_MR0) ?
> > > +				  230400 : 38400);
> > > +	sccnxp_set_baud(port, baud);
> > You should also write the *actal* baud rate you end up with back into
> > termios unless B0 is requested (see 8250.c for an example). The tty core
> > code will deal with minor variations and the detail for you (eg a user
> > asking for B9600 and getting 9605 will be told they got their baud rate
> > as asked)
> 
> And AFAIK uart_get_baud_rate cannot return 0 for us, so check for zero baud
> is not needed before call tty_termios_encode_baud_rate. Right?

B0 is a bit weird. A request for 0 baud means "hang up" not "change the
speed". So the check is needed really.
