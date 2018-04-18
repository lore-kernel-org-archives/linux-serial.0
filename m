From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] serial: imx: warn user when using unsupported
 configuration
Date: Wed, 18 Apr 2018 15:46:19 +0200
Message-ID: <20180418134619.xubgmbiezzlzbay3@pengutronix.de>
References: <20180418133217.14568-1-stefan@agner.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180418133217.14568-1-stefan@agner.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan Agner <stefan@agner.ch>
Cc: gregkh@linuxfoundation.org, lukas@wunner.de, jslaby@suse.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hello Stefan,

On Wed, Apr 18, 2018 at 03:32:17PM +0200, Stefan Agner wrote:
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 91f3a1a5cb7f..1ba7e98ddc76 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -1833,6 +1833,10 @@ static int imx_uart_rs485_config(struct uart_port *port,
>  		rs485conf->flags &= ~SER_RS485_ENABLED;
>  
>  	if (rs485conf->flags & SER_RS485_ENABLED) {
> +		/* Enable receiver if low-active RTS signal is requested */
> +		if (rs485conf->flags & SER_RS485_RTS_AFTER_SEND)
> +			rs485conf->flags |= SER_RS485_RX_DURING_TX;
> +

this is wrong if RTS is driven by a GPIO.

>  		/* disable transmitter */
>  		ucr2 = imx_uart_readl(sport, UCR2);
>  		if (rs485conf->flags & SER_RS485_RTS_AFTER_SEND)
> @@ -2265,6 +2269,17 @@ static int imx_uart_probe(struct platform_device *pdev)
>  	    (!sport->have_rtscts && !sport->have_rtsgpio))
>  		dev_err(&pdev->dev, "no RTS control, disabling rs485\n");
>  
> +	/*
> +	 * The RTS (CTS_B) signal cannot be set low during transmission
> +	 * in case the receiver is off (limitation of the i.MX UART IP).
> +	 */
> +	if (sport->port.rs485.flags & SER_RS485_ENABLED && sport->have_rtscts &&
> +	    (!(sport->port.rs485.flags & SER_RS485_RTS_ON_SEND) &&
> +	     !(sport->port.rs485.flags & SER_RS485_RX_DURING_TX)))
> +		dev_err(&pdev->dev,
> +			"low-active RTS not possible when receiver is off, "
> +			"enabling receiver\n");

If you have the choice between breaking a user visible string and a code
line >80 chars, please pick the latter.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
