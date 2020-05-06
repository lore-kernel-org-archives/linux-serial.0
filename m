Return-Path: <SRS0=tlDI=6U=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE8A6C28CBC
	for <linux-serial@archiver.kernel.org>; Wed,  6 May 2020 06:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C72ED206F9
	for <linux-serial@archiver.kernel.org>; Wed,  6 May 2020 06:29:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbgEFG3s (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 6 May 2020 02:29:48 -0400
Received: from bmailout2.hostsharing.net ([83.223.78.240]:50703 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbgEFG3r (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 6 May 2020 02:29:47 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 929A02802D276;
        Wed,  6 May 2020 08:29:43 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 3F63E1C0A9; Wed,  6 May 2020 08:29:43 +0200 (CEST)
Date:   Wed, 6 May 2020 08:29:43 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Rob Herring <robh+dt@kernel.org>,
        "Matwey V. Kornilov" <matwey@sai.msu.ru>,
        Giulio Benetti <giulio.benetti@micronovasrl.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Christoph Muellner <christoph.muellner@theobroma-systems.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH 4/4] serial: 8250: Support rs485 bus termination GPIO
Message-ID: <20200506062943.qugqwhnkismnnkrb@wunner.de>
References: <cover.1588505407.git.lukas@wunner.de>
 <a91b9392e8e7914cae16f59beb1ffe6b335f81c9.1588505407.git.lukas@wunner.de>
 <20200505161035.GW185537@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505161035.GW185537@smile.fi.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, May 05, 2020 at 07:10:35PM +0300, Andy Shevchenko wrote:
> On Tue, May 05, 2020 at 04:42:04PM +0200, Lukas Wunner wrote:
> > Commit e8759ad17d41 ("serial: uapi: Add support for bus termination")
> > introduced the ability to enable rs485 bus termination from user space.
> > So far the feature is only used by a single driver, 8250_exar.c, using a
> > hardcoded GPIO pin specific to Siemens IOT2040 products.
> > 
> > Provide for a more generic solution by allowing specification of an
> > rs485 bus termination GPIO pin in the device tree:  Amend the serial
> > core to retrieve the GPIO from the device tree (or ACPI table) and amend
> > the default ->rs485_config() callback for 8250 drivers to change the
> > GPIO on request from user space.
> 
> ...
> 
> > @@ -3331,6 +3332,29 @@ int uart_get_rs485_mode(struct uart_port *port)
> 
> > +		devm_gpiod_put(dev, port->rs485_term_gpio);
> 
> > +	port->rs485_term_gpio = devm_gpiod_get_optional(dev, "rs485-term",
> 
> Using devm_*() in uart_get_rs485_mode() seems not right.
> Why do you need this?

uart_get_rs485_mode() is called from a driver's ->probe() hook and we
do not have a corresponding function that is called from a ->remove()
hook where we'd be able to relinquish rs485 resources we've acquired
on probe.

Of course I could add that but it would be more heavy-weight compared
to simply using devm_*().  Do you disagree?

devm_gpiod_put() isn't strictly necessary here.  It is only necessary
if one of the drivers would invoke uart_get_rs485_mode() multiple
times, which none of them does AFAICS.  It's just a safety measure.
I can drop it if that is preferred.


> > +		GPIOD_FLAGS_BIT_DIR_SET | GPIOD_FLAGS_BIT_DIR_OUT);
> 
> Parameter has a specific macro GPIOD_OUT_HIGH.

Good point.  It's also occurred to me now that reading the GPIO's
value after changing its direction to output is nonsense.  If anything
it ought to be read *before* changing the direction to output.
That would make sense in case the board has a pullup or pulldown on
the Termination Enable pin.  In other cases the pin may just float
and the value will be unpredictable.  However if I do not read the
pin, I'd have to choose either high or low as initial state.  Hm.
Let me check back with our hardware engineers today and see what they
recommend.

Thanks,

Lukas
