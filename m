Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC365C677F1
	for <linux-serial@archiver.kernel.org>; Mon, 16 Jan 2023 10:30:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbjAPKa0 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 16 Jan 2023 05:30:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjAPKaW (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 16 Jan 2023 05:30:22 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F0691ABD3
        for <linux-serial@vger.kernel.org>; Mon, 16 Jan 2023 02:30:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673865021; x=1705401021;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=yJDfpYIfJ4cNCU+UT6KVDi1+17A4H5SZeqrr9v+j6/o=;
  b=VoojAelrVhu/jBvCIHiGmISwfQ8dI6mR1+F0IZQhB7Fjv43cnNkXHcQA
   LGt7FE4shR7lXRJseEWE+OqFpgmsXdV4hSUDdj5omqMW4uXGU62JHh0Pr
   EjZWvwHXFYGy63iUvLkTesL5gNIByMbeNBI3WUpwbtdfRy4w1pHTQS0bo
   3X1uO7jeeNMDfSP6RGGJbOUb0mX2o35YdVsQAWHr4u/ldTB6JdfYbXv/1
   FV//Qwo220RYHH0RrkcKzvHOgDl1OAjN2x5EtA9iabyaEd+2WzF9MwE78
   g2P1013GuG9fGvBdWVZ6iMRFkkhL9yNkmEO5C89TkIhpbg0NQs/UDzrN3
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10591"; a="323134755"
X-IronPort-AV: E=Sophos;i="5.97,220,1669104000"; 
   d="scan'208";a="323134755"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2023 02:30:20 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10591"; a="747678790"
X-IronPort-AV: E=Sophos;i="5.97,220,1669104000"; 
   d="scan'208";a="747678790"
Received: from xsanroma-mobl.ger.corp.intel.com ([10.252.39.155])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2023 02:30:17 -0800
Date:   Mon, 16 Jan 2023 12:30:11 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Sergey Organov <sorganov@gmail.com>
cc:     linux-serial <linux-serial@vger.kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Richard Genoud <richard.genoud@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Tim Harvey <tharvey@gateworks.com>,
        =?ISO-8859-2?Q?Tomasz_Mo=F1?= <tomasz.mon@camlingroup.com>,
        linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH 1/8] serial: imx: factor-out common code to
 imx_uart_soft_reset()
In-Reply-To: <20230113184334.287130-2-sorganov@gmail.com>
Message-ID: <aa3d9c37-369b-5163-79f6-6dc213e92bc9@linux.intel.com>
References: <87bko4e65y.fsf@osv.gnss.ru> <20230113184334.287130-1-sorganov@gmail.com> <20230113184334.287130-2-sorganov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, 13 Jan 2023, Sergey Organov wrote:

> We perform soft reset in 2 places, slightly differently for no sufficient
> reasons, so move more generic variant to a function, and re-use the code.
> 
> Out of 2 repeat counters, 10 and 100, select 10, as the code works at
> interrupts disabled, and in practice the reset happens immediately.
> 
> Signed-off-by: Sergey Organov <sorganov@gmail.com>
> ---
>  drivers/tty/serial/imx.c | 73 ++++++++++++++++++++--------------------
>  1 file changed, 37 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 757825edb0cd..bf222d8568a9 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -397,6 +397,39 @@ static void start_hrtimer_ms(struct hrtimer *hrt, unsigned long msec)
>         hrtimer_start(hrt, ms_to_ktime(msec), HRTIMER_MODE_REL);
>  }
>  
> +/* called with port.lock taken and irqs off */
> +static void imx_uart_soft_reset(struct imx_port *sport)
> +{
> +	int i = 10;
> +	u32 ucr2, ubir, ubmr, uts;
> +
> +	/*
> +	 * According to the Reference Manual description of the UART SRST bit:
> +	 *
> +	 * "Reset the transmit and receive state machines,
> +	 * all FIFOs and register USR1, USR2, UBIR, UBMR, UBRC, URXD, UTXD
> +	 * and UTS[6-3]".
> +	 *
> +	 * We don't need to restore the old values from USR1, USR2, URXD and
> +	 * UTXD. UBRC is read only, so only save/restore the other three
> +	 * registers.
> +	 */
> +	ubir = imx_uart_readl(sport, UBIR);
> +	ubmr = imx_uart_readl(sport, UBMR);
> +	uts = imx_uart_readl(sport, IMX21_UTS);
> +
> +	ucr2 = imx_uart_readl(sport, UCR2);
> +	imx_uart_writel(sport, ucr2 & ~UCR2_SRST, UCR2);
> +
> +	while (!(imx_uart_readl(sport, UCR2) & UCR2_SRST) && (--i > 0))
> +		udelay(1);

This could use read_poll_timeout_atomic().

-- 
 i.


> +	/* Restore the registers */
> +	imx_uart_writel(sport, ubir, UBIR);
> +	imx_uart_writel(sport, ubmr, UBMR);
> +	imx_uart_writel(sport, uts, IMX21_UTS);
> +}
> +
>  /* called with port.lock taken and irqs off */
>  static void imx_uart_start_rx(struct uart_port *port)
>  {
> @@ -1398,7 +1431,7 @@ static void imx_uart_disable_dma(struct imx_port *sport)
>  static int imx_uart_startup(struct uart_port *port)
>  {
>  	struct imx_port *sport = (struct imx_port *)port;
> -	int retval, i;
> +	int retval;
>  	unsigned long flags;
>  	int dma_is_inited = 0;
>  	u32 ucr1, ucr2, ucr3, ucr4, uts;
> @@ -1430,15 +1463,9 @@ static int imx_uart_startup(struct uart_port *port)
>  		dma_is_inited = 1;
>  
>  	spin_lock_irqsave(&sport->port.lock, flags);
> +
>  	/* Reset fifo's and state machines */
> -	i = 100;
> -
> -	ucr2 = imx_uart_readl(sport, UCR2);
> -	ucr2 &= ~UCR2_SRST;
> -	imx_uart_writel(sport, ucr2, UCR2);
> -
> -	while (!(imx_uart_readl(sport, UCR2) & UCR2_SRST) && (--i > 0))
> -		udelay(1);
> +	imx_uart_soft_reset(sport);
>  
>  	/*
>  	 * Finally, clear and enable interrupts
> @@ -1593,8 +1620,6 @@ static void imx_uart_flush_buffer(struct uart_port *port)
>  {
>  	struct imx_port *sport = (struct imx_port *)port;
>  	struct scatterlist *sgl = &sport->tx_sgl[0];
> -	u32 ucr2;
> -	int i = 100, ubir, ubmr, uts;
>  
>  	if (!sport->dma_chan_tx)
>  		return;
> @@ -1612,32 +1637,8 @@ static void imx_uart_flush_buffer(struct uart_port *port)
>  		sport->dma_is_txing = 0;
>  	}
>  
> -	/*
> -	 * According to the Reference Manual description of the UART SRST bit:
> -	 *
> -	 * "Reset the transmit and receive state machines,
> -	 * all FIFOs and register USR1, USR2, UBIR, UBMR, UBRC, URXD, UTXD
> -	 * and UTS[6-3]".
> -	 *
> -	 * We don't need to restore the old values from USR1, USR2, URXD and
> -	 * UTXD. UBRC is read only, so only save/restore the other three
> -	 * registers.
> -	 */
> -	ubir = imx_uart_readl(sport, UBIR);
> -	ubmr = imx_uart_readl(sport, UBMR);
> -	uts = imx_uart_readl(sport, IMX21_UTS);
> +	imx_uart_soft_reset(sport);
>  
> -	ucr2 = imx_uart_readl(sport, UCR2);
> -	ucr2 &= ~UCR2_SRST;
> -	imx_uart_writel(sport, ucr2, UCR2);
> -
> -	while (!(imx_uart_readl(sport, UCR2) & UCR2_SRST) && (--i > 0))
> -		udelay(1);
> -
> -	/* Restore the registers */
> -	imx_uart_writel(sport, ubir, UBIR);
> -	imx_uart_writel(sport, ubmr, UBMR);
> -	imx_uart_writel(sport, uts, IMX21_UTS);
>  }
>  
>  static void
> 
