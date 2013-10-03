From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Commit f7d2c0bb (serial: i.MX: evaluate linux,stdout-path
 property) and resulting build errors
Date: Thu, 3 Oct 2013 11:44:45 -0700
Message-ID: <20131003184445.GH8901@kroah.com>
References: <20131003045611.GA17921@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:56283 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754593Ab3JCSo2 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 3 Oct 2013 14:44:28 -0400
Content-Disposition: inline
In-Reply-To: <20131003045611.GA17921@roeck-us.net>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-serial@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, Jiri Slaby <jslaby@suse.cz>

On Wed, Oct 02, 2013 at 09:56:11PM -0700, Guenter Roeck wrote:
> Hi all,
> 
> Commit f7d2c0bbdb (serial: i.MX: evaluate linux,stdout-path property) adds a
> call to add_preferred_console() into drivers/tty/serial/imx.c. The file can be
> built as module, yet add_preferred_console() is not exported on any platform.
> This is one reason why arm:allmodconfig fails to build on the upstream kernel.
> 
> What is the best solution ? Should imx.c not be buildable as module anymore ?

Sascha, I'll have to revert this patch unless you wish to fix it in a
different way?

thanks,

greg k-h
