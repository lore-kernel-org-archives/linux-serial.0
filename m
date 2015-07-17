From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH] serial: 8250: Do XR17V35X specific wakeup in serial8250_do_startup
Date: Fri, 17 Jul 2015 09:34:31 -0400
Message-ID: <55A90467.9000804@hurleysoftware.com>
References: <1437035353-13708-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1437035353-13708-1-git-send-email-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Tony Lindgren <tony@atomide.com>, Alan Cox <alan@linux.intel.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>, Michael Welling <mwelling@ieee.org>, Joe Schultz <jschultz@xes-inc.com>
List-Id: linux-serial@vger.kernel.org

On 07/16/2015 04:29 AM, Joerg Roedel wrote:
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

Reviewed-by: Peter Hurley <peter@hurleysoftware.com>

Also, would you please find out what bits are set in the IER
that this fixes and let me know? I don't have this hardware.

Regards,
Peter Hurley

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
>  	/*
>  	 * Clear the FIFO buffers and disable them.
>  	 * (they will be reenabled in set_termios())
> 
