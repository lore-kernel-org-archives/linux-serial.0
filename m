Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 629D2C32793
	for <linux-serial@archiver.kernel.org>; Wed, 18 Jan 2023 08:55:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbjARIzZ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 18 Jan 2023 03:55:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbjARIwh (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 18 Jan 2023 03:52:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D165DC01
        for <linux-serial@vger.kernel.org>; Wed, 18 Jan 2023 00:06:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E83E61512
        for <linux-serial@vger.kernel.org>; Wed, 18 Jan 2023 08:06:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DB93C433D2;
        Wed, 18 Jan 2023 08:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674029174;
        bh=8NVjwudOduI7u7BsQHwbczYVXSuKJge/XeZAtAYqit0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S/0SJx0WmThRCWvOVuAC8ezN/3WhgWOWDayvvMC5HY3TAVxAUVBKZP1Dzf+j2fLoU
         jFEFkhTah3JkFG3iUAntozSTD8XMfl/D/NBxKkcLPcBNQtHJNoV8Bu0pm/AOU7ZJ39
         bPQ/3UmQZh3baSmlzgKblBPy4H3aD3i1i1wjUOyytJU1ZDsiQLtgTNeDbD9nPbenDa
         hEi1pDysmRpaSAIPErbjp3bF5DrCJKGPHsDVY/Zbac7QrApoldsY4x8NZkRS7FcEy/
         gYXlnfAhyzVHZbr9IYm8wDJvl1NAVKZyg0zfOSTAnDo7ALa3ubF7rjQypmrdrKI//w
         dZ12EZLGKmudA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pI3Sv-0000Rp-JO; Wed, 18 Jan 2023 09:06:38 +0100
Date:   Wed, 18 Jan 2023 09:06:37 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     linux-serial@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Richard Genoud <richard.genoud@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Tim Harvey <tharvey@gateworks.com>,
        Tomasz =?utf-8?Q?Mo=C5=84?= <tomasz.mon@camlingroup.com>,
        linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH 3/8] serial: imx: do not sysrq broken chars
Message-ID: <Y8eojW29DNrx+F6D@hovoldconsulting.com>
References: <87bko4e65y.fsf@osv.gnss.ru>
 <20230113184334.287130-1-sorganov@gmail.com>
 <20230113184334.287130-4-sorganov@gmail.com>
 <Y8VsFx3p+viCp1It@hovoldconsulting.com>
 <87sfg92he3.fsf@osv.gnss.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sfg92he3.fsf@osv.gnss.ru>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Jan 17, 2023 at 08:35:48PM +0300, Sergey Organov wrote:
> Johan Hovold <johan@kernel.org> writes:
> > On Fri, Jan 13, 2023 at 09:43:29PM +0300, Sergey Organov wrote:

> >> @@ -911,9 +911,6 @@ static irqreturn_t __imx_uart_rxint(int irq, void *dev_id)
> >>  				continue;
> >>  		}
> >>  
> >> -		if (uart_handle_sysrq_char(&sport->port, (unsigned char)rx))
> >> -			continue;
> >> -
> >>  		if (unlikely(rx & URXD_ERR)) {
> >>  			if (rx & URXD_BRK)
> >>  				sport->port.icount.brk++;
> >> @@ -942,7 +939,8 @@ static irqreturn_t __imx_uart_rxint(int irq, void *dev_id)
> >>  				flg = TTY_OVERRUN;
> >>  
> >>  			sport->port.sysrq = 0;
> >> -		}
> >> +		} else if (uart_handle_sysrq_char(&sport->port, (unsigned char)rx))
> >> +			continue;
> >
> > Nit: missing braces {}
> >
> > Note that you could also place just place this after the block due to
> > the reset of the sysrq time stamp.
> 
> Thanks, I think I'll opt for adding braces. Relying on the reset of the
> timestamp feels a bit convoluted.

I agree, it may be a bit too subtle.

Johan
