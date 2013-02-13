From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 8/9] pps: Use a single cdev
Date: Wed, 13 Feb 2013 10:47:00 -0800
Message-ID: <20130213184700.GA15633@kroah.com>
References: <20130213182026.GA3996@kroah.com>
 <20130213183529.27043.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-da0-f44.google.com ([209.85.210.44]:48603 "EHLO
	mail-da0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753767Ab3BMSrH (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 13 Feb 2013 13:47:07 -0500
Received: by mail-da0-f44.google.com with SMTP id z20so687161dae.3
        for <linux-serial@vger.kernel.org>; Wed, 13 Feb 2013 10:47:07 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20130213183529.27043.qmail@science.horizon.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: George Spelvin <linux@horizon.com>
Cc: giometti@linux.it, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, peter@hurleysoftware.com

On Wed, Feb 13, 2013 at 01:35:29PM -0500, George Spelvin wrote:
> > You forgot a Signed-off-by: line for this patch, so I can't apply it, or
> > the 9/9 patch :(
> 
> Oops, fixed.  I don't see why the 9/9 patch depends on it,
> though.  They're not related or interdependent in any way.
> 
> If you want to check the logic, I'd appreciate it.  I'm not
> really sure about the RCU stuff.  My understanding is that:
> - the idr code does the appropriate write locking when
>   modifying itself, so I don't need to do any.
> - The pps_device returned from idr_find is itself refcounted,
>   so it can't go away, and the accesses don't have bo be
>   inside the RCU read "lock".  It's only the IDR's internal
>   index nodes that might get reallocated by modificaitons of
>   a different part of the tree.
> 
> > Care to resend just these two after fixing this up?
> 
> I can, but if you think you need 9/9 resent (which *did* have a S-o-b),
> I'm confused and wonder why...

I stopped at that point in the series, that's the only reason why, I
didn't "check" to see if there was a dependancy, I just assumed there
was...

So please resend, thanks.

greg k-h
