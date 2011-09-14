From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: close() handler of tty driver called for port that's not open?
Date: Wed, 14 Sep 2011 21:05:43 +0100
Message-ID: <20110914210543.6b35de4e@lxorguk.ukuu.org.uk>
References: <j4qk9f$vro$1@dough.gmane.org>
	<20110914203353.08c715af@lxorguk.ukuu.org.uk>
	<j4r0mr$veq$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:50394 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933140Ab1INUGU (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 14 Sep 2011 16:06:20 -0400
In-Reply-To: <j4r0mr$veq$1@dough.gmane.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Grant Edwards <grant.b.edwards@gmail.com>
Cc: linux-serial@vger.kernel.org

> In my mind, a port was only open after my open() handler returns
> success.  I guess that's wrong, and I should increment my use counter
> unconditionally each time my open() handler is called.

Probably - and remember to allow for hangup.

> customers are running kernels recent enough to have those helpers. I
> suppose I could look into writing compatibility versions compatible
> with the range of kernels I have to support.

It's actually pretty independant of the underlying tty code so may well
backport quite easily although it does touch on the refcounting stuff a
bit I guess.

> The problem is how to make a driver written that way work for somebody
> running a 2.4 kernel (or even a not-very-recent 2.6 kernel).  Yes, I
> have a few customers running 2.4 kernels, and lots of customers
> running older 2.6 kernels.  I _might_ be able to convince management
> it's time to drop support for 2.4, but there's no way I can abandon
> customers using 2.6 kernels.

For 2.4 I think you are on your own, but there are also no 2.4 kernels
without security holes so I tend to think of 2.4 as mostly dead.

In the 2.6 case the tty_port code depends upon the tty layer refcounting,
and the tty layer refcounting fixes exploitable races in tty hangup.

At a certainly point you may actually be best supporting both setups as
two driver variants. One for the kernels with old style lock_kernel
assumptions and the like, one for those where tty_port appears and we
relax the rest of the rules dramatically.

Alan
