From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: tty_flip_buffer() from atomic context when low_latency==1
Date: Fri, 19 Aug 2011 22:06:44 +0100
Message-ID: <20110819220644.3166083d@lxorguk.ukuu.org.uk>
References: <j2med6$q2r$1@dough.gmane.org>
	<20110819212416.6f626852@lxorguk.ukuu.org.uk>
	<j2mhva$nmv$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:48001 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752686Ab1HSVIG (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 19 Aug 2011 17:08:06 -0400
In-Reply-To: <j2mhva$nmv$1@dough.gmane.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Grant Edwards <grant.b.edwards@gmail.com>
Cc: linux-serial@vger.kernel.org

On Fri, 19 Aug 2011 20:44:26 +0000 (UTC)
Grant Edwards <grant.b.edwards@gmail.com> wrote:

> On 2011-08-19, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> 
> >> But, many drivers appear to call tty_flip_buffer_push() from an atomic
> >> context. If that is done with tty->low_latency==1 it turns into a call
> >> to flush_to_ldisc(), which then calls disc->ops->receive_buf(), which
> >> must not be called from an atomic context.
> >
> > It's covered under "So don't do that then".
> 
> I don't do that, and wasn't asking if I should.
> 
> My point was that most of the drivers in the linux kernels sources
> _do_ appear to do that, and I don't see how they avoid problems.
> 
> For exaple, 8250.c calls tty_flip_buffer_push() from receive_chars(),
> calld from serial8250_handle_port(), called from
> serial8250_interrupt().
> 
> How are problems avoided when tty->low_latency is set?
> 
> Is tty->low_latency never allowed to be set for the 8250 driver?

Several drivers certainly allow someone with superuser privileges to
misconfigure them. I've never worried about chasing all those down.

It might actually be worth supporting a tty->low_latency mode which uses
a tty layer private workqueue that is set to real time priority rather
than the system work queue.

Alan

