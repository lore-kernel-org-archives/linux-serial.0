From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: Commit f7d2c0bb (serial: i.MX: evaluate linux,stdout-path
 property) and resulting build errors
Date: Sun, 6 Oct 2013 07:37:43 -0700
Message-ID: <20131006143743.GA23787@roeck-us.net>
References: <20131003045611.GA17921@roeck-us.net>
 <20131003184445.GH8901@kroah.com>
 <20131006110956.GM30088@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:39813 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752661Ab3JFOhu (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 6 Oct 2013 10:37:50 -0400
Received: by mail-pa0-f45.google.com with SMTP id rd3so6192712pab.32
        for <linux-serial@vger.kernel.org>; Sun, 06 Oct 2013 07:37:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20131006110956.GM30088@pengutronix.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>

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
> 
Difficult to imagine that a console driver can be a loadable module.
Unload it while the system is running and then what ?

Why does this driver have to be buildable as module anyway ? If that is really
a MUST, an alternative might be to only call add_preferred_console() if it is not
built as module.

Guenter
