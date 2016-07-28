From: "Maarten Brock" <m.brock@vanmierlo.com>
Subject: Re: [PATCH 2/2] sc16is7xx: add reading CTS
Date: Thu, 28 Jul 2016 13:16:33 +0200
Message-ID: <20160728131633.df854ec6@kerio.vanmierlo.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Pascal JEAN <epsilonrt@gmail.com>, Greg KH <gregkh@linuxfoundation.org>
Cc: jslaby@suse.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hello Pascal,

If you look at the history of this driver, you'll see that something similar was
present in the past, but was removed because it introduced problems. The problem
is that you can't just call sc16is7xx_port_read() unsynchronized to the worker
thread. And this is related to the device using indirect access through an I2C
or SPI driver with separate interrupts from the UART. There is also more info on
the linux-serial mailing list.

Kind regards,
Maarten Brock

----- Original Message -----
From: Pascal JEAN [mailto:epsilonrt@gmail.com]
To: Greg KH [mailto:gregkh@linuxfoundation.org]
Cc: jslaby@suse.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Sent: Thu, 28 Jul 2016 09:07:36 +0200
Subject: [PATCH 2/2] sc16is7xx: add reading CTS


> Hi Greg,
> 
> Here are changelog for this patch.
> Best Regards
> 
> Changelog:
> 
> sc16is7xx: add reading CTS
> 
> 	This patch adds the possibility to read the actual
> 	status of the CTS input when RTS/CTS handshaking is
> 	not activated (for general purposes).
> 
> 
> Signed-off-by: Pascal JEAN <epsilonrt@gmail.com>
> ---
>  drivers/tty/serial/sc16is7xx.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
> index 3e65079..8833a18 100644
> --- a/drivers/tty/serial/sc16is7xx.c
> +++ b/drivers/tty/serial/sc16is7xx.c
> @@ -818,10 +818,19 @@ static unsigned int sc16is7xx_tx_empty(struct
> uart_port *port)
> 
>  static unsigned int sc16is7xx_get_mctrl(struct uart_port *port)
>  {
> -	/* DCD and DSR are not wired and CTS/RTS is handled automatically
> -	 * so just indicate all inputs asserted
> -	 */
> -	return TIOCM_DSR | TIOCM_CAR | TIOCM_RI | TIOCM_CTS;
> +	/* DCD, DSR and RI are not wired so just indicate asserted */
> +	unsigned int mctrl = TIOCM_CAR | TIOCM_DSR | TIOCM_RI;
> +
> +	if (port->status & UPSTAT_CTS_ENABLE)
> +		/* CTS handled automatically, indicates that it is always
> +		 * asserted, this is required for proper management of
> +		 * the upper layer
> +		 */
> +		mctrl |= TIOCM_CTS;
> +	else {
> +		/* CTS is not managed automatically, returns its actual state
> +		 * the upper layer
> +		 */
> +		u8 msr = sc16is7xx_port_read(port, SC16IS7XX_MSR_REG);
> +
> +		mctrl |= (msr & SC16IS7XX_MSR_CTS_BIT) ? TIOCM_CTS : 0;
> +	}
> +	return mctrl;
>  }
> 
>  static void sc16is7xx_set_mctrl(struct uart_port *port, unsigned int mctrl)
> -- 
> 2.7.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-serial" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
