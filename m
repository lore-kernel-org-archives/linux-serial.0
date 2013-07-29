From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] serial: max310x: Fix dev_pm_ops
Date: Mon, 29 Jul 2013 12:34:20 -0700
Message-ID: <20130729193420.GA30737@kroah.com>
References: <1375111652-17436-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:58671 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751410Ab3G2TeW (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 29 Jul 2013 15:34:22 -0400
Content-Disposition: inline
In-Reply-To: <1375111652-17436-1-git-send-email-shc_work@mail.ru>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>

On Mon, Jul 29, 2013 at 07:27:32PM +0400, Alexander Shiyan wrote:
> This patch fixes wrong dev_pm_ops which caused by commit:
> serial: max310x: Driver rework.
> 
>   CC      drivers/tty/serial/max310x.o
>   LD      drivers/video/fb.o
>   CC      drivers/w1/slaves/w1_ds2433.o
>   CC      drivers/w1/slaves/w1_ds2760.o
>   CC      drivers/xen/balloon.o
>   CC      drivers/video/backlight/adp8870_bl.o
> drivers/tty/serial/max310x.c:1292:8: warning: initialization from incompatible pointer type [enabled by default]
> drivers/tty/serial/max310x.c:1292:8: warning: (near initialization for 'max310x_pm_ops.suspend') [enabled by default]
> drivers/tty/serial/max310x.c:1292:8: warning: initialization from incompatible pointer type [enabled by default]
> drivers/tty/serial/max310x.c:1292:8: warning: (near initialization for 'max310x_pm_ops.resume') [enabled by default]
> drivers/tty/serial/max310x.c:1292:8: warning: initialization from incompatible pointer type [enabled by default]
> drivers/tty/serial/max310x.c:1292:8: warning: (near initialization for 'max310x_pm_ops.freeze') [enabled by default]
> drivers/tty/serial/max310x.c:1292:8: warning: initialization from incompatible pointer type [enabled by default]
> drivers/tty/serial/max310x.c:1292:8: warning: (near initialization for 'max310x_pm_ops.thaw') [enabled by default]
> drivers/tty/serial/max310x.c:1292:8: warning: initialization from incompatible pointer type [enabled by default]
> drivers/tty/serial/max310x.c:1292:8: warning: (near initialization for 'max310x_pm_ops.poweroff') [enabled by default]
> drivers/tty/serial/max310x.c:1292:8: warning: initialization from incompatible pointer type [enabled by default]
> drivers/tty/serial/max310x.c:1292:8: warning: (near initialization for 'max310x_pm_ops.restore') [enabled by default]
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>

You forgot to put in the "Reported-by:" line saying who told you about
this problem...

I'll go do it this time, but in the future, please be more careful.

thanks,

greg k-h
