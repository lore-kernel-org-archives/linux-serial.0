Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A9FC54EE9
	for <linux-serial@archiver.kernel.org>; Tue, 20 Sep 2022 11:37:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbiITLhI (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 20 Sep 2022 07:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbiITLhH (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 20 Sep 2022 07:37:07 -0400
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3AA46EF0F
        for <linux-serial@vger.kernel.org>; Tue, 20 Sep 2022 04:37:05 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 6EB37280BCD96;
        Tue, 20 Sep 2022 13:37:04 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 605B327C6F; Tue, 20 Sep 2022 13:37:04 +0200 (CEST)
Date:   Tue, 20 Sep 2022 13:37:04 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vicente Bergas <vicencb@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Johan Hovold <johan@kernel.org>,
        heiko@sntech.de, giulio.benetti@micronovasrl.com,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Raymond Tan <raymond.tan@intel.com>
Subject: Re: [PATCH v4 04/13] serial: 8250_dwlib: RS485 HW half & full duplex
 support
Message-ID: <20220920113704.GA12014@wunner.de>
References: <20220425143410.12703-1-ilpo.jarvinen@linux.intel.com>
 <20220425143410.12703-5-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220425143410.12703-5-ilpo.jarvinen@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Apr 25, 2022 at 05:34:01PM +0300, Ilpo Järvinen wrote:
> +	/* Reset to default polarity */
> +	tcr |= DW_UART_TCR_DE_POL;
> +	tcr &= ~DW_UART_TCR_RE_POL;
> +
> +	if (!(rs485->flags & SER_RS485_RTS_ON_SEND))
> +		tcr &= ~DW_UART_TCR_DE_POL;
> +	if (device_property_read_bool(p->dev, "rs485-rx-active-high"))
> +		tcr |= DW_UART_TCR_RE_POL;

Something that only occurred to me after this got merged:

You're using "identity" polarity for hardware-driven Driver Enable,
i.e. if SER_RS485_RTS_ON_SEND is set, then DE is driven high on send.

The em485 software-driven Driver Enable on the other hand uses the
opposite polarity for historical reasons.

So if someone has been using RS485 with software emulation so far on
a DesignWare 4.0 UART, they'll have to change their ACPI tables or
DeviceTree once they move to a kernel which includes the above-quoted
patch.  Such users probably don't exist because the DesignWare 4.0 UART
was introduced relatively recently.

Personally I'm in favor of the polarity you've chosen.  It's too late
to change now anyway.

Thanks,

Lukas
