From: Alexander Shiyan <shc_work@mail.ru>
Subject: Re: [PATCH] serial: clps711x: reworked driver version
Date: Sun, 14 Oct 2012 11:05:00 +0400
Message-ID: <20121014110500.f81f5070d536274245aaca5c@mail.ru>
References: <1349970689-24198-1-git-send-email-shc_work@mail.ru>
	<20121011183406.GC32470@kroah.com>
	<20121011225703.3f930bf1.shc_work@mail.ru>
	<20121011192014.GB1801@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp5.mail.ru ([94.100.176.132]:41788 "EHLO smtp5.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751606Ab2JNHFI (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sun, 14 Oct 2012 03:05:08 -0400
In-Reply-To: <20121011192014.GB1801@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, Alan Cox <alan@linux.intel.com>

On Fri, 12 Oct 2012 04:20:14 +0900
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

...
> > > > This patch presents reworked version of CLPS711X serial driver.
> > > > The changes from the old version:
> > > > - Driver converted to platform_device.
> > > > - Using CPU clock subsystem for getting base UART speed, since CPU can run
> > > >   on different speeds.
> > > > - Remove console_initcall and make console dynamically. Earler messages in
> > > >   this case can be retrieved by using "earlyprintk" kernel option.
> > > > - Using resource-managed functions (devm_xx).
> > > > - Make all variables dynamically (reduce BSS).
> > > > - Cleanup code & comments.
> > > 
> > > That's a lot of different things, all at once, making it very hard to
> > > review.
> > > Can you please break this up into the individual patches of what you are
> > > doing above, one patch per thing, as is needed for Linux kernel patches?
> > > That way it is much easier to accept and review.
> > 
> > It's too hard to do, since each modification depends on the other...
> 
> That's why you do one patch after the other, a series of patches, all
> depending on the previous ones.
> 
> > Maybe make a patch through renaming, for example clps711x_uart? Or you
> > still insist to split it into separate patches?
> 
> Linux kernel development is all about individual patches, each one only
> doing one thing.  We've been doing this for 20+ years now, it's not
> anything "new" :)

Yes, this is understandable. This patch is the result of several years of work
with this driver. I tried to split into separate functional parts and send the
new version in a new thread. Please comment.

-- 
Alexander Shiyan <shc_work@mail.ru>
