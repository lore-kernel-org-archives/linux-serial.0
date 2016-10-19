From: "Niklas =?iso-8859-1?Q?S=F6derlund?=" <niklas.soderlund@ragnatech.se>
Subject: Re: [PATCH v2] tty: serial_core: Fix serial console crash on port
 shutdown
Date: Wed, 19 Oct 2016 10:17:06 +0200
Message-ID: <20161019081706.GC8106@bigcity.dyn.berto.se>
References: <1476808540-2757-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1476808540-2757-1-git-send-email-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Rob Herring <robh@kernel.org>, Peter Hurley <peter@hurleysoftware.com>, Alan Cox <alan@linux.intel.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Geert,

On 2016-10-18 18:35:40 +0200, Geert Uytterhoeven wrote:
> The port->console flag is always false, as uart_console() is called
> before the serial console has been registered.
> 
> Hence for a serial port used as the console, uart_tty_port_shutdown()
> will still be called when userspace closes the port, powering it down.
> This may lead to a system lock up when the serial console driver writes
> to the serial port's registers.
> 
> To fix this, move the setting of port->console after the call to
> uart_configure_port(), which registers the serial console.
> 
> Fixes: 761ed4a94582ab29 ("tty: serial_core: convert uart_close to use tty_port_close")
> Reported-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Acked-by: Rob Herring <robh@kernel.org>

It fixes the issue I was seeing with systemd as a init system.

Tested-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

> ---
> v2:
>   - Add Acked-by,
>   - Reworded one-line summary (incl. magic word "fix").
> 
> Can easily be reproduced on Renesas boards:
>   1. With systemd: hangs during boot,
>   2. Without systemd: "telinit n" to switch to a runlevel that doesn't
>      run a getty on ttySC0, and trigger kernel console output => hang.
> ---
>  drivers/tty/serial/serial_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index 6e4f63627479db8d..ce8899c13af3d97f 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -2746,8 +2746,6 @@ int uart_add_one_port(struct uart_driver *drv, struct uart_port *uport)
>  	uport->cons = drv->cons;
>  	uport->minor = drv->tty_driver->minor_start + uport->line;
>  
> -	port->console = uart_console(uport);
> -
>  	/*
>  	 * If this port is a console, then the spinlock is already
>  	 * initialised.
> @@ -2761,6 +2759,8 @@ int uart_add_one_port(struct uart_driver *drv, struct uart_port *uport)
>  
>  	uart_configure_port(drv, state, uport);
>  
> +	port->console = uart_console(uport);
> +
>  	num_groups = 2;
>  	if (uport->attr_group)
>  		num_groups++;
> -- 
> 1.9.1
> 

-- 
Regards,
Niklas Söderlund
