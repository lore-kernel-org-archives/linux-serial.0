From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] tty/serial/8250: Make omap hardware workarounds local to
 8250.h
Date: Wed, 24 Oct 2012 11:31:34 -0700
Message-ID: <20121024183134.GA18003@kroah.com>
References: <20121003223158.GL4840@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:49049 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964778Ab2JXSbh (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 24 Oct 2012 14:31:37 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so549593pad.19
        for <linux-serial@vger.kernel.org>; Wed, 24 Oct 2012 11:31:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20121003223158.GL4840@atomide.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-serial@vger.kernel.org, Alan Cox <alan@linux.intel.com>

On Wed, Oct 03, 2012 at 03:31:58PM -0700, Tony Lindgren wrote:
> This allows us to get rid of the ifdefs in 8250.c.
> 
> Cc: Alan Cox <alan@linux.intel.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> ---
> 
> Would appreciate some minimal immutable branch
> with this commit that I can also pull in to my
> upcoming omap cleanup branch for v3.8 merge window
> as I'll be moving plat/serial.h for the ARM common
> zImage changes.

This is now in my tty-next branch of the tty.git tree, if you want to
pull from that.

thanks,

greg k-h
