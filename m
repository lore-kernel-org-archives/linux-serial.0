From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/2] serial: New serial driver SCCNXP
Date: Wed, 29 Aug 2012 14:46:07 +0100
Message-ID: <20120829144607.5cad63e2@pyramind.ukuu.org.uk>
References: <1345908260-6948-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:36756 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753687Ab2H2Nla (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 29 Aug 2012 09:41:30 -0400
In-Reply-To: <1345908260-6948-1-git-send-email-shc_work@mail.ru>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: linux-serial@vger.kernel.org, Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>


> +	/* Mask termios capabilities we don't support */
> +	termios->c_cflag &= ~CMSPAR;
> +	termios->c_iflag &= ~(IXON | IXOFF | IXANY);

The kernel will handle IXON/IXOFF/IXANY in software if the hardware
doesn't do it so you only need the CMSPAR one.

> +	baud = uart_get_baud_rate(port, termios, old, 50,
> +				  (s->flags & SCCNXP_HAVE_MR0) ?
> +				  230400 : 38400);
> +	sccnxp_set_baud(port, baud);

You should also write the *actal* baud rate you end up with back into
termios unless B0 is requested (see 8250.c for an example). The tty core
code will deal with minor variations and the detail for you (eg a user
asking for B9600 and getting 9605 will be told they got their baud rate
as asked)


Looks good to me barring those trivial bits that can be fixed up with a
follow up patch

Acked-by: Alan Cox <alan@linux.intel.com>

