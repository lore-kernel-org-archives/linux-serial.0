Return-Path: <SRS0=H5Pf=3U=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0016C2D0DB
	for <linux-serial@archiver.kernel.org>; Fri, 31 Jan 2020 15:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 955CF20707
	for <linux-serial@archiver.kernel.org>; Fri, 31 Jan 2020 15:33:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728922AbgAaPdQ (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 31 Jan 2020 10:33:16 -0500
Received: from bmailout1.hostsharing.net ([83.223.95.100]:44233 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728860AbgAaPdQ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 31 Jan 2020 10:33:16 -0500
X-Greylist: delayed 540 seconds by postgrey-1.27 at vger.kernel.org; Fri, 31 Jan 2020 10:33:15 EST
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 7222330008C8C;
        Fri, 31 Jan 2020 16:24:14 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 2E8DC22B001; Fri, 31 Jan 2020 16:24:14 +0100 (CET)
Date:   Fri, 31 Jan 2020 16:24:14 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>, matthias.bgg@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <mbrugger@suse.com>,
        Scott Branden <sbranden@broadcom.com>,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Ray Jui <rjui@broadcom.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        jslaby@suse.com
Subject: Re: [PATCH] serial: 8250_early: Add earlycon for BCM2835 aux uart
Message-ID: <20200131152414.73tgwsfhzgu4apkx@wunner.de>
References: <20200128141958.vwbxoqglt5gw4xj5@wunner.de>
 <C099APQHQAHB.3Q9UVYJYT98TN@linux-9qgx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C099APQHQAHB.3Q9UVYJYT98TN@linux-9qgx>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Jan 30, 2020 at 05:11:55PM +0100, Nicolas Saenz Julienne wrote:
> BTW did you had the oportunity to have a go at the patch?

I've just performed a quick test and it doesn't work for me.
If I add stdout-path = "serial1:115200n8"; to the chosen node,
I only get a regular console with this patch, not an earlycon.


> > The problem is that in mainline, bcm2835_defconfig contains:
> > CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE=y
> >
> > Likewise in the Foundation's downstream tree, bcmrpi_defconfig as well
> > as bcm2711_defconfig and bcm2709_defconfig contain:
> > CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE=y
> >
> > In contrast to this, we set the following on Revolution Pi devices:
> > CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
> >
> > Downclocking influences not only the uart1 baud rate but also the
> > spi0 clock. We attach Ethernet chips to spi0, throughput was
> > significantly worse with the ondemand governor (which is what we
> > used previously). We felt that maximum Ethernet performance
> > outweighs the relatively small powersaving gains.
> 
> In that regard I suggest you use the upstream cpufreq driver which
> behaves properly in that regard. It disables GPU freq scaling, so as to
> change CPU frequencies without SPI/I2C/UART issues.

Okay, I'll take a look.  But the uart1 baudrate will still be wrong
if the firmware downclocks because of overheating, right?

Thanks,

Lukas
