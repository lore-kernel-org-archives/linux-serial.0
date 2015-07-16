From: Michael Welling <mwelling@ieee.org>
Subject: Re: [PATCH] serial: 8250: Do XR17V35X specific wakeup in
 serial8250_do_startup
Date: Thu, 16 Jul 2015 03:55:19 -0500
Message-ID: <20150716085519.GA29279@deathray>
References: <1437035353-13708-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1437035353-13708-1-git-send-email-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Peter Hurley <peter@hurleysoftware.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Tony Lindgren <tony@atomide.com>, Alan Cox <alan@linux.intel.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>, Joe Schultz <jschultz@xes-inc.com>
List-Id: linux-serial@vger.kernel.org

On Thu, Jul 16, 2015 at 10:29:13AM +0200, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> The XR17V35X UART needs the ECB bit set in its XR_EFR
> register to enable access to IER [7:5], ISR [5:4], FCR[5:4],
> MCR[7:5], and MSR [7:0].
> 
> Also reset the IER register to mask interrupts after access
> to all bits of this register has been enabled.
> 
> This makes my 8-port XR17V35X working with the in-kernel
> serial driver.
> 
> Cc: Peter Hurley <peter@hurleysoftware.com>
> Cc: Michael Welling <mwelling@ieee.org>
> Cc: Joe Schultz <jschultz@xes-inc.com>
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  drivers/tty/serial/8250/8250_core.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
> index 37fff12..4124a91 100644
> --- a/drivers/tty/serial/8250/8250_core.c
> +++ b/drivers/tty/serial/8250/8250_core.c
> @@ -2164,6 +2164,21 @@ int serial8250_do_startup(struct uart_port *port)
>  	 */
>  	enable_rsa(up);
>  #endif
> +
> +	if (port->type == PORT_XR17V35X) {
> +		/*
> +		 * First enable access to IER [7:5], ISR [5:4], FCR [5:4],
> +		 * MCR [7:5] and MSR [7:0]
> +		 */
> +		serial_port_out(port, UART_XR_EFR, UART_EFR_ECB);
> +
> +		/*
> +		 * Make sure all interrups are masked until initialization is
> +		 * complete and the FIFOs are cleared
> +		 */
> +		serial_port_out(port, UART_IER, 0);
> +	}
> +

Reviewed-by: Michael Welling <mwelling@ieee.org>

>  	/*
>  	 * Clear the FIFO buffers and disable them.
>  	 * (they will be reenabled in set_termios())
> -- 
> 1.9.1
> 
