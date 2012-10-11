From: Alexander Shiyan <shc_work@mail.ru>
Subject: Re: [PATCH] serial: clps711x: reworked driver version
Date: Thu, 11 Oct 2012 22:57:03 +0400
Message-ID: <20121011225703.3f930bf1.shc_work@mail.ru>
References: <1349970689-24198-1-git-send-email-shc_work@mail.ru>
	<20121011183406.GC32470@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp28.mail.ru ([94.100.176.181]:37206 "EHLO smtp28.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759185Ab2JKS5I (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 11 Oct 2012 14:57:08 -0400
In-Reply-To: <20121011183406.GC32470@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, Alan Cox <alan@linux.intel.com>

On Fri, 12 Oct 2012 03:34:06 +0900
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> On Thu, Oct 11, 2012 at 07:51:29PM +0400, Alexander Shiyan wrote:
> > This patch presents reworked version of CLPS711X serial driver.
> > The changes from the old version:
> > - Driver converted to platform_device.
> > - Using CPU clock subsystem for getting base UART speed, since CPU can run
> >   on different speeds.
> > - Remove console_initcall and make console dynamically. Earler messages in
> >   this case can be retrieved by using "earlyprintk" kernel option.
> > - Using resource-managed functions (devm_xx).
> > - Make all variables dynamically (reduce BSS).
> > - Cleanup code & comments.
> 
> That's a lot of different things, all at once, making it very hard to
> review.
> Can you please break this up into the individual patches of what you are
> doing above, one patch per thing, as is needed for Linux kernel patches?
> That way it is much easier to accept and review.

It's too hard to do, since each modification depends on the other...
Maybe make a patch through renaming, for example clps711x_uart? Or you
still insist to split it into separate patches?

-- 
Alexander Shiyan <shc_work@mail.ru>
