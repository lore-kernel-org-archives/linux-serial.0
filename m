From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 1/2] serial: imx: set sport as drvdata, like it's used
 elsewhere
Date: Wed, 19 Sep 2012 11:36:05 +0800
Message-ID: <20120919033600.GE6460@S2100-06.ap.freescale.net>
References: <1347956099-15257-1-git-send-email-richard.zhao@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from va3ehsobe010.messaging.microsoft.com ([216.32.180.30]:48578
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754110Ab2ISDMZ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 18 Sep 2012 23:12:25 -0400
Content-Disposition: inline
In-Reply-To: <1347956099-15257-1-git-send-email-richard.zhao@freescale.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Richard Zhao <richard.zhao@freescale.com>
Cc: linux-serial@vger.kernel.org, alan@linux.intel.com, gregkh@linuxfoundation.org, kernel@pengutronix.de

On Tue, Sep 18, 2012 at 04:14:58PM +0800, Richard Zhao wrote:
> Signed-off-by: Richard Zhao <richard.zhao@freescale.com>

I think it's worth to have a sensible commit log explaining why it
has not trigger any issue.

It happens to work without problem because "struct uart_port port" is
the first member of "struct imx_port".

Otherwise,

Acked-by: Shawn Guo <shawn.guo@linaro.org>

> ---
>  drivers/tty/serial/imx.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 5952b25..49f664f 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -1540,7 +1540,7 @@ static int serial_imx_probe(struct platform_device *pdev)
>  	ret = uart_add_one_port(&imx_reg, &sport->port);
>  	if (ret)
>  		goto deinit;
> -	platform_set_drvdata(pdev, &sport->port);
> +	platform_set_drvdata(pdev, sport);
>  
>  	return 0;
>  deinit:
> -- 
> 1.7.9.5
> 
> 

