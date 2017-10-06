From: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 04/16] serial: mvebu-uart: support probe of multiple ports
Date: Fri, 06 Oct 2017 14:23:55 +0200
Message-ID: <87poa0foro.fsf@free-electrons.com>
References: <20171006101344.15590-1-miquel.raynal@free-electrons.com>
        <20171006101344.15590-5-miquel.raynal@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171006101344.15590-5-miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> (Miquel
        Raynal's message of "Fri, 6 Oct 2017 12:13:32 +0200")
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Miquel Raynal <miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Allen Yan <yanwei-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Antoine Tenart <antoine.tenart-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wilson Ding <dingwei-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-serial@vger.kernel.org

Hi Miquel,
 
 On ven., oct. 06 2017, Miquel Raynal <miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:

> From: Allen Yan <yanwei-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
>
> Until now, the mvebu-uart driver only supported probing a single UART
> port. However, some platforms have multiple instances of this UART
> controller, and therefore the driver should support multiple ports.
>
> In order to achieve this, we make sure to assign port->line properly,
> instead of hardcoding it to zero.
>
> Signed-off-by: Allen Yan <yanwei-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
> Signed-off-by: Miquel Raynal <miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> ---
>  drivers/tty/serial/mvebu-uart.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/tty/serial/mvebu-uart.c b/drivers/tty/serial/mvebu-uart.c
> index 7e0a3e9fee15..25b11ede3a97 100644
> --- a/drivers/tty/serial/mvebu-uart.c
> +++ b/drivers/tty/serial/mvebu-uart.c
> @@ -560,7 +560,16 @@ static int mvebu_uart_probe(struct platform_device *pdev)
>  		return -EINVAL;
>  	}
>  
> -	port = &mvebu_uart_ports[0];
> +	if (pdev->dev.of_node)
> +		pdev->id = of_alias_get_id(pdev->dev.of_node, "serial");

If the id is retrieved using an of_ function, then I think that the
driver would depend on OF_CONFIG.

Gregory


> +
> +	if (pdev->id >= MVEBU_NR_UARTS) {
> +		dev_err(&pdev->dev, "cannot have more than %d UART ports\n",
> +			MVEBU_NR_UARTS);
> +		return -EINVAL;
> +	}
> +
> +	port = &mvebu_uart_ports[pdev->id];
>  
>  	spin_lock_init(&port->lock);
>  
> @@ -572,7 +581,7 @@ static int mvebu_uart_probe(struct platform_device *pdev)
>  	port->fifosize   = 32;
>  	port->iotype     = UPIO_MEM32;
>  	port->flags      = UPF_FIXED_PORT;
> -	port->line       = 0; /* single port: force line number to  0 */
> +	port->line       = pdev->id;
>  
>  	port->irq        = irq->start;
>  	port->irqflags   = 0;
> -- 
> 2.11.0
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
