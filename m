Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4757AC00A8F
	for <linux-serial@archiver.kernel.org>; Tue, 24 Oct 2023 15:27:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234890AbjJXP06 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 24 Oct 2023 11:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343508AbjJXP0q (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 24 Oct 2023 11:26:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E67327F
        for <linux-serial@vger.kernel.org>; Tue, 24 Oct 2023 08:24:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92C82C433C8;
        Tue, 24 Oct 2023 15:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698161060;
        bh=kr0FuSD95oug9cIoFzf68PczAqxjb+483S5GB0MhI/U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dsbFYV3Z6ue/go9QN9hrx8cBWMAwE1xNVeA4ySXwl0N4gXy1zMdRw+sh1oklQRxwr
         AyDkxkcZxCRWjYmJaDHK5syZO8XNb7cH4PrigZ67pmSqQy2bzbKl/hyueefPAh5YyN
         +TxZfStu/wuESOn/CzIJmdZCj06NRBaKgsYMWhY8=
Date:   Tue, 24 Oct 2023 17:24:17 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Thomas Richard <thomas.richard@bootlin.com>
Cc:     Tony Lindgren <tony@atomide.com>, jirislaby@kernel.org,
        linux-serial@vger.kernel.org, gregory.clement@bootlin.com,
        u-kumar1@ti.com, d-gole@ti.com, thomas.petazzoni@bootlin.com,
        Vignesh R <vigneshr@ti.com>,
        Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH] serial: 8250_omap: Set the console genpd always on if no
 console suspend
Message-ID: <2023102406-ether-huntress-e7e1@gregkh>
References: <20231017130540.1149721-1-thomas.richard@bootlin.com>
 <20231023074440.GS27774@atomide.com>
 <7ad9f0a2-053e-4df1-8b2d-e9a9716eb259@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ad9f0a2-053e-4df1-8b2d-e9a9716eb259@bootlin.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Oct 24, 2023 at 04:53:46PM +0200, Thomas Richard wrote:
> On 10/23/23 09:44, Tony Lindgren wrote:
> > Hi,
> > 
> > Adding Kevin and Vignesh too in case they have better ideas on how to
> > prevent the power domain from suspending for no_console_suspend kernel
> > parameter.
> > 
> > * Thomas Richard <thomas.richard@bootlin.com> [231017 13:05]:
> >> If the console suspend is disabled, the genpd of the console shall not
> >> be powered-off during suspend.
> >> Set the flag GENPD_FLAG_ALWAYS_ON to the corresponding genpd during
> >> suspend, and restore the original value during the resume.
> >>
> >> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
> >> ---
> >>  drivers/tty/serial/8250/8250_omap.c | 33 ++++++++++++++++++++++++-----
> >>  1 file changed, 28 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
> >> index ca972fd37725..91a483dc460c 100644
> >> --- a/drivers/tty/serial/8250/8250_omap.c
> >> +++ b/drivers/tty/serial/8250/8250_omap.c
> >> @@ -27,6 +27,7 @@
> >>  #include <linux/pm_wakeirq.h>
> >>  #include <linux/dma-mapping.h>
> >>  #include <linux/sys_soc.h>
> >> +#include <linux/pm_domain.h>
> >>  
> >>  #include "8250.h"
> >>  
> >> @@ -114,6 +115,12 @@
> >>  /* RX FIFO occupancy indicator */
> >>  #define UART_OMAP_RX_LVL		0x19
> >>  
> >> +/*
> >> + * Copy of the genpd flags for the console.
> >> + * Only used if console suspend is disabled
> >> + */
> >> +static unsigned int genpd_flags_console;
> > 
> > This should be priv->genpd_flags_console or something similar as the
> > uarts in an always-on power domain may have different flags from other
> > power domains.
> 
> Ok I'll move genpd_flags_console to the priv struct.
> 
> @Greg, as you already added the patch to your tty git tree, do you
> prefer a new version of the patch or a fixup ?

A fixup please.

thanks,

greg k-h
