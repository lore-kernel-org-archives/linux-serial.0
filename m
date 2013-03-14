From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: linux-3.7.10: possible circular locking dependency detected:
 tty_lock_nested vs. process_one_work
Date: Thu, 14 Mar 2013 15:56:13 -0700
Message-ID: <20130314225613.GD11945@kroah.com>
References: <514100BE.6030601@fold.natur.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pb0-f50.google.com ([209.85.160.50]:50229 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753280Ab3CNW4Q (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 14 Mar 2013 18:56:16 -0400
Received: by mail-pb0-f50.google.com with SMTP id up1so2870497pbc.23
        for <linux-serial@vger.kernel.org>; Thu, 14 Mar 2013 15:56:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <514100BE.6030601@fold.natur.cuni.cz>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
Cc: linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>

On Wed, Mar 13, 2013 at 11:42:06PM +0100, Martin Mokrejs wrote:
> Hi,
>   I was running my laptop on batteries with pppd using /dev/ttyUSB0 with a 3G usb modem
> using the slow option serial driver but with pppd's 'debug nodetach'. pppd did not
> therefore detach from my shell but I did not care. ;-) While shutting down the whole
> system pppd exited but then ...a possible locking issue was reported. Much later
> pppd finally exited. Is the locking issue a false alarm or not?

This should be just fine, nothing to worry about, I think this is
already fixed in 3.9-rc1.

thanks,

greg k-h
