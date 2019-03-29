From: Ahmad Fatoum <a.fatoum@pengutronix.de>
Subject: Re: [PATCH v2 4/9] serial: 8250: add support for rs485 RTS delays in
 microseconds
Date: Fri, 29 Mar 2019 15:36:33 +0100
Message-ID: <fbafc165-e637-8041-e88d-f4aabe690422@pengutronix.de>
References: <20190221171758.10322-1-martin.kepplinger@ginzinger.com>
 <20190221171758.10322-4-martin.kepplinger@ginzinger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190221171758.10322-4-martin.kepplinger@ginzinger.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Martin Kepplinger <martin.kepplinger@ginzinger.com>, gregkh@linuxfoundation.org, robh+dt@kernel.org, mark.rutland@arm.com, jslaby@suse.com, corbet@lwn.net, richard.genoud@gmail.com, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com
Cc: linux-kernel@vger.kernel.org, kernel@pengutronix.de
List-Id: linux-serial@vger.kernel.org

On 21/2/19 18:17, Martin Kepplinger wrote:
> Read struct serial_rs485's flag SER_RS485_DELAY_IN_USEC and apply the delay
> accordingly.
> 
> Signed-off-by: Martin Kepplinger <martin.kepplinger@ginzinger.com>
> ---
>  drivers/tty/serial/8250/8250_omap.c | 13 +++++++++++--
>  drivers/tty/serial/8250/8250_port.c | 25 +++++++++++++++++++++----
>  2 files changed, 32 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
> index 0a8316632d75..cbce43ac60b1 100644
> --- a/drivers/tty/serial/8250/8250_omap.c
> +++ b/drivers/tty/serial/8250/8250_omap.c
> @@ -720,8 +720,17 @@ static int omap_8250_rs485_config(struct uart_port *port,
>  	struct uart_8250_port *up = up_to_u8250p(port);
>  
>  	/* Clamp the delays to [0, 100ms] */
> -	rs485->delay_rts_before_send = min(rs485->delay_rts_before_send, 100U);
> -	rs485->delay_rts_after_send  = min(rs485->delay_rts_after_send, 100U);
> +	if (rs485->flags & SER_RS485_DELAY_IN_USEC) {
> +		rs485->delay_rts_before_send = min(rs485->delay_rts_before_send,
> +						   100000U);
> +		rs485->delay_rts_after_send  = min(rs485->delay_rts_after_send,
> +						   100000U);
> +	} else {
> +		rs485->delay_rts_before_send = min(rs485->delay_rts_before_send,
> +						   100U);
> +		rs485->delay_rts_after_send  = min(rs485->delay_rts_after_send,
> +						   100U);
> +	}
>  
>  	port->rs485 = *rs485;
>  
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index d2f3310abe54..0cee4aa8323d 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -1483,6 +1483,15 @@ static void start_hrtimer_ms(struct hrtimer *hrt, unsigned long msec)
>  	hrtimer_start(hrt, t, HRTIMER_MODE_REL);
>  }
>  
> +static void start_hrtimer_us(struct hrtimer *hrt, unsigned long usec)
> +{
> +	long sec = usec / 1000000;
> +	long nsec = (usec % 1000000) * 1000000000;

This 1e9 should be 1000 ("NSEC_PER_USEC").
While at it you might want to use USEC_PER_SEC (and MSEC_PER_SEC
above) to make the code more readable.

Cheers
Ahmad

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
