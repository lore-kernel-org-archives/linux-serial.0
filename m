Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 549CCC433B4
	for <linux-serial@archiver.kernel.org>; Sat, 10 Apr 2021 08:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C530611AF
	for <linux-serial@archiver.kernel.org>; Sat, 10 Apr 2021 08:34:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234169AbhDJIeP (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 10 Apr 2021 04:34:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:57864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233943AbhDJIeP (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sat, 10 Apr 2021 04:34:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 62C9461056;
        Sat, 10 Apr 2021 08:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1618043640;
        bh=wbL9rmU/UuCsqAZSYbZUY9UOH+gHNorWS7Ix/bBYP6w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i6In8rNzloep4eq0rClgDdExk1NHo7KS91geto3lm3Kqo0ivngJDSRdBVELNfGbls
         Qgv2zmzHl2ziJXGKBz4FJTC34mZKUI9pNDgT9xmWsPM1BYFJ6WbyW72+o8OJl+vemI
         ymNzEpz29Xp22CIQwNBexsXTab4x2EhUSuLDP4Ng=
Date:   Sat, 10 Apr 2021 10:33:58 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Robert Hodaszi <robert.hodaszi@digi.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-serial@vger.kernel.org,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] serial: imx: fix TX stop function not setting state to
 OFF in RS232-mode
Message-ID: <YHFi9gmtpCbIp8aU@kroah.com>
References: <ac5aa181-eca3-040a-302a-4992022d39f1@digi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ac5aa181-eca3-040a-302a-4992022d39f1@digi.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Apr 02, 2021 at 01:05:48PM +0200, Robert Hodaszi wrote:
> From: Robert Hodaszi <robert.hodaszi@digi.com>
> 
> If the mode had been changed to RS-485 after at least one character had
> been sent in RS-232 mode, the RS-485 transmission was not working.
> 
> Commit cb1a609236096c278ecbfb7be678a693a70283f1 ("serial: imx: implement
> rts delaying for rs485") added a TX state variable to keep track, when
> it needs to enable / disable the RS-485 transmitter.
> 
> In RS-232 mode, the start TX function just sets the state to SEND, and
> the stop function supposed to set it to OFF.
> 
> In RS-485 mode, the start TX function expects the state to be either
> OFF, WAIT_AFTER_SEND, or WAIT_AFTER RTS. It cannot do anything if the
> state is set to SEND, expects a stop first.
> 
> But stop TX function in RS-232 mode usually didn't set the state to OFF,
> as it first checked if the shifter is empty, and if not, it just
> returned, waiting for a TransmitComplete interrupt, which is only
> enabled in RS-485 mode. So the stop function was never called again.
> 
> That check, and the subsequent code part is not needed for RS-232, it
> just have to set the TX state to OFF.
> 
> Signed-off-by: Robert Hodaszi <robert.hodaszi@digi.com>
> ---
>  drivers/tty/serial/imx.c | 46 +++++++++++++++++++++-------------------
>  1 file changed, 24 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 8257597d034d..511badce3edd 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -443,6 +443,12 @@ static void imx_uart_stop_tx(struct uart_port *port)
>      ucr1 = imx_uart_readl(sport, UCR1);
>      imx_uart_writel(sport, ucr1 & ~UCR1_TRDYEN, UCR1);
> 
> +    if (!(port->rs485.flags & SER_RS485_ENABLED)) {
> +        /* Set the TX state in non-RS485 mode, nothing else to do */
> +        sport->tx_state = OFF;
> +        return;
> +    }
> +
>      usr2 = imx_uart_readl(sport, USR2);
>      if (!(usr2 & USR2_TXDC)) {
>          /* The shifter is still busy, so retry once TC triggers */
> @@ -453,33 +459,29 @@ static void imx_uart_stop_tx(struct uart_port *port)
>      ucr4 &= ~UCR4_TCEN;
>      imx_uart_writel(sport, ucr4, UCR4);
> 
> -    /* in rs485 mode disable transmitter */
> -    if (port->rs485.flags & SER_RS485_ENABLED) {
> -        if (sport->tx_state == SEND) {
> -            sport->tx_state = WAIT_AFTER_SEND;
> -            start_hrtimer_ms(&sport->trigger_stop_tx,
> -                     port->rs485.delay_rts_after_send);
> -            return;
> -        }
> +    if (sport->tx_state == SEND) {
> +        sport->tx_state = WAIT_AFTER_SEND;
> +        start_hrtimer_ms(&sport->trigger_stop_tx,
> +                    port->rs485.delay_rts_after_send);
> +        return;
> +    }
> 
> -        if (sport->tx_state == WAIT_AFTER_RTS ||
> -            sport->tx_state == WAIT_AFTER_SEND) {
> -            u32 ucr2;
> +    if (sport->tx_state == WAIT_AFTER_RTS ||
> +        sport->tx_state == WAIT_AFTER_SEND) {
> +        /* in rs485 mode disable transmitter */
> +        u32 ucr2;
> 
> - hrtimer_try_to_cancel(&sport->trigger_start_tx);
> +        hrtimer_try_to_cancel(&sport->trigger_start_tx);
> 
> -            ucr2 = imx_uart_readl(sport, UCR2);
> -            if (port->rs485.flags & SER_RS485_RTS_AFTER_SEND)
> -                imx_uart_rts_active(sport, &ucr2);
> -            else
> -                imx_uart_rts_inactive(sport, &ucr2);
> -            imx_uart_writel(sport, ucr2, UCR2);
> +        ucr2 = imx_uart_readl(sport, UCR2);
> +        if (port->rs485.flags & SER_RS485_RTS_AFTER_SEND)
> +            imx_uart_rts_active(sport, &ucr2);
> +        else
> +            imx_uart_rts_inactive(sport, &ucr2);
> +        imx_uart_writel(sport, ucr2, UCR2);
> 
> -            imx_uart_start_rx(port);
> +        imx_uart_start_rx(port);
> 
> -            sport->tx_state = OFF;
> -        }
> -    } else {
>          sport->tx_state = OFF;
>      }
>  }
> -- 
> 2.27.0

Your patch is corrupted, all the tabs are turned to spaces and it can
not be applied :(

Please fix up and resend.

thanks,

greg k-h
