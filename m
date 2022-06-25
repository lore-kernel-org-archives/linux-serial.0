Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C2AC43334
	for <linux-serial@archiver.kernel.org>; Sat, 25 Jun 2022 19:49:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233272AbiFYTt4 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 25 Jun 2022 15:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231474AbiFYTtz (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 25 Jun 2022 15:49:55 -0400
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f23e:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C58F312D2B;
        Sat, 25 Jun 2022 12:49:53 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id ECF9B100FBFD2;
        Sat, 25 Jun 2022 21:49:51 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id B46361191FF; Sat, 25 Jun 2022 21:49:51 +0200 (CEST)
Date:   Sat, 25 Jun 2022 21:49:51 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        ilpo.jarvinen@linux.intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, vz@mleia.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        p.rosenberger@kunbus.com, Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: Re: [PATCH 1/8] serial: core: only get RS485 termination gpio if
 supported
Message-ID: <20220625194951.GA2879@wunner.de>
References: <20220622154659.8710-1-LinoSanfilippo@gmx.de>
 <20220622154659.8710-2-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622154659.8710-2-LinoSanfilippo@gmx.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Jun 22, 2022 at 05:46:52PM +0200, Lino Sanfilippo wrote:
> In uart_get_rs485_mode() only try to get a termination GPIO if RS485 bus
> termination is supported by the driver.
[...]
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -3384,17 +3384,20 @@ int uart_get_rs485_mode(struct uart_port *port)
>  		rs485conf->flags |= SER_RS485_RTS_AFTER_SEND;
>  	}
>  
> -	/*
> -	 * Disabling termination by default is the safe choice:  Else if many
> -	 * bus participants enable it, no communication is possible at all.
> -	 * Works fine for short cables and users may enable for longer cables.
> -	 */
> -	port->rs485_term_gpio = devm_gpiod_get_optional(dev, "rs485-term",
> -							GPIOD_OUT_LOW);
> -	if (IS_ERR(port->rs485_term_gpio)) {
> -		ret = PTR_ERR(port->rs485_term_gpio);
> -		port->rs485_term_gpio = NULL;
> -		return dev_err_probe(dev, ret, "Cannot get rs485-term-gpios\n");
> +	if (port->rs485_supported->flags & SER_RS485_TERMINATE_BUS) {

So I think linux-next commit be2e2cb1d281 ("serial: Sanitize rs485_struct")
contains a mistake in that it forces drivers to set SER_RS485_TERMINATE_BUS
in their rs485_supported->flags to allow enabling bus termination.

That's wrong because *every* rs485-capable driver can enable bus
termination if a GPIO has been defined for that in the DT.

In fact, another commit which was applied as part of the same series,
ebe2cf736a04 ("serial: pl011: Fill in rs485_supported") does not set
SER_RS485_TERMINATE_BUS in amba-pl011.c's flags and thus forbids the
driver from enabling bus termination, even though we know there are
products out there which support bus termination on the pl011 through
a GPIO (Revolution Pi RevPi Compact, Revpi Flat).

I think what you want to do is amend uart_get_rs485_mode() to set
SER_RS485_TERMINATE_BUS in port->rs485_supported_flags if a GPIO
was found in the DT.  Instead of the change proposed above.

Thanks,

Lukas
