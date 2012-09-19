From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 2/2] serial: imx: remove null check of sport in
 suspend/resume function
Date: Wed, 19 Sep 2012 11:37:58 +0800
Message-ID: <20120919033757.GF6460@S2100-06.ap.freescale.net>
References: <1347956099-15257-1-git-send-email-richard.zhao@freescale.com>
 <1347956099-15257-2-git-send-email-richard.zhao@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ch1ehsobe003.messaging.microsoft.com ([216.32.181.183]:24045
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753027Ab2ISDOR (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 18 Sep 2012 23:14:17 -0400
Content-Disposition: inline
In-Reply-To: <1347956099-15257-2-git-send-email-richard.zhao@freescale.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Richard Zhao <richard.zhao@freescale.com>
Cc: linux-serial@vger.kernel.org, alan@linux.intel.com, gregkh@linuxfoundation.org, kernel@pengutronix.de

On Tue, Sep 18, 2012 at 04:14:59PM +0800, Richard Zhao wrote:
> platform_get_drvdata always retrun a valid value after probe succeed.
> 
> It also fixed smatch warnings:
> drivers/tty/serial/imx.c:1376 serial_imx_suspend() warn: variable dereferenced before check 'sport' (see line 1372)
> drivers/tty/serial/imx.c:1392 serial_imx_resume() warn: variable dereferenced before check 'sport' (see line 1388)
> 
> Signed-off-by: Richard Zhao <richard.zhao@freescale.com>

Acked-by: Shawn Guo <shawn.guo@linaro.org>

> ---
>  drivers/tty/serial/imx.c |    6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 49f664f..efeb8be 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -1373,8 +1373,7 @@ static int serial_imx_suspend(struct platform_device *dev, pm_message_t state)
>  	val |= UCR3_AWAKEN;
>  	writel(val, sport->port.membase + UCR3);
>  
> -	if (sport)
> -		uart_suspend_port(&imx_reg, &sport->port);
> +	uart_suspend_port(&imx_reg, &sport->port);
>  
>  	return 0;
>  }
> @@ -1389,8 +1388,7 @@ static int serial_imx_resume(struct platform_device *dev)
>  	val &= ~UCR3_AWAKEN;
>  	writel(val, sport->port.membase + UCR3);
>  
> -	if (sport)
> -		uart_resume_port(&imx_reg, &sport->port);
> +	uart_resume_port(&imx_reg, &sport->port);
>  
>  	return 0;
>  }
> -- 
> 1.7.9.5
> 
> 

