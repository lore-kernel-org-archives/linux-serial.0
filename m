From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [PATCH 06/16] serial: mvebu-uart: add soft reset at probe
Date: Fri, 06 Oct 2017 14:33:03 +0200
Message-ID: <87h8vcfocg.fsf@free-electrons.com>
References: <20171006101344.15590-1-miquel.raynal@free-electrons.com>
        <20171006101344.15590-7-miquel.raynal@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20171006101344.15590-7-miquel.raynal@free-electrons.com> (Miquel
        Raynal's message of "Fri, 6 Oct 2017 12:13:34 +0200")
Sender: linux-gpio-owner@vger.kernel.org
To: Miquel Raynal <miquel.raynal@free-electrons.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Jiri Slaby <jslaby@suse.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, devicetree@vger.kernel.org, Allen Yan <yanwei@marvell.com>, Antoine Tenart <antoine.tenart@free-electrons.com>, Nadav Haklai <nadavh@marvell.com>, linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, Wilson Ding <dingwei@marvell.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Hi Miquel,
 
 On ven., oct. 06 2017, Miquel Raynal <miquel.raynal@free-electrons.com> wrote:

> From: Allen Yan <yanwei@marvell.com>
>
> The existing UART driver relies on the bootloader to initialize the
> port(s). However, the secondary uart port may not be initialized
> properly in early boot stage. This patch adds the UART soft reset when
> probing, for all ports.
>
> Signed-off-by: Allen Yan <yanwei@marvell.com>
> Signed-off-by: Miquel Raynal <miquel.raynal@free-electrons.com>

Reviewed-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Thanks,

Gregory


> ---
>  drivers/tty/serial/mvebu-uart.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/tty/serial/mvebu-uart.c b/drivers/tty/serial/mvebu-uart.c
> index 82438884af1e..da756cfec0bb 100644
> --- a/drivers/tty/serial/mvebu-uart.c
> +++ b/drivers/tty/serial/mvebu-uart.c
> @@ -653,6 +653,11 @@ static int mvebu_uart_probe(struct platform_device *pdev)
>  	port->private_data = mvuart;
>  	platform_set_drvdata(pdev, mvuart);
>  
> +	/* UART Soft Reset*/
> +	writel(CTRL_SOFT_RST, port->membase + UART_CTRL(port));
> +	udelay(1);
> +	writel(0, port->membase + UART_CTRL(port));
> +
>  	ret = uart_add_one_port(&mvebu_uart_driver, port);
>  	if (ret)
>  		return ret;
> -- 
> 2.11.0
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
