From: Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH 2/2] tty: pl011: Work around QDF2400 E44 for earlycon
Date: Tue, 7 Feb 2017 22:07:54 -0600
Message-ID: <35007ccc-678d-0e2a-109b-4b5321c4fbff@codeaurora.org>
References: <20170208005736.18724-1-cov@codeaurora.org>
 <20170208005736.18724-2-cov@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20170208005736.18724-2-cov@codeaurora.org>
Sender: linux-doc-owner@vger.kernel.org
To: Christopher Covington <cov@codeaurora.org>, Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org, shankerd@codeaurora.org, Russell King <linux@armlinux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
Cc: Mark Langsdorf <mlangsdo@redhat.com>, Mark Salter <msalter@redhat.com>, Jon Masters <jcm@redhat.com>, Neil Leeder <nleeder@codeaurora.org>
List-Id: linux-serial@vger.kernel.org

Christopher Covington wrote:
> The previous change worked around QDF2432v1 and QDF2400v1 SoC erratum 44
> for the full-fledged console, when UART AMBA Port (UAP) data is available.
> Additionally provide a workaround the earlycon case, again checking TXFE ==
> 0 instead of BUSY == 1. As earlycon is operating before UAP data is
> available, the implementation is different than in the preceding patch.
>
> Signed-off-by: Christopher Covington <cov@codeaurora.org>
> ---
>   drivers/tty/serial/amba-pl011.c | 28 +++++++++++++++++++++++++++-
>   1 file changed, 27 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
> index 41e51901d6ef..f25e7c994f8e 100644
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c
> @@ -2411,6 +2411,29 @@ static bool qdf2400_e44(void) {
>   	    cpu_var_model == MIDR_QCOM_FALKOR_V1);
>   }
>   
> +#ifdef CONFIG_QCOM_QDF2400_ERRATUM_44
> +static void qdf2400_e44_putc(struct uart_port *port, int c)
> +{
> +	while (readl(port->membase + UART01x_FR) & UART01x_FR_TXFF)
> +		cpu_relax();
> +	if (port->iotype == UPIO_MEM32)
> +		writel(c, port->membase + UART01x_DR);
> +	else
> +		writeb(c, port->membase + UART01x_DR);
I believe 32-bit writes are safe on QDF2400v1, so I think you technically don't 
need the UPIO_MEM32 check.  Just always call writel.
> +	while (!(readl(port->membase + UART01x_FR) & UART011_FR_TXFE))
> +		cpu_relax();
> +}
> +
> +static void qdf2400_e44_early_write(struct console *con, const char *s, unsigned n)
> +{
> +	struct earlycon_device *dev = con->data;
> +
> +	uart_console_write(&dev->port, s, n, qdf2400_e44_putc);
> +}
> +#else
> +#define qdf2400_e44_early_write pl011_early_write
> +#endif
Same with patch 1/2.  If you change qdf2400_e44(), you don't need the #else block.
> +
>   static void pl011_putc(struct uart_port *port, int c)
>   {
>   	while (readl(port->membase + UART01x_FR) & UART01x_FR_TXFF)
> @@ -2436,7 +2459,10 @@ static int __init pl011_early_console_setup(struct earlycon_device *device,
>   	if (!device->port.membase)
>   		return -ENODEV;
>   
> -	device->con->write = pl011_early_write;
> +	if (qdf2400_e44())
> +		device->con->write = qdf2400_e44_early_write;
> +	else
> +		device->con->write = pl011_early_write;
>   	return 0;
>   }
>   OF_EARLYCON_DECLARE(pl011, "arm,pl011", pl011_early_console_setup);


-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, hosted by The Linux Foundation.

