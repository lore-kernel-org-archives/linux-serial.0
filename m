Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6AD8C433EF
	for <linux-serial@archiver.kernel.org>; Tue,  4 Jan 2022 10:43:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbiADKnh (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 4 Jan 2022 05:43:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbiADKnh (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 4 Jan 2022 05:43:37 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F822C061761
        for <linux-serial@vger.kernel.org>; Tue,  4 Jan 2022 02:43:37 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1n4hHm-0007Mm-Mq; Tue, 04 Jan 2022 11:43:22 +0100
Subject: Re: [PATCH] serial: imx: reduce RX interrupt frequency
To:     =?UTF-8?Q?Tomasz_Mo=c5=84?= <tomasz.mon@camlingroup.com>,
        linux-serial@vger.kernel.org
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        k.drobinski@camlintechnologies.com
References: <20220104103203.2033673-1-tomasz.mon@camlingroup.com>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Message-ID: <d534d6c2-3f70-3753-62fe-54737ffbe384@pengutronix.de>
Date:   Tue, 4 Jan 2022 11:43:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220104103203.2033673-1-tomasz.mon@camlingroup.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 04.01.22 11:32, Tomasz Moń wrote:
> Triggering RX interrupt for every byte defeats the purpose of aging
> timer and leads to interrupt starvation at high baud rates.

s/starvation/storm/ ?

> 
> Increase receiver trigger level to 8 to increase the minimum period
> between RX interrupts to 8 characters time. The tradeoff is increased
> latency. In the worst case scenario, where RX data has intercharacter
> delay slightly less than aging timer (8 characters time), it can take
> up to 63 characters time for the interrupt to be raised since the
> reception of the first character.
> 
> Signed-off-by: Tomasz Moń <tomasz.mon@camlingroup.com>
> ---
>  drivers/tty/serial/imx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 90f82e6c54e4..3c812c47ecc0 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -1255,7 +1255,7 @@ static void imx_uart_clear_rx_errors(struct imx_port *sport)
>  }
>  
>  #define TXTL_DEFAULT 2 /* reset default */
> -#define RXTL_DEFAULT 1 /* reset default */
> +#define RXTL_DEFAULT 8 /* 8 characters or aging timer */
>  #define TXTL_DMA 8 /* DMA burst setting */
>  #define RXTL_DMA 9 /* DMA burst setting */
>  
> 


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
