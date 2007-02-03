From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] drivers/isdn/gigaset: new M101 driver
Date: Sat, 3 Feb 2007 08:09:32 -0800
Message-ID: <20070203160932.GA32523@kroah.com>
References: <200702012112.l11LCOO4016557@lx1.pxnet.com> <20070201171345.bd98ce30.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:33094 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946481AbXBCQKq (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sat, 3 Feb 2007 11:10:46 -0500
Content-Disposition: inline
In-Reply-To: <20070201171345.bd98ce30.akpm@osdl.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Tilman Schmidt <tilman@imap.cc>, Karsten Keil <kkeil@suse.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, i4ldeveloper@listserv.isdn4linux.de, linux-serial@vger.kernel.org, Hansjoerg Lipp <hjlipp@web.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>

On Thu, Feb 01, 2007 at 05:13:45PM -0800, Andrew Morton wrote:
> > +/* dummy to shut up framework warning */
> > +static void gigaset_device_release(struct device *dev)
> > +{
> > +	//FIXME anything to do? cf. platform_device_release()
> > +}
> 
> Ask Greg ;)

Oh come on people.  Don't provide an empty function because the kernel
is complaining that you don't provide a release function.  Yes it will
shut the kernel up but did you ever think _why_ the kernel was
complaining?  Did you think it did it just for fun?

Think people, think...

You need to free your memory here, don't just provide an empty function,
that shows the driver is broken.

thanks,

greg k-h
