From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH v2 1/3] tty: Introduce UART_CAP_HW485
Date: Sat, 7 Nov 2015 07:22:29 -0500
Message-ID: <563DED05.9010004@hurleysoftware.com>
References: <1446890976-1817-1-git-send-email-matwey@sai.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1446890976-1817-1-git-send-email-matwey@sai.msu.ru>
Sender: linux-kernel-owner@vger.kernel.org
To: "Matwey V. Kornilov" <matwey@sai.msu.ru>
Cc: gregkh@linuxfoundation.org, jslaby@suse.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, matwey.kornilov@gmail.com
List-Id: linux-serial@vger.kernel.org

On 11/07/2015 05:09 AM, Matwey V. Kornilov wrote:
> Introduce new capability UART_CAP_HW485 to mark 8250 UARTs which have
> hardware support of line direction control.

Since capabilities are not exported to user-space, how will user-space
know if the port only provides emulated 485 (eg., where only HW485 is
acceptable)?

Regards,
Peter Hurley

> Signed-off-by: Matwey V. Kornilov <matwey@sai.msu.ru>
> ---
> Changes since v1:
>  - Commit message has been wrapped
> 
>  drivers/tty/serial/8250/8250.h         | 1 +
>  drivers/tty/serial/8250/8250_fintek.c  | 1 +
>  drivers/tty/serial/8250/8250_lpc18xx.c | 1 +
>  drivers/tty/serial/8250/8250_pci.c     | 1 +
>  4 files changed, 4 insertions(+)
> 
> diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
> index d54dcd8..92a4f47 100644
> --- a/drivers/tty/serial/8250/8250.h
> +++ b/drivers/tty/serial/8250/8250.h
> @@ -69,6 +69,7 @@ struct serial8250_config {
>  	unsigned int	flags;
>  };
>  
> +#define UART_CAP_HW485	(1 << 7)	/* UART has hardware direction control for RS485 */
>  #define UART_CAP_FIFO	(1 << 8)	/* UART has FIFO */
>  #define UART_CAP_EFR	(1 << 9)	/* UART has EFR */
>  #define UART_CAP_SLEEP	(1 << 10)	/* UART has IER sleep */
> diff --git a/drivers/tty/serial/8250/8250_fintek.c b/drivers/tty/serial/8250/8250_fintek.c
> index 8947439..f2831a8 100644
> --- a/drivers/tty/serial/8250/8250_fintek.c
> +++ b/drivers/tty/serial/8250/8250_fintek.c
> @@ -208,6 +208,7 @@ fintek_8250_probe(struct pnp_dev *dev, const struct pnp_device_id *dev_id)
>  	uart.port.iobase = pnp_port_start(dev, 0);
>  	uart.port.iotype = UPIO_PORT;
>  	uart.port.rs485_config = fintek_8250_rs485_config;
> +	uart.capabilities = UART_CAP_HW485;
>  
>  	uart.port.flags |= UPF_SKIP_TEST | UPF_BOOT_AUTOCONF;
>  	if (pnp_irq_flags(dev, 0) & IORESOURCE_IRQ_SHAREABLE)
> diff --git a/drivers/tty/serial/8250/8250_lpc18xx.c b/drivers/tty/serial/8250/8250_lpc18xx.c
> index 99cd478..9d30276 100644
> --- a/drivers/tty/serial/8250/8250_lpc18xx.c
> +++ b/drivers/tty/serial/8250/8250_lpc18xx.c
> @@ -175,6 +175,7 @@ static int lpc18xx_serial_probe(struct platform_device *pdev)
>  	uart.port.private_data = data;
>  	uart.port.rs485_config = lpc18xx_rs485_config;
>  	uart.port.serial_out = lpc18xx_uart_serial_out;
> +	uart.capabilities = UART_CAP_HW485;
>  
>  	uart.dma = &data->dma;
>  	uart.dma->rxconf.src_maxburst = 1;
> diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
> index 4097f3f..c7c0ae9 100644
> --- a/drivers/tty/serial/8250/8250_pci.c
> +++ b/drivers/tty/serial/8250/8250_pci.c
> @@ -1599,6 +1599,7 @@ static int pci_fintek_setup(struct serial_private *priv,
>  	port->port.iotype = UPIO_PORT;
>  	port->port.iobase = iobase;
>  	port->port.rs485_config = pci_fintek_rs485_config;
> +	port->capabilities = UART_CAP_HW485;
>  
>  	data = devm_kzalloc(&pdev->dev, sizeof(u8), GFP_KERNEL);
>  	if (!data)
> 
