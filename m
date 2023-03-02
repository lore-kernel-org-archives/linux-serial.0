Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52393C7EE2F
	for <linux-serial@archiver.kernel.org>; Thu,  2 Mar 2023 15:35:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjCBPfZ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 2 Mar 2023 10:35:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjCBPfY (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 2 Mar 2023 10:35:24 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C40552ED7B
        for <linux-serial@vger.kernel.org>; Thu,  2 Mar 2023 07:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677771323; x=1709307323;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=yUdGTSfZhsfne6GGW1+NA0x7tqzegGifwzGQrd0iHuE=;
  b=FXdDj1wp8vL5kIYMFSr5SCqVLAMGXtHD1d14+3EFtPF383FGzreAMk8f
   zWRFS9coxZbBOUpf/0cMwJkR0ChChRRqrBWT7s5+r0jaTO0qx0YU3wLk7
   9TIheoc1zByJttVpoxDVKVt3s01pvgKDNHp8+JfArNEeDfZEDfNdQg5/O
   HwmvFcYs0QHOqCFqDbDdwY3AuVTm6btbwIWWAqzaj6uhOteNTRkmMaSpw
   XwfFFhFlXUxq4x5yFr9S4F6eAoqW7m2exQA4GzTp/BaJP3+GzRZWI4HyV
   BPoIoq9Fi5h3yHgA3ONYs3xYuJ9Bn7uDpkr2FJwDYD8XnLVlDcRsOPvQo
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="362345088"
X-IronPort-AV: E=Sophos;i="5.98,228,1673942400"; 
   d="scan'208";a="362345088"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2023 07:35:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="624996571"
X-IronPort-AV: E=Sophos;i="5.98,228,1673942400"; 
   d="scan'208";a="624996571"
Received: from pawellew-mobl1.ger.corp.intel.com ([10.252.46.79])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2023 07:35:20 -0800
Date:   Thu, 2 Mar 2023 17:35:17 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-serial <linux-serial@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] serial: imx: Drop a few unneeded casts
In-Reply-To: <20230302115417.1860210-1-u.kleine-koenig@pengutronix.de>
Message-ID: <6e66bc69-52b7-bea5-1e2c-ad5ed819a6@linux.intel.com>
References: <20230302115417.1860210-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-201369551-1677771109=:2066"
Content-ID: <53e2651-9dbc-704-78d9-563097fb4ec3@linux.intel.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-201369551-1677771109=:2066
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <a8acd0b1-c676-79e1-2149-735d7fc472d2@linux.intel.com>

On Thu, 2 Mar 2023, Uwe Kleine-König wrote:

> There is no point in casting a struct uart_port to a struct imx_port
> just to access the first member of the latter (a struct uart_port).
> 
> This introduces code changes.

I don't know what this sentence is supposed to mean (did you forgot to 
add a negation into it)?

The code changes :-) are okay though:

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>


-- 
 i.

> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/tty/serial/imx.c | 17 ++++++-----------
>  1 file changed, 6 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 523f296d5747..84bc0e768726 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -1808,9 +1808,7 @@ imx_uart_set_termios(struct uart_port *port, struct ktermios *termios,
>  
>  static const char *imx_uart_type(struct uart_port *port)
>  {
> -	struct imx_port *sport = (struct imx_port *)port;
> -
> -	return sport->port.type == PORT_IMX ? "IMX" : NULL;
> +	return port->type == PORT_IMX ? "IMX" : NULL;
>  }
>  
>  /*
> @@ -1818,10 +1816,8 @@ static const char *imx_uart_type(struct uart_port *port)
>   */
>  static void imx_uart_config_port(struct uart_port *port, int flags)
>  {
> -	struct imx_port *sport = (struct imx_port *)port;
> -
>  	if (flags & UART_CONFIG_TYPE)
> -		sport->port.type = PORT_IMX;
> +		port->type = PORT_IMX;
>  }
>  
>  /*
> @@ -1832,20 +1828,19 @@ static void imx_uart_config_port(struct uart_port *port, int flags)
>  static int
>  imx_uart_verify_port(struct uart_port *port, struct serial_struct *ser)
>  {
> -	struct imx_port *sport = (struct imx_port *)port;
>  	int ret = 0;
>  
>  	if (ser->type != PORT_UNKNOWN && ser->type != PORT_IMX)
>  		ret = -EINVAL;
> -	if (sport->port.irq != ser->irq)
> +	if (port->irq != ser->irq)
>  		ret = -EINVAL;
>  	if (ser->io_type != UPIO_MEM)
>  		ret = -EINVAL;
> -	if (sport->port.uartclk / 16 != ser->baud_base)
> +	if (port->uartclk / 16 != ser->baud_base)
>  		ret = -EINVAL;
> -	if (sport->port.mapbase != (unsigned long)ser->iomem_base)
> +	if (port->mapbase != (unsigned long)ser->iomem_base)
>  		ret = -EINVAL;
> -	if (sport->port.iobase != ser->port)
> +	if (port->iobase != ser->port)
>  		ret = -EINVAL;
>  	if (ser->hub6 != 0)
>  		ret = -EINVAL;
> 
--8323329-201369551-1677771109=:2066--
