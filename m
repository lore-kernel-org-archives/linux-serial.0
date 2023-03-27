Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE20C6FD1D
	for <linux-serial@archiver.kernel.org>; Mon, 27 Mar 2023 15:31:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232860AbjC0PbA (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 27 Mar 2023 11:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232869AbjC0Paz (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 27 Mar 2023 11:30:55 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C56A30C0
        for <linux-serial@vger.kernel.org>; Mon, 27 Mar 2023 08:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=7DkARw+ftkstubVefFishH1SCvWJh4z6LhiWzva17m0=; b=kfD67yfU5XGzBfYkoWPJRjxQfM
        wVG0/RGPkfAWY94c95EKHuSxvW0Q07klCmjq8JSQSihSyLz+KNUTrflcQiLdHe7tbqMkrfgEsBxGv
        v3fAz00XwMBqmQ3/s1FHLRPrOcZQioOObbRtb1Yll8IRpt0Yzuri9zPRjYZclewMZSVuDc1rL2wb6
        tFcP/RtwzKvJcym3O0EAs1jrQNtEHfk4DP0T1gRB+QPSEgy1emq4l1GJ2IsfGHYcodWUX5hC/liYp
        hL8ivwDbImzdfxhOdMf2kyC5eqrCvz2BGxVlMnDhluCSekr05pG/asgR/JaKeSzBpg3P1Z4bADNBC
        3xzuPRgg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46212)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1pgonw-00044t-Ht; Mon, 27 Mar 2023 16:30:40 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1pgont-0005XF-Fo; Mon, 27 Mar 2023 16:30:37 +0100
Date:   Mon, 27 Mar 2023 16:30:37 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Stefan Wahren <stefan.wahren@i2se.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Stefan Wahren <stefan.wahren@chargebyte.com>,
        linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Tomasz =?utf-8?Q?Mo=C5=84?= <tomasz.mon@camlingroup.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: Regression: serial: imx: overrun errors on debug UART
Message-ID: <ZCG2nUUSU0NdP5cp@shell.armlinux.org.uk>
References: <2c29454b-9369-4360-8eb4-c151f59460cb@i2se.com>
 <d660e3cf-5686-d989-3b59-efe83ec9d590@linux.intel.com>
 <CAOMZO5A+GujiQY-UT3Q-8o0AKujJb_4kY+5L4x1e07ovGfo31w@mail.gmail.com>
 <9e22f237-f3ee-0415-9e6b-89a137769b8f@i2se.com>
 <5d59dec6-9f6f-7b20-1221-f57c94b29cca@i2se.com>
 <20230325151100.mskydt3hwbnspqp4@pengutronix.de>
 <cb16ddb7-f22f-d637-8670-bccc77add0af@i2se.com>
 <87mt3ynsa7.fsf@osv.gnss.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87mt3ynsa7.fsf@osv.gnss.ru>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Mar 27, 2023 at 06:11:12PM +0300, Sergey Organov wrote:
> Stefan Wahren <stefan.wahren@i2se.com> writes:
> 
> > Hi,
> >
> > Am 25.03.23 um 16:11 schrieb Uwe Kleine-König:
> 
> [...]
> 
> > today i had time to do some testing. At first i tested with different RXTL_DEFAULT values.
> >
> > 1 No overrun
> > 2 No overrun
> > 4 No overrun
> > 8 Overruns
> >
> > After that i look at the # echo 0 > /proc/sys/kernel/printk approach,
> > but this didn't change anything. The kernel is usually silent about
> > log message after boot and the console works still with echo.
> > Enforcing some driver to call printk periodically would make the
> > console unusuable.
> 
> As you figured that printk() is not the cause, it must be something else
> that causes overruns, so there is no need to check printk case further.
> 
> >
> > Finally i tried to disabled the spin_lock in imx_uart_console_write:
> >
> > diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> > index f07c4f9ff13c..c342559ff1a2 100644
> > --- a/drivers/tty/serial/imx.c
> > +++ b/drivers/tty/serial/imx.c
> > @@ -2007,14 +2007,12 @@ imx_uart_console_write(struct console *co, const char *s, unsigned int count)
> >  	struct imx_port_ucrs old_ucr;
> >  	unsigned long flags;
> >  	unsigned int ucr1;
> > -	int locked = 1;
> > +	int locked = 0;
> >
> >  	if (sport->port.sysrq)
> >  		locked = 0;
> >  	else if (oops_in_progress)
> >  		locked = spin_trylock_irqsave(&sport->port.lock, flags);
> > -	else
> > -		spin_lock_irqsave(&sport->port.lock, flags);
> >
> >  	/*
> >  	 *	First, save UCR1/2/3 and then disable interrupts
> >
> > But the overruns still occured. Is this because the serial core
> > already helds a lock?
> 
> This probably isn't even called when there is no printk() output, as
> user-space writes to /dev/console are rather performed through regular
> generic code, AFAIK.

Correct on both points.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
