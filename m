From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] serial: clps711x: reworked driver version
Date: Fri, 12 Oct 2012 03:34:06 +0900
Message-ID: <20121011183406.GC32470@kroah.com>
References: <1349970689-24198-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:49618 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759149Ab2JKSeN (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 11 Oct 2012 14:34:13 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so2028789pad.19
        for <linux-serial@vger.kernel.org>; Thu, 11 Oct 2012 11:34:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1349970689-24198-1-git-send-email-shc_work@mail.ru>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: linux-serial@vger.kernel.org, Alan Cox <alan@linux.intel.com>

On Thu, Oct 11, 2012 at 07:51:29PM +0400, Alexander Shiyan wrote:
> This patch presents reworked version of CLPS711X serial driver.
> The changes from the old version:
> - Driver converted to platform_device.
> - Using CPU clock subsystem for getting base UART speed, since CPU can run
>   on different speeds.
> - Remove console_initcall and make console dynamically. Earler messages in
>   this case can be retrieved by using "earlyprintk" kernel option.
> - Using resource-managed functions (devm_xx).
> - Make all variables dynamically (reduce BSS).
> - Cleanup code & comments.

That's a lot of different things, all at once, making it very hard to
review.

Can you please break this up into the individual patches of what you are
doing above, one patch per thing, as is needed for Linux kernel patches?
That way it is much easier to accept and review.

thanks,

greg k-h
