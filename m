Return-Path: <SRS0=7071=4A=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A411C3B187
	for <linux-serial@archiver.kernel.org>; Wed, 12 Feb 2020 20:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7264021739
	for <linux-serial@archiver.kernel.org>; Wed, 12 Feb 2020 20:47:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbgBLUro (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 12 Feb 2020 15:47:44 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:46791 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727692AbgBLUro (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 12 Feb 2020 15:47:44 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1j1yv7-0003Ry-OM; Wed, 12 Feb 2020 21:47:41 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1j1yv7-00051K-1O; Wed, 12 Feb 2020 21:47:41 +0100
Date:   Wed, 12 Feb 2020 21:47:40 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     George Hilliard <ghilliard@kopismobile.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>, kernel@pengutronix.de
Subject: Re: [PATCH v3 2/2] tty: imx serial: Implement support for reversing
 TX and RX polarity
Message-ID: <20200212204740.wc4pibfajxgi5tfp@pengutronix.de>
References: <20200212163538.3006-1-ghilliard@kopismobile.com>
 <20200212163538.3006-3-ghilliard@kopismobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200212163538.3006-3-ghilliard@kopismobile.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Feb 12, 2020 at 10:35:38AM -0600, George Hilliard wrote:
> The peripheral has support for inverting its input and/or output
> signals.  This is useful if the hardware flips polarity of the
> peripheral's signal, such as swapped +/- pins on an RS-422 transceiver,
> or an inverting level shifter.  Add support for these control registers
> via the device tree binding.
> 
> Signed-off-by: George Hilliard <ghilliard@kopismobile.com>
> ---
> v1..v2: Remove confidentiality spam
> v2..v3: Set *and* clear register, and do it before TX enable
> 
>  drivers/tty/serial/imx.c | 28 +++++++++++++++++++++++-----
>  1 file changed, 23 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 0c6c63166250..205627bcad66 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -195,6 +195,8 @@ struct imx_port {
>  	unsigned int		have_rtscts:1;
>  	unsigned int		have_rtsgpio:1;
>  	unsigned int		dte_mode:1;
> +	unsigned int		inverted_tx:1;
> +	unsigned int		inverted_rx:1;
>  	struct clk		*clk_ipg;
>  	struct clk		*clk_per;
>  	const struct imx_uart_data *devdata;
> @@ -1335,7 +1337,7 @@ static int imx_uart_startup(struct uart_port *port)
>  	int retval, i;
>  	unsigned long flags;
>  	int dma_is_inited = 0;
> -	u32 ucr1, ucr2, ucr4;
> +	u32 ucr1, ucr2, ucr3, ucr4;
>  
>  	retval = clk_prepare_enable(sport->clk_per);
>  	if (retval)
> @@ -1390,8 +1392,22 @@ static int imx_uart_startup(struct uart_port *port)
>  	ucr4 = imx_uart_readl(sport, UCR4) & ~UCR4_OREN;
>  	if (!sport->dma_is_enabled)
>  		ucr4 |= UCR4_OREN;
> +	if (sport->inverted_rx)
> +		ucr4 |= UCR4_INVR;
> +	else
> +		ucr4 &= ~UCR4_INVR;

Maybe clear UCR4_INVR in the same way as UCR4_OREN is cleared just
above?

>  	imx_uart_writel(sport, ucr4, UCR4);
>  
> +	/*
> +	 * configure tx polarity before enabling tx
> +	 */
> +	ucr3 = imx_uart_readl(sport, UCR3);
> +	if (sport->inverted_tx)
> +		ucr3 |= UCR3_INVT;
> +	else
> +		ucr3 &= ~UCR3_INVT;
> +	imx_uart_writel(sport, ucr3, UCR3);
> +
>  	ucr2 = imx_uart_readl(sport, UCR2) & ~UCR2_ATEN;
>  	ucr2 |= (UCR2_RXEN | UCR2_TXEN);
>  	if (!sport->have_rtscts)
> @@ -1405,10 +1421,6 @@ static int imx_uart_startup(struct uart_port *port)
>  	imx_uart_writel(sport, ucr2, UCR2);
>  
>  	if (!imx_uart_is_imx1(sport)) {

If this complete if block would be moved up, you only need to write this
register once.

> -		u32 ucr3;
> -
> -		ucr3 = imx_uart_readl(sport, UCR3);
> -
>  		ucr3 |= UCR3_DTRDEN | UCR3_RI | UCR3_DCD;
>  
>  		if (sport->dte_mode)

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
