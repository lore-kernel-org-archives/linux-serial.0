Return-Path: <SRS0=GjUI=3R=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F4DDC2D0DB
	for <linux-serial@archiver.kernel.org>; Tue, 28 Jan 2020 14:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F49B207FD
	for <linux-serial@archiver.kernel.org>; Tue, 28 Jan 2020 14:37:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730759AbgA1OUD (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:20:03 -0500
Received: from bmailout2.hostsharing.net ([83.223.78.240]:58897 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730339AbgA1OUB (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 28 Jan 2020 09:20:01 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id D4A1A2800BC20;
        Tue, 28 Jan 2020 15:19:58 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 9B1141EB447; Tue, 28 Jan 2020 15:19:58 +0100 (CET)
Date:   Tue, 28 Jan 2020 15:19:58 +0100
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
Message-ID: <20200128141958.vwbxoqglt5gw4xj5@wunner.de>
References: <88af0fca-90d1-58ff-406d-73f185eb8b7e@gmail.com>
 <C07FL64L9QNN.357K7JAUOSNA2@linux-9qgx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C07FL64L9QNN.357K7JAUOSNA2@linux-9qgx>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Jan 28, 2020 at 01:42:21PM +0100, Nicolas Saenz Julienne wrote:
> I'm testing this by booting directly from RPi4's bootloader. And it
> works as long as I add this to config.txt:
> 
> enable_uart=1
> gpu_freq=500
> 
> Which AFAIK blocks frequency scalin on the GPU and fixes the clock to a
> point where the serial is set at 115200 bauds.
> 
> Ideally it'd be nice to be able to query the clock frequency, and
> recalculate the divisors based on that. But I don't know if it's
> feasible at that point in the boot process.

Well, we don't even support adjusting the baudrate *after* the kernel
has booted.

The problem is that in mainline, bcm2835_defconfig contains:
CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE=y

Likewise in the Foundation's downstream tree, bcmrpi_defconfig as well
as bcm2711_defconfig and bcm2709_defconfig contain:
CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE=y

In contrast to this, we set the following on Revolution Pi devices:
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y

Downclocking influences not only the uart1 baud rate but also the
spi0 clock.  We attach Ethernet chips to spi0, throughput was
significantly worse with the ondemand governor (which is what we
used previously).  We felt that maximum Ethernet performance
outweighs the relatively small powersaving gains.

Thanks,

Lukas
