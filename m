From: Jakub =?UTF-8?B?S2ljacWEc2tp?= <moorray3@wp.pl>
Subject: Re: [PATCH v3 03/10] drivers: PL011: refactor pl011_shutdown()
Date: Sun, 12 Apr 2015 11:19:26 +0200
Message-ID: <20150412111926.21f513bf@north>
References: <1428578961-6896-1-git-send-email-andre.przywara@arm.com>
 <1428578961-6896-4-git-send-email-andre.przywara@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1428578961-6896-4-git-send-email-andre.przywara@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Andre Przywara <andre.przywara@arm.com>
Cc: rob.herring@linaro.org, arnd@arndb.de, Greg KH <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, rmk+kernel@arm.linux.org.uk, Jiri Slaby <jslaby@suse.cz>, Dave.Martin@arm.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Thu,  9 Apr 2015 12:29:14 +0100, Andre Przywara wrote:
> Split the pl011_shutdown() function into smaller chunks to allow
> easier reuse later when adding SBSA support.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  drivers/tty/serial/amba-pl011.c |   58 ++++++++++++++++++++++-----------------
>  1 file changed, 33 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
> index d6a081e..9eb6d13 100644
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c
> @@ -1635,34 +1635,15 @@ static void pl011_shutdown_channel(struct uart_amba_port *uap,
>        writew(val, uap->port.membase + lcrh);
>  }
>  
> -static void pl011_shutdown(struct uart_port *port)
> +/*
> + * disable the port. It should not disable RTS and DTR.
> + * Also RTS and DTR state should be preserved to restore
> + * it during startup().
> + */
> +static void pl011_disable_uart(struct uart_amba_port *uap)
>  {
> -	struct uart_amba_port *uap =
> -	    container_of(port, struct uart_amba_port, port);
>  	unsigned int cr;
>  
> -	/*
> -	 * disable all interrupts
> -	 */
> -	spin_lock_irq(&uap->port.lock);
> -	uap->im = 0;
> -	writew(uap->im, uap->port.membase + UART011_IMSC);
> -	writew(0xffff, uap->port.membase + UART011_ICR);
> -	spin_unlock_irq(&uap->port.lock);
> -
> -	pl011_dma_shutdown(uap);
> -
> -	/*
> -	 * Free the interrupt
> -	 */
> -	free_irq(uap->port.irq, uap);
> -
> -	/*
> -	 * disable the port
> -	 * disable the port. It should not disable RTS and DTR.
> -	 * Also RTS and DTR state should be preserved to restore
> -	 * it during startup().
> -	 */
>  	uap->autorts = false;
>  	spin_lock_irq(&uap->port.lock);
>  	cr = readw(uap->port.membase + UART011_CR);
> @@ -1678,6 +1659,33 @@ static void pl011_shutdown(struct uart_port *port)
>  	pl011_shutdown_channel(uap, uap->lcrh_rx);
>  	if (uap->lcrh_rx != uap->lcrh_tx)
>  		pl011_shutdown_channel(uap, uap->lcrh_tx);
> +}
> +
> +static void pl011_disable_interrupts(struct uart_amba_port *uap)
> +{
> +	spin_lock_irq(&uap->port.lock);
> +	/*
> +	 * mask all interrupts and clear all pending ones
> +	 */

No need for a multi-line comment here.

> +	uap->im = 0;
> +	writew(uap->im, uap->port.membase + UART011_IMSC);
> +	writew(0xffff & ~UART011_TXIS, uap->port.membase + UART011_ICR);

The line you removed was:
	writew(0xffff, uap->port.membase + UART011_ICR);

Please rebase more carefully.
