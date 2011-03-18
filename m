From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] MAINTAINERS: Add serial
Date: Fri, 18 Mar 2011 13:00:54 -0700
Message-ID: <20110318200054.GA4311@kroah.com>
References: <20110318135612.10011.56387.stgit@bob.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:54755 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756191Ab1CRUBC (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 18 Mar 2011 16:01:02 -0400
Content-Disposition: inline
In-Reply-To: <20110318135612.10011.56387.stgit@bob.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-serial@vger.kernel.org, torvalds@linux-foundation.org, s.hauer@pengutronix.de

On Fri, Mar 18, 2011 at 01:56:14PM +0000, Alan Cox wrote:
> From: Alan Cox <alan@linux.intel.com>
> 
> Add an entry for serial maintainers. 
> 
> Signed-off-by: Alan Cox <alan@linux.intel.com>
> ---
> 
>  MAINTAINERS |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
> 
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2b9de57..94e8951 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5405,6 +5405,12 @@ L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
>  S:	Supported
>  F:	sound/soc/samsung
>  
> +SERIAL DRIVERS
> +M:	Alan Cox <alan@linux.intel.com>
> +L:	linux-serial@vger.kernel.org
> +S:	Maintained
> +F:	drivers/tty/serial

Nice, does this mean you can take my name off of the 8250 driver?  No
complaint from me :)

You should also adjust the F: field in the tty maintainer entry as well
as I think you want to handle some of those files as well, right?

thanks,

greg k-h
