From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 8/9] tty : kill receive_room usage in mxser
Date: Mon, 5 Mar 2012 10:34:01 +0000
Message-ID: <20120305103401.17b3843f@pyramind.ukuu.org.uk>
References: <1330883960-8563-1-git-send-email-castet.matthieu@free.fr>
	<1330883960-8563-9-git-send-email-castet.matthieu@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:36737 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756418Ab2CEKcG (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 5 Mar 2012 05:32:06 -0500
In-Reply-To: <1330883960-8563-9-git-send-email-castet.matthieu@free.fr>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Matthieu CASTET <castet.matthieu@free.fr>
Cc: linux-serial@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Toby Gray <toby.gray@realvnc.com>, Stefan Bigler <stefan.bigler@keymile.com>

>  			ch = inb(port->ioaddr + UART_RX);
> -			tty_insert_flip_char(tty, ch, 0);
> +			ret = tty_insert_flip_char(tty, ch, 0);
> +			if (ret != 1) {
> +				if (!port->ldisc_stop_rx)
> +					mxser_stoprx(tty);
> +			}

This can all just go. The tty layer calls down for stop/start events and
the flow control handles it. There is enough asynchronous buffering to
handle the rest. Just insert them and honour stop/start. By the time
tty_insert_flip_char returns 0 you are in an out of memory/64K buffering
full *after* being told to stop situation.
