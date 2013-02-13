From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] serial/arc-uart: Urgent DT related update
Date: Wed, 13 Feb 2013 08:38:33 -0800
Message-ID: <20130213163833.GA3465@kroah.com>
References: <201302090928.43929.arnd@arndb.de>
 <1360572101-12744-1-git-send-email-vgupta@synopsys.com>
 <511B88F8.6010907@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:63956 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759377Ab3BMQig (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 13 Feb 2013 11:38:36 -0500
Received: by mail-pa0-f46.google.com with SMTP id kp14so813640pab.33
        for <linux-serial@vger.kernel.org>; Wed, 13 Feb 2013 08:38:35 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <511B88F8.6010907@synopsys.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, Arnd Bergmann <arnd@arndb.de>, linux-serial@vger.kernel.org

On Wed, Feb 13, 2013 at 06:07:12PM +0530, Vineet Gupta wrote:
> On Monday 11 February 2013 02:11 PM, Vineet Gupta wrote:
> > Hi Greg,
> >
> > Here's an update to arc-uart driver given Grant's recent review comments.
> > As discussed in the thread, can you consider this a bug fix and apply to
> > tty-next for 3.9. If you don't, please let me know as the corresponding DT file
> > change would have to be to be seperately applied to arch/arc/boot/*.
> >
> > Patch is Based off linux-next of today.
> >
> > Thx,
> > -Vineet
> >
> > Vineet Gupta (1):
> >   serial/arc-uart: Miscll DT related updates (Grant's review comments)
> >
> >  .../devicetree/bindings/tty/serial/arc-uart.txt    |    4 ++--
> >  drivers/tty/serial/arc_uart.c                      |   10 ++++------
> >  2 files changed, 6 insertions(+), 8 deletions(-)
> >
> 
> Greg, I'm assuming this won't make into tty until 3.9-rc1 and hence I need to drop
> the platform patch from arc-next.

I've taken this now, it will be sent to Linus for 3.9-rc1.

thanks,

greg k-h
