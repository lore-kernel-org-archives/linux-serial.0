From: Jakub =?UTF-8?B?S2ljacWEc2tp?= <moorray3@wp.pl>
Subject: Re: [PATCH 3/3] tty: serial: fsl_lpuart: Add support for RS-485
Date: Fri, 29 May 2015 12:18:08 +0200
Message-ID: <20150529121808.27346afc@north>
References: <1432886754-30115-1-git-send-email-bhuvanchandra.dv@toradex.com>
	<1432886754-30115-4-git-send-email-bhuvanchandra.dv@toradex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1432886754-30115-4-git-send-email-bhuvanchandra.dv@toradex.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, stefan@agner.ch, shawn.guo@linaro.org, kernel@pengutronix.de, jslaby@suse.cz, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, bhuvanchandra.dv@gmail.com
List-Id: linux-serial@vger.kernel.org

On Fri, 29 May 2015 13:35:54 +0530, Bhuvanchandra DV wrote:
> Enable Vybrid's build-in support for RS-485 auto RTS for
> controlling line direction of RS-485 transceiver driver.
> 
> Signed-off-by: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
> ---
>  drivers/tty/serial/fsl_lpuart.c | 60 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 60 insertions(+)
> 
> diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
> index 357f623..c553b14 100644
> --- a/drivers/tty/serial/fsl_lpuart.c
> +++ b/drivers/tty/serial/fsl_lpuart.c
> @@ -820,6 +820,50 @@ static unsigned int lpuart32_tx_empty(struct uart_port *port)
>  		TIOCSER_TEMT : 0;
>  }
>  
> +static int lpuart_config_rs485(struct uart_port *port,
> +			struct serial_rs485 *rs485)
> +{
> +	struct lpuart_port *sport = container_of(port,
> +			struct lpuart_port, port);
> +	u8 modem = readb(sport->port.membase + UARTMODEM) &
> +		~(UARTMODEM_TXRTSPOL | UARTMODEM_TXRTSE);

Please put empty line between variables and code.

> +	writeb(modem, sport->port.membase + UARTMODEM);
> +
> +	if (rs485->flags & SER_RS485_ENABLED) {
> +		/* Enable auto RS-485 RTS mode */
> +		modem |= UARTMODEM_TXRTSE;
> +
> +		/*
> +		* RTS needs to be logic HIGH either during transer _or_ after
> +		* transfer, other variants are not supported by the hardware.
> +		*/

Indentation is off here.  '*' should be aligned.

> +		if (!(rs485->flags & (SER_RS485_RTS_ON_SEND |
> +				SER_RS485_RTS_AFTER_SEND)))

and here - things should be aligned on the containing bracket (SER_
under SER_ here).

> +			rs485->flags |= SER_RS485_RTS_ON_SEND;
> +
> +		if (rs485->flags & SER_RS485_RTS_ON_SEND &&
> +				rs485->flags & SER_RS485_RTS_AFTER_SEND)

and here - same bracket rule (rs485-> under rs485->)

> +			rs485->flags &= ~SER_RS485_RTS_AFTER_SEND;
> +
> +		/*
> +		* The hardware defaults to RTS logic HIGH while transfer.
> +		* Switch polarity in case RTS shall be logic HIGH
> +		* after transfer.
> +		* Note: UART is assumed to be active high.
> +		*/
> +		if (rs485->flags & SER_RS485_RTS_ON_SEND)
> +			modem &= ~UARTMODEM_TXRTSPOL;

UARTMODEM_TXRTSPOL was already clear when you read modem.

> +		else if (rs485->flags & SER_RS485_RTS_AFTER_SEND)
> +			modem |= UARTMODEM_TXRTSPOL;
> +	}
> +
> +	/* Store the new configuration */
> +	sport->port.rs485 = *rs485;
> +
> +	writeb(modem, sport->port.membase + UARTMODEM);
> +	return 0;
> +}
> +
>  static unsigned int lpuart_get_mctrl(struct uart_port *port)
>  {
>  	return TIOCM_CAR | TIOCM_CTS | TIOCM_DSR;
[...]
> @@ -1802,6 +1854,14 @@ static int lpuart_probe(struct platform_device *pdev)
>  		dev_info(sport->port.dev, "DMA rx channel request failed, "
>  				"operating without rx DMA\n");
>  
> +	if (of_property_read_bool(np, "linux,rs485-enabled-at-boot-time")) {
> +		sport->port.rs485.flags |= SER_RS485_ENABLED;
> +		sport->port.rs485.flags |= SER_RS485_RTS_ON_SEND;
> +		writeb(UARTMODEM_TXRTSE, sport->port.membase + UARTMODEM);
> +	} else {
> +		sport->port.rs485.flags &= ~SER_RS485_ENABLED;

Why the need to clear the flag?  sport was kzalloc'ed.
