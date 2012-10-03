From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] tty/serial/8250: Make omap hardware workarounds local
 to 8250.h
Date: Wed, 3 Oct 2012 16:51:58 -0700
Message-ID: <20121003235157.GN4840@atomide.com>
References: <20121003223158.GL4840@atomide.com>
 <20121003232547.GD14392@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:39408 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933038Ab2JCXwA (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 3 Oct 2012 19:52:00 -0400
Content-Disposition: inline
In-Reply-To: <20121003232547.GD14392@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, Alan Cox <alan@linux.intel.com>

* Greg Kroah-Hartman <gregkh@linuxfoundation.org> [121003 16:27]:
> On Wed, Oct 03, 2012 at 03:31:58PM -0700, Tony Lindgren wrote:
> > This allows us to get rid of the ifdefs in 8250.c.
> > 
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Alan Cox <alan@linux.intel.com>
> > Cc: linux-serial@vger.kernel.org
> > Cc: linux-omap@vger.kernel.org
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > 
> > ---
> > 
> > Would appreciate some minimal immutable branch
> > with this commit that I can also pull in to my
> > upcoming omap cleanup branch for v3.8 merge window
> > as I'll be moving plat/serial.h for the ARM common
> > zImage changes.
> 
> Please wait for 3.7-rc1 to come out before I can do that.

OK thanks, rc1 is what I'm waiting for as well before
I apply my series.

Regards,

Tony
