From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: tty_flip_buffer() from atomic context when low_latency==1
Date: Fri, 19 Aug 2011 21:24:16 +0100
Message-ID: <20110819212416.6f626852@lxorguk.ukuu.org.uk>
References: <j2med6$q2r$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:51349 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755253Ab1HSUZi (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 19 Aug 2011 16:25:38 -0400
In-Reply-To: <j2med6$q2r$1@dough.gmane.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Grant Edwards <grant.b.edwards@gmail.com>
Cc: linux-serial@vger.kernel.org

> But, many drivers appear to call tty_flip_buffer_push() from an atomic
> context. If that is done with tty->low_latency==1 it turns into a call
> to flush_to_ldisc(), which then calls disc->ops->receive_buf(), which
> must not be called from an atomic context.

It's covered under "So don't do that then".

> Is the low_latency flag being forced to 0 somewhere behind the scenes
> when tty_flip_buffer_push() is being called from an atomic context?

No. The driver authors are assumed to have a modicum of competence and if
they don't usually a shower of lock debug messages enlightens
appropriately.

Alan
