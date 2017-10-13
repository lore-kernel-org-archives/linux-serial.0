From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [PATCH v2 04/16] serial: mvebu-uart: support probe of multiple ports
Date: Fri, 13 Oct 2017 11:40:32 +0200
Message-ID: <877evz9yi7.fsf@free-electrons.com>
References: <20171013090200.31034-1-miquel.raynal@free-electrons.com>
        <20171013090200.31034-5-miquel.raynal@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20171013090200.31034-5-miquel.raynal@free-electrons.com> (Miquel
        Raynal's message of "Fri, 13 Oct 2017 11:01:48 +0200")
Sender: linux-gpio-owner@vger.kernel.org
To: Miquel Raynal <miquel.raynal@free-electrons.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Jiri Slaby <jslaby@suse.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Antoine Tenart <antoine.tenart@free-electrons.com>, Nadav Haklai <nadavh@marvell.com>, Wilson Ding <dingwei@marvell.com>, Allen Yan <yanwei@marvell.com>
List-Id: linux-serial@vger.kernel.org

Hi Miquel,
 
 On ven., oct. 13 2017, Miquel Raynal <miquel.raynal@free-electrons.com> wrote:

> -	port = &mvebu_uart_ports[0];
> +	/* Assume that all UART ports have a DT alias or none has */
> +	id = of_alias_get_id(pdev->dev.of_node, "serial");

You stil need to check the pdev->dev.of_node before calling
of_alias_get_id.

Once it will be fixed, you can add:

Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Thanks,

Gregory


> +	if (!pdev->dev.of_node || id < 0)
> +		pdev->id = uart_num_counter++;
> +	else
> +		pdev->id = id;
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
> @@ -572,7 +588,7 @@ static int mvebu_uart_probe(struct platform_device *pdev)
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

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
