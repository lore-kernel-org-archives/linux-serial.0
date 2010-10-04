From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] serial8250: ratelimit "too much work" error
Date: Mon, 4 Oct 2010 15:21:02 -0700
Message-ID: <20101004152102.1e04f30a.akpm@linux-foundation.org>
References: <20101002110438.801F49D401B@zog.reactivated.net>
	<20101004145101.b28fdc0a.akpm@linux-foundation.org>
	<20101004150238.fbc1b6cf.akpm@linux-foundation.org>
	<1286230259.10512.81.camel@Joe-Laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:40048 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751560Ab0JDWVm (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 4 Oct 2010 18:21:42 -0400
In-Reply-To: <1286230259.10512.81.camel@Joe-Laptop>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: Daniel Drake <dsd@laptop.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, Greg KH <greg@kroah.com>

On Mon, 04 Oct 2010 15:10:59 -0700
Joe Perches <joe@perches.com> wrote:

> On Mon, 2010-10-04 at 15:02 -0700, Andrew Morton wrote:
> > On Mon, 4 Oct 2010 14:51:01 -0700
> > Andrew Morton <akpm@linux-foundation.org> wrote:
> > 
> > > someone stuck a
> > > DEFINE_RATELIMIT_STATE() in include/linux/kernel.h and it ain't defined
> > > anywhere.  Let me fix that up...
> > 
> > Well that's a PITA.  Can't include ratelimit.h into kernel.h because a)
> > it'll slow everyone's compiels down and b) ratelimit.h needs spinlock.h
> > which surely needs kernel.h.  Fixable by adding a new
> > printk_ratelimit.h and including that from 135 source files, blah.
> > 
> > I'll give up and pronounce that users of printk_ratelimited() need to
> > include ratelimit.h as well.
> 
> What I suggested several months ago was to move the
> macro definitions to ratelimit.h
> 
> http://lkml.org/lkml/2010/2/18/377
> 

That's a bit nasty because at present ratelimit.h is purely about
ratelimiting and knowns nothing about any of its clients.  At present
it has only one client (printk), but it could have more in the future!
