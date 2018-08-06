From: =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Subject: Re: [RFC] serial: sc16is7xx: Use DT sub-nodes for UART ports
Date: Mon, 6 Aug 2018 18:21:39 +0200
Message-ID: <c258d70d-5b9b-77ff-a478-2a96d510d454@suse.de>
References: <CAL_JsqKNnfgESG6ON95D7nD8VNrcVy7-x6cGGnae_GbbGKAuPQ@mail.gmail.com>
 <20180805232651.10605-1-afaerber@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180805232651.10605-1-afaerber@suse.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org, Rob Herring <robh@kernel.org>
Cc: linux-mips@linux-mips.org, jringle@gridpoint.com, allsey87@gmail.com, Jakub Kicinski <kubakici@wp.pl>, Xue Liu <liuxuenetmail@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Am 06.08.2018 um 01:26 schrieb Andreas Färber:
> This is to allow using serdev.
> 
> Signed-off-by: Andreas Färber <afaerber@suse.de>
> ---
>  drivers/tty/serial/sc16is7xx.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
> index 243c96025053..ad7267274f65 100644
> --- a/drivers/tty/serial/sc16is7xx.c
> +++ b/drivers/tty/serial/sc16is7xx.c
> @@ -1213,9 +1213,31 @@ static int sc16is7xx_probe(struct device *dev,
>  			SC16IS7XX_IOCONTROL_SRESET_BIT);
>  
>  	for (i = 0; i < devtype->nr_uart; ++i) {
> +#ifdef CONFIG_OF

Looks like this and below need to be CONFIG_OF_ADDRESS (build failure
reported for sparc).

Regards,
Andreas

> +		struct device_node *np;
> +		struct platform_device *pdev;
> +		char name[6] = "uartx";
> +#endif
> +
>  		s->p[i].line		= i;
>  		/* Initialize port data */
> +#ifdef CONFIG_OF
> +		name[4] = '0' + i;
> +		np = of_get_child_by_name(dev->of_node, name);
> +		if (IS_ERR(np)) {
> +			ret = PTR_ERR(np);
> +			goto out_ports;
> +		}
> +		pdev = of_platform_device_create(np, NULL, dev);
> +		if (IS_ERR(pdev)) {
> +			ret = PTR_ERR(pdev);
> +			goto out_ports;
> +		}
> +		platform_set_drvdata(pdev, dev_get_drvdata(dev));
> +		s->p[i].port.dev	= &pdev->dev;
> +#else
>  		s->p[i].port.dev	= dev;
> +#endif
>  		s->p[i].port.irq	= irq;
>  		s->p[i].port.type	= PORT_SC16IS7XX;
>  		s->p[i].port.fifosize	= SC16IS7XX_FIFO_SIZE;
> @@ -1271,6 +1293,9 @@ static int sc16is7xx_probe(struct device *dev,
>  	for (i--; i >= 0; i--) {
>  		uart_remove_one_port(&sc16is7xx_uart, &s->p[i].port);
>  		clear_bit(s->p[i].port.line, &sc16is7xx_lines);
> +#ifdef CONFIG_OF
> +		of_platform_device_destroy(s->p[i].port.dev, NULL);
> +#endif
>  	}
>  
>  #ifdef CONFIG_GPIOLIB

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
