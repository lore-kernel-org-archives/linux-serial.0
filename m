Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB06C433EF
	for <linux-serial@archiver.kernel.org>; Thu, 21 Oct 2021 08:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CAF960FC0
	for <linux-serial@archiver.kernel.org>; Thu, 21 Oct 2021 08:28:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbhJUIay (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 21 Oct 2021 04:30:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:53768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231153AbhJUIax (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 21 Oct 2021 04:30:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7D3C961056;
        Thu, 21 Oct 2021 08:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1634804918;
        bh=qjew/QfPbYGCt0Lvs5YNdF5HsyJTr8BpEPVo9iVlsiM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n8CMxxM+z2Mrc7OS5nclcrmdVvyTyvZ/dZJcsoz6Iz5KWflLoK7Jm/B6nPNQrfC3J
         1UGrpVXMhMJQWfsk9uGvqUQMts5bYHkqwGN2jyAIftJYnktIS1G55+H/SkQ8VG8OII
         IE33n8vVrViKz/VD8jLPKwjw8ARJLrItk6AVypuE=
Date:   Thu, 21 Oct 2021 10:28:35 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Stefan Agner <stefan@agner.ch>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2 1/2] serial: imx: fix detach/attach of serial console
Message-ID: <YXEks5JJ8Eg9wZob@kroah.com>
References: <20211020192643.476895-1-francesco.dolcini@toradex.com>
 <20211020192643.476895-2-francesco.dolcini@toradex.com>
 <CAHp75VdieUOthjX9N89W-boPNk7PrQuTuxM_xmqpo2yv07oZZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VdieUOthjX9N89W-boPNk7PrQuTuxM_xmqpo2yv07oZZA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Oct 20, 2021 at 10:54:26PM +0300, Andy Shevchenko wrote:
> On Wed, Oct 20, 2021 at 10:27 PM Francesco Dolcini
> <francesco.dolcini@toradex.com> wrote:
> >
> > From: Stefan Agner <stefan@agner.ch>
> >
> > If the device used as a serial console gets detached/attached at runtime,
> > register_console() will try to call imx_uart_setup_console(), but this
> > is not possible since it is marked as __init.
> 
> Thank you for fixing this!
> 
> > For instance
> >
> >   # cat /sys/devices/virtual/tty/console/active
> >   tty1 ttymxc0
> >   # echo -n N > /sys/devices/virtual/tty/console/subsystem/ttymxc0/console
> >   # echo -n Y > /sys/devices/virtual/tty/console/subsystem/ttymxc0/console
> 
> Can we leave only something like below in the commit message?
> 
> > [   73.167005] Unable to handle kernel paging request at virtual address c154d928
> > [   73.168304] Internal error: Oops: 8000000d [#1] SMP ARM
> > [   73.168522] CPU: 0 PID: 536 Comm: sh Not tainted 5.15.0-rc6-00056-g3968ddcf05fb #3
>   ...
> > [   73.168791] PC is at imx_uart_console_setup+0x0/0x238
> > [   73.168927] LR is at try_enable_new_console+0x98/0x124
>   ...
> > [   73.173826] [<c0196f44>] (try_enable_new_console) from [<c01984a8>] (register_console+0x10c/0x2ec)
> > [   73.174053] [<c01984a8>] (register_console) from [<c06e2c90>] (console_store+0x14c/0x168)
> > [   73.174262] [<c06e2c90>] (console_store) from [<c0383718>] (kernfs_fop_write_iter+0x110/0x1cc)
> 
> > A similar issue could be triggered unbinding/binding the serial console
> 
> on unbinding/binding
> 
> > device [*].
> >
> > Drop __init so that imx_uart_setup_console() can be safely called at
> > runtime.
> >
> > [*] https://lore.kernel.org/all/20181114174940.7865-3-stefan@agner.ch/
> 
> Make it Link: tag?
> 
> > Fixes: a3cb39d258ef ("serial: core: Allow detach and attach serial device for console")
> > Signed-off-by: Stefan Agner <stefan@agner.ch>
> > Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> 
> With above nit-picks addressed, FWIW,

Those are not a big deal, I'll edit the changelog text...

thanks,

greg k-h
