From: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 08/16] serial: mvebu-uart: clear state register before IRQ request
Date: Fri, 06 Oct 2017 14:40:47 +0200
Message-ID: <878tgofnzk.fsf@free-electrons.com>
References: <20171006101344.15590-1-miquel.raynal@free-electrons.com>
        <20171006101344.15590-9-miquel.raynal@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171006101344.15590-9-miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> (Miquel
        Raynal's message of "Fri, 6 Oct 2017 12:13:36 +0200")
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Miquel Raynal <miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Allen Yan <yanwei-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Antoine Tenart <antoine.tenart-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wilson Ding <dingwei-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-serial@vger.kernel.org

Hi Miquel,
 
 On ven., oct. 06 2017, Miquel Raynal <miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:

> From: Allen Yan <yanwei-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
>
> When receiving data on RX pin before ->uart_startup() is called, some
> error bits in the state register could be set up (like BRK_DET).
>
> This is harmless when using only the standard UART (error bits are
> read-only), but may procude an endless loop once in the extended UART
                      produce
> RX interrupt handler (error bits must be cleared).
>
> Clear the status register in ->uart_startup() to avoid this situation.
>
> Signed-off-by: Allen Yan <yanwei-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
> Signed-off-by: Miquel Raynal <miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>

Reviewed-by: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>

Thanks,

Gregory


> ---
>  drivers/tty/serial/mvebu-uart.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/tty/serial/mvebu-uart.c b/drivers/tty/serial/mvebu-uart.c
> index 81a3d2714fd3..67f302748b78 100644
> --- a/drivers/tty/serial/mvebu-uart.c
> +++ b/drivers/tty/serial/mvebu-uart.c
> @@ -322,6 +322,12 @@ static int mvebu_uart_startup(struct uart_port *port)
>  	writel(CTRL_TXFIFO_RST | CTRL_RXFIFO_RST,
>  	       port->membase + UART_CTRL(port));
>  	udelay(1);
> +
> +	/* Clear the error bits of state register before IRQ request */
> +	ret = readl(port->membase + UART_STAT);
> +	ret |= STAT_BRK_ERR;
> +	writel(ret, port->membase + UART_STAT);
> +
>  	writel(CTRL_BRK_INT, port->membase + UART_CTRL(port));
>  
>  	ctl = readl(port->membase + UART_INTR(port));
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
