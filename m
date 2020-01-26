Return-Path: <SRS0=SkpG=3P=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D79ECC2D0DB
	for <linux-serial@archiver.kernel.org>; Sun, 26 Jan 2020 13:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD3412071A
	for <linux-serial@archiver.kernel.org>; Sun, 26 Jan 2020 13:12:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbgAZNMl (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 26 Jan 2020 08:12:41 -0500
Received: from bmailout3.hostsharing.net ([176.9.242.62]:38231 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgAZNMl (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 26 Jan 2020 08:12:41 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id D71B6100CF15C;
        Sun, 26 Jan 2020 14:12:38 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 7C4D01D7C59; Sun, 26 Jan 2020 14:12:38 +0100 (CET)
Date:   Sun, 26 Jan 2020 14:12:38 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     matthias.bgg@kernel.org
Cc:     gregkh@linuxfoundation.org, jslaby@suse.com,
        nsaenzjulienne@suse.de, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <mbrugger@suse.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Stephen Boyd <swboyd@chromium.org>,
        bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH] serial: 8250_early: Add earlycon for BCM2835 aux uart
Message-ID: <20200126131238.c65zj3wo3srafa7z@wunner.de>
References: <20200126123314.3558-1-matthias.bgg@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200126123314.3558-1-matthias.bgg@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sun, Jan 26, 2020 at 01:33:14PM +0100, matthias.bgg@kernel.org wrote:
> +#ifdef CONFIG_SERIAL_8250_CONSOLE
> +
> +static int __init early_bcm2835aux_setup(struct earlycon_device *device,
> +					const char *options)
> +{
> +	if (!device->port.membase)
> +		return -ENODEV;
> +
> +	device->port.iotype = UPIO_MEM32;
> +	device->port.regshift = 2;
> +
> +	return early_serial8250_setup(device, NULL);
> +}
> +
> +OF_EARLYCON_DECLARE(bcm2835aux, "brcm,bcm2835-aux-uart",
> +		    early_bcm2835aux_setup);
> +#endif

Does this really work?  I also tried to get it working recently and
the system just hung on boot.  Looking at it with a JTAG debugger
showed that the bcm2835aux registers were inaccessible because
the mini UART wasn't enabled in the AUXENB register.

Maybe if you use OF_EARLYCON_DECLARE, the firmware recognizes that
serial1 is set as stdout-path and performs enablement of the mini UART?
Or are you using U-Boot which perhaps does the enablement?

I also saw in the JTAG debugger that the uartclk member contained
an incorrect value, so I'd expect that it has to be set as well in
early_bcm2835aux_setup().

I'll see to it that I give this patch a whirl when I return to the
office next week.

Thanks,

Lukas
