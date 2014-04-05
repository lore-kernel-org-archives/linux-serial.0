From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] serial: amba-pl011: fix regression, causing an Oops on
	rmmod
Date: Sat, 5 Apr 2014 16:19:26 +0100
Message-ID: <20140405151926.GK7528@n2100.arm.linux.org.uk>
References: <Pine.LNX.4.64.1404051629050.3518@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:51241 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752883AbaDEPT7 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 5 Apr 2014 11:19:59 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1404051629050.3518@axis700.grange>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-arm-kernel@lists.infradead.org, Greg KH <greg@kroah.com>, linux-serial@vger.kernel.org, Tushar Behera <tushar.behera@linaro.org>

ROTFL.  What did I say about this solution... seems I was right all
along.

On Sat, Apr 05, 2014 at 04:31:08PM +0200, Guennadi Liakhovetski wrote:
> A recent commit ef2889f7ffee67f0aed49e854c72be63f1466759 "serial: pl011:
> Move uart_register_driver call to device probe" introduced a regression,
> causing the pl011 driver to Oops if more than 1 port have been probed. Fix
> the Oops by only calling uart_unregister_driver() once after the last port
> has been removed.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
>  drivers/tty/serial/amba-pl011.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
> index d4eda24..07325f2 100644
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c
> @@ -2176,6 +2176,7 @@ static int pl011_probe(struct amba_device *dev, const struct amba_id *id)
>  static int pl011_remove(struct amba_device *dev)
>  {
>  	struct uart_amba_port *uap = amba_get_drvdata(dev);
> +	bool busy = false;
>  	int i;
>  
>  	uart_remove_one_port(&amba_reg, &uap->port);
> @@ -2183,9 +2184,12 @@ static int pl011_remove(struct amba_device *dev)
>  	for (i = 0; i < ARRAY_SIZE(amba_ports); i++)
>  		if (amba_ports[i] == uap)
>  			amba_ports[i] = NULL;
> +		else if (amba_ports[i])
> +			busy = true;
>  
>  	pl011_dma_remove(uap);
> -	uart_unregister_driver(&amba_reg);
> +	if (!busy)
> +		uart_unregister_driver(&amba_reg);
>  	return 0;
>  }
>  
> -- 
> 1.9.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
