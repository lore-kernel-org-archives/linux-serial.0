From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] serial: sc26xx: Fix compile breakage
Date: Wed, 1 Aug 2012 05:56:37 -0700
Message-ID: <20120801125637.GB3019@kroah.com>
References: <1343808020-26812-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:63415 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751809Ab2HAM4l (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 1 Aug 2012 08:56:41 -0400
Received: by yhmm54 with SMTP id m54so7236152yhm.19
        for <linux-serial@vger.kernel.org>; Wed, 01 Aug 2012 05:56:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1343808020-26812-1-git-send-email-shc_work@mail.ru>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: linux-serial@vger.kernel.org, Alan Cox <alan@linux.intel.com>

On Wed, Aug 01, 2012 at 12:00:20PM +0400, Alexander Shiyan wrote:
> This patch fixes the following compile breakage:
> 
>   CC      drivers/tty/serial/sc26xx.o
> drivers/tty/serial/sc26xx.c: In function 'read_sc_port':
> drivers/tty/serial/sc26xx.c:100: error: implicit declaration of function 'readb'
> drivers/tty/serial/sc26xx.c: In function 'write_sc_port':
> drivers/tty/serial/sc26xx.c:105: error: implicit declaration of function 'writeb'
> drivers/tty/serial/sc26xx.c: In function 'sc26xx_probe':
> drivers/tty/serial/sc26xx.c:652: error: implicit declaration of function 'ioremap_nocache'
> drivers/tty/serial/sc26xx.c:652: warning: assignment makes pointer from integer without a cast
> make[3]: *** [drivers/tty/serial/sc26xx.o] Error 1
> make[2]: *** [drivers/tty/serial] Error 2
> make[1]: *** [drivers/tty] Error 2
> make: *** [drivers] Error 2

Breakage in what tree?  What caused this to break?

greg k-h
