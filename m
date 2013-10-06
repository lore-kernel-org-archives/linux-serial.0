From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: Commit f7d2c0bb (serial: i.MX: evaluate linux,stdout-path
 property) and resulting build errors
Date: Sun, 6 Oct 2013 13:09:56 +0200
Message-ID: <20131006110956.GM30088@pengutronix.de>
References: <20131003045611.GA17921@roeck-us.net>
 <20131003184445.GH8901@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:45055 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751618Ab3JFLKC (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 6 Oct 2013 07:10:02 -0400
Content-Disposition: inline
In-Reply-To: <20131003184445.GH8901@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Guenter Roeck <linux@roeck-us.net>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>

On Thu, Oct 03, 2013 at 11:44:45AM -0700, Greg Kroah-Hartman wrote:
> On Wed, Oct 02, 2013 at 09:56:11PM -0700, Guenter Roeck wrote:
> > Hi all,
> > 
> > Commit f7d2c0bbdb (serial: i.MX: evaluate linux,stdout-path property) adds a
> > call to add_preferred_console() into drivers/tty/serial/imx.c. The file can be
> > built as module, yet add_preferred_console() is not exported on any platform.
> > This is one reason why arm:allmodconfig fails to build on the upstream kernel.
> > 
> > What is the best solution ? Should imx.c not be buildable as module anymore ?
> 
> Sascha, I'll have to revert this patch unless you wish to fix it in a
> different way?

Do you think exporting add_preferred_console() would be acceptable? If
yes, that would be my preferred solution.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
