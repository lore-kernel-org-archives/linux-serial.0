From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH V2 1/2] serial: ralink: adds support for the serial core
 found on ralink wisoc
Date: Fri, 25 Jan 2013 08:58:06 -0800
Message-ID: <20130125165806.GA16911@kroah.com>
References: <1359121440-14266-1-git-send-email-blogic@openwrt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:39761 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756725Ab3AYQ6I (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 25 Jan 2013 11:58:08 -0500
Received: by mail-pa0-f42.google.com with SMTP id rl6so366517pac.29
        for <linux-serial@vger.kernel.org>; Fri, 25 Jan 2013 08:58:08 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1359121440-14266-1-git-send-email-blogic@openwrt.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: John Crispin <blogic@openwrt.org>
Cc: linux-serial@vger.kernel.org, linux-mips@linux-mips.org

On Fri, Jan 25, 2013 at 02:44:00PM +0100, John Crispin wrote:
> The MIPS based Ralink WiSoC platform has 1 or more 8250 compatible serial cores.
> To make them work we require the same quirks that are used by AU1x00.
> 
> Signed-off-by: John Crispin <blogic@openwrt.org>
> ---
> Changes in V2
> * adds missing "/" in source code comment
> 
>  drivers/tty/serial/8250/8250.c  |    6 +++---
>  drivers/tty/serial/8250/Kconfig |    8 ++++++++
>  include/linux/serial_core.h     |    2 +-
>  3 files changed, 12 insertions(+), 4 deletions(-)

What tree did you make this against?  I can't apply it to my tty-next
one, so I can't take this series.  Care to refresh it and resend it?

thanks,

greg k-h
