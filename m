From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Commit f7d2c0bb (serial: i.MX: evaluate linux,stdout-path
 property) and resulting build errors
Date: Sun, 6 Oct 2013 06:42:21 -0700
Message-ID: <20131006134221.GA4706@kroah.com>
References: <20131003045611.GA17921@roeck-us.net>
 <20131003184445.GH8901@kroah.com>
 <20131006110956.GM30088@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:48116 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752647Ab3JFNoj (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 6 Oct 2013 09:44:39 -0400
Content-Disposition: inline
In-Reply-To: <20131006110956.GM30088@pengutronix.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Guenter Roeck <linux@roeck-us.net>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>

On Sun, Oct 06, 2013 at 01:09:56PM +0200, Sascha Hauer wrote:
> On Thu, Oct 03, 2013 at 11:44:45AM -0700, Greg Kroah-Hartman wrote:
> > On Wed, Oct 02, 2013 at 09:56:11PM -0700, Guenter Roeck wrote:
> > > Hi all,
> > > 
> > > Commit f7d2c0bbdb (serial: i.MX: evaluate linux,stdout-path property) adds a
> > > call to add_preferred_console() into drivers/tty/serial/imx.c. The file can be
> > > built as module, yet add_preferred_console() is not exported on any platform.
> > > This is one reason why arm:allmodconfig fails to build on the upstream kernel.
> > > 
> > > What is the best solution ? Should imx.c not be buildable as module anymore ?
> > 
> > Sascha, I'll have to revert this patch unless you wish to fix it in a
> > different way?
> 
> Do you think exporting add_preferred_console() would be acceptable? If
> yes, that would be my preferred solution.

I don't think so, as odds are, it's not the correct solution otherwise
other drivers would have done it by now.

So, I think you are doing something wrong here...
