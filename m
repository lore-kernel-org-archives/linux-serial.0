From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] serial: max310x: turn off transmitter before activating
 AutoCTS or auto transmitter flow control
Date: Wed, 4 Sep 2019 09:30:22 +0200
Message-ID: <20190904073022.GB9729@kroah.com>
References: <bd9fb8e75d0e45218eb110c25bb539ef@SSSDEEX.i.sigma-surface-science.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <bd9fb8e75d0e45218eb110c25bb539ef@SSSDEEX.i.sigma-surface-science.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph =?iso-8859-1?Q?Vogtl=E4nder?= <Christoph.Vogtlaender@sigma-surface-science.com>
Cc: Jiri Slaby <jslaby@suse.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Fri, Aug 30, 2019 at 09:58:41AM +0000, Christoph Vogtländer wrote:
> As documented in the data-sheet, the transmitter must be disabled before
> activating AutoCTS or auto transmitter flow control. Accordingly, the
> transmitter must be enabled after AutoCTS or auto transmitter flow
> control gets deactivated.
> 
> Signed-off-by: Christoph Vogtländer <c.vogtlaender@sigma-surface-science.com>
> ---
>  drivers/tty/serial/max310x.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
> index fb5a7e0e58e9..adfef6dae4a7 100644
> --- a/drivers/tty/serial/max310x.c
> +++ b/drivers/tty/serial/max310x.c
> @@ -860,6 +860,15 @@ static void max310x_set_termios(struct uart_port *port,
>  max310x_port_write(port, MAX310X_XON1_REG, termios->c_cc[VSTART]);
>  max310x_port_write(port, MAX310X_XOFF1_REG, termios->c_cc[VSTOP]);
> 
> +/* Disable transmitter before enabling AutoCTS or auto transmitter
> + * flow control
> + */
> +if (termios->c_cflag & CRTSCTS || termios->c_iflag & IXOFF) {
> +max310x_port_update(port, MAX310X_MODE1_REG,
> +    MAX310X_MODE1_TXDIS_BIT,
> +    MAX310X_MODE1_TXDIS_BIT);
> +}
> +
>  port->status &= ~(UPSTAT_AUTOCTS | UPSTAT_AUTORTS | UPSTAT_AUTOXOFF);
> 
>  if (termios->c_cflag & CRTSCTS) {
> @@ -878,6 +887,15 @@ static void max310x_set_termios(struct uart_port *port,
>  }
>  max310x_port_write(port, MAX310X_FLOWCTRL_REG, flow);
> 
> +/* Enable transmitter after disabling AutoCTS and auto transmitter
> + * flow control
> + */
> +if (!(termios->c_cflag & CRTSCTS) && !(termios->c_iflag & IXOFF)) {
> +max310x_port_update(port, MAX310X_MODE1_REG,
> +    MAX310X_MODE1_TXDIS_BIT,
> +    0);
> +}
> +
>  /* Get baud rate generator configuration */
>  baud = uart_get_baud_rate(port, termios, old,
>    port->uartclk / 16 / 0xffff,
> --
> 2.22.1
> 

Same problem here, this is impossible to apply.

greg k-h
