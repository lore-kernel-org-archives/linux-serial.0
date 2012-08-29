From: Alexander Shiyan <shc_work@mail.ru>
Subject: Re: [PATCH 1/2] serial: New serial driver SCCNXP
Date: Wed, 29 Aug 2012 22:26:42 +0400
Message-ID: <20120829222642.bae75223.shc_work@mail.ru>
References: <1345908260-6948-1-git-send-email-shc_work@mail.ru>
	<20120829144607.5cad63e2@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp26.mail.ru ([94.100.176.179]:33742 "EHLO smtp26.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753324Ab2H2SYz (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 29 Aug 2012 14:24:55 -0400
In-Reply-To: <20120829144607.5cad63e2@pyramind.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-serial@vger.kernel.org, Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

On Wed, 29 Aug 2012 14:46:07 +0100
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

Thanks for review.

> > +	baud = uart_get_baud_rate(port, termios, old, 50,
> > +				  (s->flags & SCCNXP_HAVE_MR0) ?
> > +				  230400 : 38400);
> > +	sccnxp_set_baud(port, baud);
> You should also write the *actal* baud rate you end up with back into
> termios unless B0 is requested (see 8250.c for an example). The tty core
> code will deal with minor variations and the detail for you (eg a user
> asking for B9600 and getting 9605 will be told they got their baud rate
> as asked)

And AFAIK uart_get_baud_rate cannot return 0 for us, so check for zero baud
is not needed before call tty_termios_encode_baud_rate. Right?

-- 
Alexander Shiyan <shc_work@mail.ru>
