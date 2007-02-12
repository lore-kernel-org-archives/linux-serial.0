From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] drivers/isdn/gigaset: new M101 driver
Date: Mon, 12 Feb 2007 10:47:12 -0800
Message-ID: <20070212184712.GC32607@kroah.com>
References: <200702012112.l11LCOO4016557@lx1.pxnet.com> <20070201171345.bd98ce30.akpm@osdl.org> <20070203160932.GA32523@kroah.com> <45C52848.50705@imap.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:59002 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965300AbXBLSs2 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 12 Feb 2007 13:48:28 -0500
Content-Disposition: inline
In-Reply-To: <45C52848.50705@imap.cc>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Tilman Schmidt <tilman@imap.cc>
Cc: Andrew Morton <akpm@linux-foundation.org>, Karsten Keil <kkeil@suse.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, i4ldeveloper@listserv.isdn4linux.de, linux-serial@vger.kernel.org, Hansjoerg Lipp <hjlipp@web.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>

On Sun, Feb 04, 2007 at 01:26:48AM +0100, Tilman Schmidt wrote:
> Am 03.02.2007 17:09 schrieb Greg KH:
> > On Thu, Feb 01, 2007 at 05:13:45PM -0800, Andrew Morton wrote:
> >>> +/* dummy to shut up framework warning */
> >>> +static void gigaset_device_release(struct device *dev)
> >>> +{
> >>> +	//FIXME anything to do? cf. platform_device_release()
> >>> +}
> >> Ask Greg ;)
> > 
> > Oh come on people.  Don't provide an empty function because the kernel
> > is complaining that you don't provide a release function.  Yes it will
> > shut the kernel up but did you ever think _why_ the kernel was
> > complaining?
> 
> Actually, I did. Just guess how that FIXME came to be.
> Hint: the kernel shuts up just as well without it.

Sure, but only because I can't do a test for a function pointer that
points to a function that does nothing :(

> > You need to free your memory here, don't just provide an empty function,
> > that shows the driver is broken.
> 
> Call me silly and incapable of thinking, but to me it's far from
> clear _what_ memory I am supposed to free there. Certainly neither
> memory I will still be needing after platform_device_unregister()
> nor memory that's being taken care of elsewhere. Between the two,
> in my case there's nothing left, so the release function is empty.
> If that shows my driver is broken, please explain in what way.

The memory of the platform device itself needs to be freed here,
otherwise, to do it earlier would cause race conditions and oopses.
Look at how the other platform drivers do things.

thanks,

greg k-h
