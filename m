From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] drivers/isdn/gigaset: new M101 driver
Date: Sun, 4 Feb 2007 20:58:17 -0800
Message-ID: <20070204205817.fe686375.akpm@linux-foundation.org>
References: <200702012112.l11LCOO4016557@lx1.pxnet.com>
	<20070201171345.bd98ce30.akpm@osdl.org>
	<45C537B9.7080704@imap.cc>
	<20070203175623.72a171a1.akpm@linux-foundation.org>
	<45C68B71.6050904@imap.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.24]:59404 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752704AbXBEE6j (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sun, 4 Feb 2007 23:58:39 -0500
In-Reply-To: <45C68B71.6050904@imap.cc>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Tilman Schmidt <tilman@imap.cc>
Cc: Karsten Keil <kkeil@suse.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, i4ldeveloper@listserv.isdn4linux.de, linux-serial@vger.kernel.org, Hansjoerg Lipp <hjlipp@web.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Greg KH <greg@kroah.com>

On Mon, 05 Feb 2007 02:42:09 +0100 Tilman Schmidt <tilman@imap.cc> wrote:

> Am 04.02.2007 02:56 schrieb Andrew Morton:
> > On Sun, 04 Feb 2007 02:32:41 +0100 Tilman Schmidt <tilman@imap.cc> wrote:
> > 
> >>>> +	spin_lock_irqsave(&cs->cmdlock, flags);
> >>>> +	cb = cs->cmdbuf;
> >>>> +	spin_unlock_irqrestore(&cs->cmdlock, flags);
> >>> It is doubtful if the locking here does anything useful.
> >> It assures atomicity when reading the cs->cmdbuf pointer.
> > 
> > I think it's bogus.  If the quantity being copied here is more than 32-bits
> > then yes, a lock is appropriate.  But if it's a single word then it's
> > unlikely that the locking does anything useful.  Or there might be a bug
> > here.
> 
> It's a pointer. Are reads and writes of pointer sized objects
> guaranteed to be atomic on every platform?

Yup - we make the same assumption about longs in various places.

It's a bit strange to read a pointer which can be changing at the
same time.  Because the local copy will no longer represent the
thing which it was just copied from.
