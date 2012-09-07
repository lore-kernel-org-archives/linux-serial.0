From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 1/2] serial: mxs-auart: fix the wrong setting order
Date: Fri, 7 Sep 2012 10:38:44 +0800
Message-ID: <20120907023841.GF26709@S2101-09.ap.freescale.net>
References: <1346985521-2248-1-git-send-email-shijie8@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:36910 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932152Ab2IGCia (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 6 Sep 2012 22:38:30 -0400
Received: by pbbrr13 with SMTP id rr13so3365480pbb.19
        for <linux-serial@vger.kernel.org>; Thu, 06 Sep 2012 19:38:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1346985521-2248-1-git-send-email-shijie8@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Huang Shijie <shijie8@gmail.com>
Cc: gregkh@linuxfoundation.org, alan@linux.intel.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, Sep 06, 2012 at 10:38:40PM -0400, Huang Shijie wrote:
> After set the AUART_CTRL0_CLKGATE, the UART will gate all the clocks off.
> So the following line will not take effect.
>        ................................................................
>  	writel(AUART_INTR_RXIEN | AUART_INTR_RTIEN | AUART_INTR_CTSMIEN,
>  			u->membase + AUART_INTR_CLR);
>        ................................................................
> 
> To fix this issue, the patch moves this gate-off line to
> the end of setting registers.
> 
> Signed-off-by: Huang Shijie <shijie8@gmail.com>

Acked-by: Shawn Guo <shawn.guo@linaro.org>

Are you experiencing any user visible problem with this bug?

Regards,
Shawn

> ---
>  drivers/tty/serial/mxs-auart.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
> index dafeef2..ea5f888 100644
> --- a/drivers/tty/serial/mxs-auart.c
> +++ b/drivers/tty/serial/mxs-auart.c
> @@ -457,11 +457,11 @@ static void mxs_auart_shutdown(struct uart_port *u)
>  
>  	writel(AUART_CTRL2_UARTEN, u->membase + AUART_CTRL2_CLR);
>  
> -	writel(AUART_CTRL0_CLKGATE, u->membase + AUART_CTRL0_SET);
> -
>  	writel(AUART_INTR_RXIEN | AUART_INTR_RTIEN | AUART_INTR_CTSMIEN,
>  			u->membase + AUART_INTR_CLR);
>  
> +	writel(AUART_CTRL0_CLKGATE, u->membase + AUART_CTRL0_SET);
> +
>  	clk_disable_unprepare(s->clk);
>  }
>  
> -- 
> 1.7.4.4
> 
