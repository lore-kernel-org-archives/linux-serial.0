From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/9] tty: make receive_buf() return the amout of bytes
 received
Date: Mon, 5 Mar 2012 10:40:29 +0000
Message-ID: <20120305104029.262908cc@pyramind.ukuu.org.uk>
References: <1330883960-8563-1-git-send-email-castet.matthieu@free.fr>
	<1330883960-8563-2-git-send-email-castet.matthieu@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:53169 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756473Ab2CEKim (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 5 Mar 2012 05:38:42 -0500
In-Reply-To: <1330883960-8563-2-git-send-email-castet.matthieu@free.fr>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Matthieu CASTET <castet.matthieu@free.fr>
Cc: linux-serial@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Toby Gray <toby.gray@realvnc.com>, Stefan Bigler <stefan.bigler@keymile.com>

> For a first step, will always return that we received everything.
> This make sure to we don't break anything when we will check receive_buf
> return value.


What about recursive calls ? We have some of those due to bugs elsewhere
in the code - eg selection.c. I don't wish to throw spanners in the works
of this effort but you can't actually make it work until you fix

selection.c
tty_io.c: tiocsti
n_tty: n_tty_set_room

The first two are unsafe recursive calls, the third one is totally broken
on any port with low latency set and can result in all kinds of
interesting failure cases.

Basically you've got to actually address the fact that code is calling
the ldisc methods wrongly, in parallel, without locking, and in an unsafe
fashion that in some cases can arbitarily recurse.

Until that is done you are never going to be able to debug the changes
because it'll crash anyway if you poke it the right way.

Alan
