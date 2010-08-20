From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/2] serial: 8250: Initialize pointer to irq_info
Date: Fri, 20 Aug 2010 11:31:25 +0100
Message-ID: <20100820113125.6d7b498f@lxorguk.ukuu.org.uk>
References: <1282031947-16483-1-git-send-email-monstr@monstr.eu>
	<20100817091720.56183993@linux.intel.com>
	<20100819164354.09e30dc9.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:53837 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751499Ab0HTKQ0 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 20 Aug 2010 06:16:26 -0400
In-Reply-To: <20100819164354.09e30dc9.akpm@linux-foundation.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alan Cox <alan@linux.intel.com>, Michal Simek <monstr@monstr.eu>, michal.simek@petalogix.com, Greg Kroah-Hartman <gregkh@suse.de>, Ralf Baechle <ralf@linux-mips.org>, Manuel Lauss <manuel.lauss@googlemail.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

> > Use a newer compiler - modern ones get this right.
> 
> : static void serial_unlink_irq_chain(struct uart_8250_port *up)
> : {
> : 	struct irq_info *i;
> : 	struct hlist_node *n;
> : 	struct hlist_head *h;
> : 
> : 	mutex_lock(&hash_mutex);
> : 
> : 	h = &irq_lists[up->port.irq % NR_IRQ_HASH];
> : 
> : 	hlist_for_each(n, h) {
> : 		i = hlist_entry(n, struct irq_info, node);
> : 		if (i->irq == up->port.irq)
> : 			break;
> : 	}
> : 
> : 	BUG_ON(n == NULL);
> : 	BUG_ON(i->head == NULL);
> 
> How can any compiler possibly determine that the hlist_for_each() is
> never executed zero times?

We had this argument was it two years ago ?

Modern gcc is capable of at least working out it can't work it out and
doesn't emit a spurious warning.

