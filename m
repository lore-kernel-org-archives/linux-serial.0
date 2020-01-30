Return-Path: <SRS0=gv8u=3T=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A03FCC2D0DB
	for <linux-serial@archiver.kernel.org>; Thu, 30 Jan 2020 18:25:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76B952083E
	for <linux-serial@archiver.kernel.org>; Thu, 30 Jan 2020 18:25:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729524AbgA3SZE (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 30 Jan 2020 13:25:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:51550 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729518AbgA3SZE (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 30 Jan 2020 13:25:04 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 96B7BAF21;
        Thu, 30 Jan 2020 18:25:02 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20200128141958.vwbxoqglt5gw4xj5@wunner.de>
Date:   Thu, 30 Jan 2020 17:11:55 +0100
Cc:     "Matthias Brugger" <matthias.bgg@gmail.com>,
        <matthias.bgg@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        "Matthias Brugger" <mbrugger@suse.com>,
        "Scott Branden" <sbranden@broadcom.com>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        "Ray Jui" <rjui@broadcom.com>,
        "Stephen Boyd" <swboyd@chromium.org>,
        "Florian Fainelli" <f.fainelli@gmail.com>,
        <bcm-kernel-feedback-list@broadcom.com>,
        <linux-rpi-kernel@lists.infradead.org>,
        <linux-serial@vger.kernel.org>, <jslaby@suse.com>
Subject: Re: [PATCH] serial: 8250_early: Add earlycon for BCM2835 aux uart
From:   "Nicolas Saenz Julienne" <nsaenzjulienne@suse.de>
To:     "Lukas Wunner" <lukas@wunner.de>
Message-Id: <C099APQHQAHB.3Q9UVYJYT98TN@linux-9qgx>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue Jan 28, 2020 at 3:19 PM, Lukas Wunner wrote:
> On Tue, Jan 28, 2020 at 01:42:21PM +0100, Nicolas Saenz Julienne wrote:
> > I'm testing this by booting directly from RPi4's bootloader. And it
> > works as long as I add this to config.txt:
> >=20
> > enable_uart=3D1
> > gpu_freq=3D500
> >=20
> > Which AFAIK blocks frequency scalin on the GPU and fixes the clock to a
> > point where the serial is set at 115200 bauds.
> >=20
> > Ideally it'd be nice to be able to query the clock frequency, and
> > recalculate the divisors based on that. But I don't know if it's
> > feasible at that point in the boot process.
>
> Well, we don't even support adjusting the baudrate *after* the kernel
> has booted.

Don't 8250 uarts have a clk divisor? I've seen other 8250 earlycon
drivers do this (see 8250_ingenic.c), that said I think it's a lost
cause for us.

BTW did you had the oportunity to have a go at the patch?

> The problem is that in mainline, bcm2835_defconfig contains:
> CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE=3Dy
>
> Likewise in the Foundation's downstream tree, bcmrpi_defconfig as well
> as bcm2711_defconfig and bcm2709_defconfig contain:
> CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE=3Dy
>
> In contrast to this, we set the following on Revolution Pi devices:
> CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=3Dy
>
> Downclocking influences not only the uart1 baud rate but also the
> spi0 clock. We attach Ethernet chips to spi0, throughput was
> significantly worse with the ondemand governor (which is what we
> used previously). We felt that maximum Ethernet performance
> outweighs the relatively small powersaving gains.

In that regard I suggest you use the upstream cpufreq driver which
behaves properly in that regard. It disables GPU freq scaling, so as to
change CPU frequencies without SPI/I2C/UART issues.

Regards,
Nicolas
