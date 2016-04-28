From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] 8250: Hypervisors always export working 16550A UARTs.
Date: Thu, 28 Apr 2016 15:56:33 -0700
Message-ID: <20160428225633.GA9134@kroah.com>
References: <1461881913-23967-1-git-send-email-rjones@redhat.com>
 <1461881913-23967-2-git-send-email-rjones@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1461881913-23967-2-git-send-email-rjones@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: jslaby@suse.com, peter@hurleysoftware.com, andriy.shevchenko@linux.intel.com, phillip.raffeck@fau.de, anton.wuerfel@fau.de, yamada.masahiro@socionext.com, matwey@sai.msu.ru, valentinrothberg@gmail.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, ddutile@redhat.com
List-Id: linux-serial@vger.kernel.org

On Thu, Apr 28, 2016 at 11:18:33PM +0100, Richard W.M. Jones wrote:
> Currently autoconf spends 25ms (on my laptop) testing if the UART
> exported to it by KVM is an 8250 without FIFO and/or with strange
> quirks, which it obviously isn't.  Assume it is exported to us by a
> hypervisor, it's a normal, working 16550A.
> 
> Signed-off-by: Richard W.M. Jones <rjones@redhat.com>
> ---
>  drivers/tty/serial/8250/8250_port.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index 00ad2637..de19924 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -1171,6 +1171,13 @@ static void autoconfig(struct uart_8250_port *up)
>  	if (!port->iobase && !port->mapbase && !port->membase)
>  		return;
>  
> +	/* Hypervisors always export working 16550A devices. */
> +	if (cpu_has_hypervisor) {
> +		up->port.type = PORT_16550A;
> +		up->capabilities |= UART_CAP_FIFO;
> +		return;
> +	}

Have you audited vmware, virtualbox, and everyone else that provides a
virtual uart device that it will work properly here?

qemu isn't all the world :)

thanks,

greg k-h
