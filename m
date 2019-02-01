From: Corentin Labbe <clabbe.montjoie@gmail.com>
Subject: Re: [PATCH] tty: serial: meson_uart: Add support for kernel debugger
Date: Fri, 1 Feb 2019 11:10:56 +0100
Message-ID: <20190201101056.GA10039@Red>
References: <1549015162-17418-1-git-send-email-jmasson@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1549015162-17418-1-git-send-email-jmasson@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Julien Masson <jmasson@baylibre.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kevin Hilman <khilman@baylibre.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Fri, Feb 01, 2019 at 10:59:22AM +0100, Julien Masson wrote:
> The kgdb invokes the poll_put_char and poll_get_char when communicating
> with the host. This patch implement the serial polling hooks for the
> meson_uart to be used for KGDB debugging over serial line.
> 
> Signed-off-by: Julien Masson <jmasson@baylibre.com>
> ---
> It has been tested on "Le Potato" board:
> https://libre.computer/products/boards/aml-s905x-cc/
> 
> Kernel command line arguments:
> kgdboc=ttyAML0,115200 kgdbretry=4 nokaslr kgdbcon
> 
> Kernel modules:
> CONFIG_DEBUG_INFO=y
> CONFIG_DEBUG_KERNEL=y
> CONFIG_FRAME_POINTER=y
> CONFIG_KGDB=y
> CONFIG_KGDB_SERIAL_CONSOLE=y
> 
> Warning: for single step instruction I had to apply this patch:
> https://lore.kernel.org/patchwork/patch/562423/
> 
>  drivers/tty/serial/meson_uart.c | 46 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
> 
> diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
> index 8a84259..49b20da 100644
> --- a/drivers/tty/serial/meson_uart.c
> +++ b/drivers/tty/serial/meson_uart.c
> @@ -426,6 +426,48 @@ static void meson_uart_config_port(struct uart_port *port, int flags)
>  	}
>  }
>  
> +#ifdef CONFIG_CONSOLE_POLL
> +/*
> + * Console polling routines for writing and reading from the uart while
> + * in an interrupt or debug context (i.e. kgdb).
> + */
> +
> +static int meson_uart_poll_get_char(struct uart_port *port)
> +{
> +	u32 c;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&port->lock, flags);
> +
> +	if (readl(port->membase + AML_UART_STATUS) & AML_UART_RX_EMPTY)
> +		c = NO_POLL_CHAR;
> +	else
> +		c = readl(port->membase + AML_UART_RFIFO);
> +
> +	spin_unlock_irqrestore(&port->lock, flags);
> +
> +	return c;
> +}
> +
> +static void meson_uart_poll_put_char(struct uart_port *port, unsigned char c)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&port->lock, flags);
> +
> +	while (!(readl(port->membase + AML_UART_STATUS) & AML_UART_TX_EMPTY))
> +		cpu_relax();

Hello

Perhaps you could use read_poll_timeout() ?
This will also permit to handle the timeout case.

Regards
