From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] serial: clps711x: reworked driver version
Date: Fri, 12 Oct 2012 04:20:14 +0900
Message-ID: <20121011192014.GB1801@kroah.com>
References: <1349970689-24198-1-git-send-email-shc_work@mail.ru>
 <20121011183406.GC32470@kroah.com>
 <20121011225703.3f930bf1.shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:38028 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756163Ab2JKTUV (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 11 Oct 2012 15:20:21 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so2166972pbb.19
        for <linux-serial@vger.kernel.org>; Thu, 11 Oct 2012 12:20:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20121011225703.3f930bf1.shc_work@mail.ru>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: linux-serial@vger.kernel.org, Alan Cox <alan@linux.intel.com>

On Thu, Oct 11, 2012 at 10:57:03PM +0400, Alexander Shiyan wrote:
> On Fri, 12 Oct 2012 03:34:06 +0900
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> 
> > On Thu, Oct 11, 2012 at 07:51:29PM +0400, Alexander Shiyan wrote:
> > > This patch presents reworked version of CLPS711X serial driver.
> > > The changes from the old version:
> > > - Driver converted to platform_device.
> > > - Using CPU clock subsystem for getting base UART speed, since CPU can run
> > >   on different speeds.
> > > - Remove console_initcall and make console dynamically. Earler messages in
> > >   this case can be retrieved by using "earlyprintk" kernel option.
> > > - Using resource-managed functions (devm_xx).
> > > - Make all variables dynamically (reduce BSS).
> > > - Cleanup code & comments.
> > 
> > That's a lot of different things, all at once, making it very hard to
> > review.
> > Can you please break this up into the individual patches of what you are
> > doing above, one patch per thing, as is needed for Linux kernel patches?
> > That way it is much easier to accept and review.
> 
> It's too hard to do, since each modification depends on the other...

That's why you do one patch after the other, a series of patches, all
depending on the previous ones.

> Maybe make a patch through renaming, for example clps711x_uart? Or you
> still insist to split it into separate patches?

Linux kernel development is all about individual patches, each one only
doing one thing.  We've been doing this for 20+ years now, it's not
anything "new" :)

thanks,

greg k-h
