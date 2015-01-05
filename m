From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 05/05] serial: sh-sci: Expose SCIFA/SCIFB CTS pin
Date: Mon, 05 Jan 2015 09:53:22 +0200
Message-ID: <6657739.eAlEu9S4Iu@avalon>
References: <20141217125236.14480.78833.sendpatchset@w520> <20141217125325.14480.79285.sendpatchset@w520>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20141217125325.14480.79285.sendpatchset@w520>
Sender: linux-sh-owner@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-sh@vger.kernel.org, gregkh@linuxfoundation.org, jslaby@suse.cz, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Magnus,

Thank you for the patch.

On Wednesday 17 December 2014 21:53:25 Magnus Damm wrote:
> From: Magnus Damm <damm+renesas@opensource.se>
> 
> Expose CTS pin to serial core for the SCIFA/SCIFB case.
> 
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> ---
> 
>  drivers/tty/serial/sh-sci.c |   17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> --- 0023/drivers/tty/serial/sh-sci.c
> +++ work/drivers/tty/serial/sh-sci.c	2014-12-17 18:46:44.000000000 +0900
> @@ -564,6 +564,11 @@ static void sci_init_pins_default(struct
>  	serial_port_out(port, SCSPTR, status); /* Set RTS = 1 */
>  }
> 
> +static bool sci_cts_asserted_scifab(struct uart_port *port)
> +{
> +	return !(serial_port_in(port, SCPDR) & BIT(3));

Could you please define SCPDR_CTSD to replace BIT(3) ?

> +}
> +
>  static void sci_init_pins_scifab(struct uart_port *port, bool
> hwflow_enabled) {
>  	unsigned short control, data;
> @@ -1304,8 +1309,16 @@ static unsigned int sci_get_mctrl(struct
>  	 * else is wired up. Keep it simple and simply assert DSR/CAR.
>  	 */
> 
> -	if (s->cfg->capabilities & SCIx_HAVE_RTSCTS)
> -		cts_asserted = sci_cts_asserted_default(port);
> + 	if (s->cfg->capabilities & SCIx_HAVE_RTSCTS) {
> +		switch (s->cfg->type) {
> +		case PORT_SCIFA:
> +		case PORT_SCIFB:
> +			cts_asserted = sci_cts_asserted_scifab(port);
> +			break;
> +		default:
> +			cts_asserted = sci_cts_asserted_default(port);
> +		}
> + 	}
> 
>  	return TIOCM_DSR | TIOCM_CAR | (cts_asserted ? TIOCM_CTS : 0);
>  }

-- 
Regards,

Laurent Pinchart

