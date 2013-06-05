From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH -next] serial: omap: fix potential NULL pointer
 dereference in serial_omap_runtime_suspend()
Date: Wed, 5 Jun 2013 08:28:56 -0700
Message-ID: <20130605152856.GS3331@atomide.com>
References: <CAPgLHd-N6jTD_WvT2KgsG8vOtKCtpJET8ddyQBWUMp=qG_3G+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:33791 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756319Ab3FEP3J (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 5 Jun 2013 11:29:09 -0400
Content-Disposition: inline
In-Reply-To: <CAPgLHd-N6jTD_WvT2KgsG8vOtKCtpJET8ddyQBWUMp=qG_3G+Q@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: gregkh@linuxfoundation.org, jslaby@suse.cz, grant.likely@linaro.org, rob.herring@calxeda.com, sourav.poddar@ti.com, yongjun_wei@trendmicro.com.cn, devicetree-discuss@lists.ozlabs.org, linux-serial@vger.kernel.org

* Wei Yongjun <weiyj.lk@gmail.com> [130604 19:10]:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> The dereference to 'up' should be moved below the NULL test.
> Introduced by commit ddd85e225c8885b5e4419b0499ab27100e7c366a
> (serial: omap: prevent runtime PM for "no_console_suspend")

Acked-by: Tony Lindgren <tony@atomide.com>
 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> ---
>  drivers/tty/serial/omap-serial.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
> index 1aaeca8..156b5aa 100644
> --- a/drivers/tty/serial/omap-serial.c
> +++ b/drivers/tty/serial/omap-serial.c
> @@ -1613,6 +1613,9 @@ static int serial_omap_runtime_suspend(struct device *dev)
>  	struct uart_omap_port *up = dev_get_drvdata(dev);
>  	struct omap_uart_port_info *pdata = dev->platform_data;
>  
> +	if (!up)
> +		return -EINVAL;
> +
>  	/*
>  	* When using 'no_console_suspend', the console UART must not be
>  	* suspended. Since driver suspend is managed by runtime suspend,
> @@ -1623,9 +1626,6 @@ static int serial_omap_runtime_suspend(struct device *dev)
>  	    uart_console(&up->port))
>  		return -EBUSY;
>  
> -	if (!up)
> -		return -EINVAL;
> -
>  	if (!pdata)
>  		return 0;
>  
> 
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss
