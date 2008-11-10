From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] serial/8250: fix uninitialized warnings
Date: Mon, 10 Nov 2008 14:30:39 -0800
Message-ID: <20081110143039.6f21fdc3.akpm@linux-foundation.org>
References: <20081105022353.7CB0.KOSAKI.MOTOHIRO@jp.fujitsu.com>
	<20081104174142.360a964a@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:48093 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754676AbYKJWaw (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 10 Nov 2008 17:30:52 -0500
In-Reply-To: <20081104174142.360a964a@lxorguk.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: kosaki.motohiro@jp.fujitsu.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 4 Nov 2008 17:41:42 +0000
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> On Wed, 5 Nov 2008 02:26:00 +0900 (JST)
> KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com> wrote:
> 
> > 
> > fix following warnings.
> > 
> > drivers/serial/8250.c: In function ___serial8250_shutdown___:
> > drivers/serial/8250.c:1612: warnings: ___i___ may be used uninitialized in this function
> 
> NAK
> 
> This is an incorrect compiler warning. It's also one that current gcc
> does not emit warnings for.
> 

That's a regression in current gcc, surely?

static void serial_unlink_irq_chain(struct uart_8250_port *up)
{
	struct irq_info *i;
	struct hlist_node *n;
	struct hlist_head *h;

	mutex_lock(&hash_mutex);

	h = &irq_lists[up->port.irq % NR_IRQ_HASH];

	hlist_for_each(n, h) {
		i = hlist_entry(n, struct irq_info, node);
		if (i->irq == up->port.irq)
			break;
	}

	BUG_ON(n == NULL);
	BUG_ON(i->head == NULL);


#define hlist_for_each(pos, head) \
	for (pos = (head)->first; pos && ({ prefetch(pos->next); 1; }); \
	     pos = pos->next)

hlist_for_each() can execute that loop zero times, in which case
serial_unlink_irq_chain will dereference an uninitialised variable.

Presumably the list shouldn't be empty at this stage, but this
is not particularly robust behaviour if that should happen..
