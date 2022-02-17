Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75EEDC433F5
	for <linux-serial@archiver.kernel.org>; Thu, 17 Feb 2022 11:39:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234988AbiBQLjz (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 17 Feb 2022 06:39:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235818AbiBQLjw (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 17 Feb 2022 06:39:52 -0500
X-Greylist: delayed 332 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 17 Feb 2022 03:39:30 PST
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF6FE13D19
        for <linux-serial@vger.kernel.org>; Thu, 17 Feb 2022 03:39:30 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 57740300097DB;
        Thu, 17 Feb 2022 12:33:54 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 48EB354C1D; Thu, 17 Feb 2022 12:33:54 +0100 (CET)
Date:   Thu, 17 Feb 2022 12:33:54 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        u.kleine-koenig@pengutronix.de, linux@armlinux.org.uk,
        richard.genoud@gmail.com, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 2 1/9] serial: core: move RS485 configuration tasks from
 drivers into core
Message-ID: <20220217113354.GA7826@wunner.de>
References: <20220216001803.637-1-LinoSanfilippo@gmx.de>
 <20220216001803.637-2-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220216001803.637-2-LinoSanfilippo@gmx.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Feb 16, 2022 at 01:17:55AM +0100, Lino Sanfilippo wrote:
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -1282,8 +1282,26 @@ static int uart_set_rs485_config(struct uart_port *port,
>  	if (copy_from_user(&rs485, rs485_user, sizeof(*rs485_user)))
>  		return -EFAULT;
>  
> +	/* pick sane settings if the user hasn't */
> +	if (!(rs485.flags & SER_RS485_RTS_ON_SEND) ==
> +	    !(rs485.flags & SER_RS485_RTS_AFTER_SEND)) {
> +		rs485.flags |= SER_RS485_RTS_ON_SEND;
> +		rs485.flags &= ~SER_RS485_RTS_AFTER_SEND;
> +	}

The policy you're enforcing here is:  If settings are nonsensical,
always default to active-high polarity.

However some drivers currently enforce a completely different policy:
E.g. with 8250_lpc18xx.c, if SER_RS485_RTS_ON_SEND is set, use active-high
(and fix up SER_RS485_RTS_AFTER_SEND), else use active-low polarity.
This yields a different result compared to your policy in case both bits
are cleared.

Similarly, sc16is7xx.c defaults to active-low if SER_RS485_RTS_AFTER_SEND
is set, else active-high polarity.  This yields a different result compared
to your policy in case both bits are set.

You risk breaking existing user space applications with this change
if those applications specify nonsensical polarity settings.


I happen to have created a similar commit to this one a month ago
and I came to the conclusion that all one can do is offer a library
function uart_sanitize_rs485_mode() which drivers may elect to call
if that helper's policy is identical to what they're doing now:

https://github.com/l1k/linux/commit/637984111e42


> +
> +	rs485.delay_rts_before_send = min_t(unsigned int,
> +					    rs485.delay_rts_before_send,
> +					    SER_RS485_MAX_RTS_DELAY);
> +	rs485.delay_rts_after_send = min_t(unsigned int,
> +					   rs485.delay_rts_after_send,
> +					   SER_RS485_MAX_RTS_DELAY);

Nonsensical delays may not only be passed in from user space via ioctl(),
but through the device tree.  That's another reason to use a library
function:  It can be called both from the ioctl() as well as after (or in)
uart_get_rs485_mode().


> +	/* Return clean padding area to userspace */
> +	memset(rs485.padding, 0, sizeof(rs485.padding));

Unlike the polarity and delay handling, this one makes sense.

Thanks,

Lukas
