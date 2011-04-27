From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH V3] tty/serial: add support for Xilinx PS UART
Date: Wed, 27 Apr 2011 10:33:40 +0100
Message-ID: <20110427103340.2554df83@lxorguk.ukuu.org.uk>
References: <381805170.1906645.1303859011392.JavaMail.root@sz0140a.emeryville.ca.mail.comcast.net>
	<549692800.1907368.1303859758362.JavaMail.root@sz0140a.emeryville.ca.mail.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:56188 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752001Ab1D0Jcp (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 27 Apr 2011 05:32:45 -0400
In-Reply-To: <549692800.1907368.1303859758362.JavaMail.root@sz0140a.emeryville.ca.mail.comcast.net>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: johnlinn@comcast.net
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, michal.simek@petalogix.com, joe@perches.com, grant.likely@secretlab.ca, greg@kroah.com

> I thought I was improving but now as I look at it further, that seems like it 
> was better and I should have stuck to that method.
> 
> Thoughts?

Go for nearest is the right behaviour. The whole tty layer works on that
basis as do soem other things. It means you don't have to have a set of
calls to do things like "enumerate valid data rates" instead you ask and
compare.

> > > +	uart_update_timeout(port, termios->c_cflag, baud);
> > 
> > [which would also fix this timeout!]
> 
> Maybe you were meaning that if the baud rate was not really set because of the
> error this timeout would be wrong also, and if so that makes sense.

Correct

Alan
