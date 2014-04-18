From: Greg KH <greg@kroah.com>
Subject: Re: How can I help?
Date: Fri, 18 Apr 2014 15:43:57 -0700
Message-ID: <20140418224357.GA32442@kroah.com>
References: <8A1E86F6-47F2-44A7-A8DB-8A643FE9796B@usgs.gov>
 <20140418220903.GA22429@kroah.com>
 <E4E661B3-7296-4666-8A59-D9D52BC3D6D0@usgs.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:52999 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752779AbaDRWnt (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 18 Apr 2014 18:43:49 -0400
Content-Disposition: inline
In-Reply-To: <E4E661B3-7296-4666-8A59-D9D52BC3D6D0@usgs.gov>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Larry Baker <baker@usgs.gov>
Cc: linux-serial@vger.kernel.org

On Fri, Apr 18, 2014 at 03:37:53PM -0700, Larry Baker wrote:
> Greg,
> 
> Any suggestions how to trace what is going on?

Going on with what?  Was there a bug report in that wall of text that I
missed?  :)

> I see all the tracing debug code has been removed in the latest
> ftdi_sio driver.

That's because the kernel provides tracing functionality built-in, no
need for it to be on a driver-by-driver basis.  Use it if you think it
is necessary.

> I think it will be easier to first try upgrading the kernel/drivers on
> the AtomPC, even though I want to run on an ARM SoC.  The ARM SoC I'm
> currently using requires some ARM ERRATA in the kernel; exactly which
> ones still seems to be a moving target.  As you say, the drivers
> should be architecture neutral.  If a fix for this problem can be
> found using an AtomPC, I am confident it will also apply to an ARM
> SoC.
> 
> The drivers I'm looking at are all in the usb/serial branch of the
> Linux kernel.  You recommend discussing this on the
> linux-usb@vger.kernel.org mailing list instead of this one?  CC this
> one?
> 
> What about my question of vendor supported vs. reverse engineered USB
> serial drivers.  If there is a chip with (better) vendor Linux driver
> support, I can complain to them and they can fix it instead of us.  If
> you were to buy a USB-to-Serial adapter, which chip would you buy?

I would buy an io_edgeport device, but they are really expensive, and no
longer in production from what I can tell.  Everything else are very
cheap devices, with questionable UART silicon.

In the end, it all depends on what you want to use the device for, some
are much better than others.

thanks,

greg k-h
