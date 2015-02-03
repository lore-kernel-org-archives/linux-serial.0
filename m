From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH v2 2/2] tty: serial: 8250_core: Check that port->line
 is >=0
Date: Tue, 03 Feb 2015 10:22:44 -0500
Message-ID: <54D0E7C4.8070308@hurleysoftware.com>
References: <d237c6e90cbd2f106a4125816b02d0541fa4cefe.1422957699.git.michal.simek@xilinx.com> <7904178c3dfbf08191514c8436e66d711455a17c.1422957699.git.michal.simek@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7904178c3dfbf08191514c8436e66d711455a17c.1422957699.git.michal.simek@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Michal Simek <michal.simek@xilinx.com>
Cc: linux-kernel@vger.kernel.org, monstr@monstr.eu, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Jiri Slaby <jslaby@suse.cz>, Alan Cox <alan@linux.intel.com>, Yoshihiro YUNOMAE <yoshihiro.yunomae.ez@hitachi.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>, Tony Lindgren <tony@atomide.com>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-serial@vger.kernel.org

Hi Michal,

On 02/03/2015 05:01 AM, Michal Simek wrote:
> Add one more checking condition which was originally added by:
> "tty: serial: 8250_core: use the ->line argument as a hint in
> serial8250_find_match_or_unused()"
> (sha1: 59b3e898ddfc81a65975043b5eb44103cc29ff6e)
> 
> port->line can be setup by DT driver to -1 which needs to
> be also checked.

What driver is initializing port->line to -1?

Drivers using of_alias_get_id() and/or the platform device id
need to clamp port->line to a valid index before port
registration (or in the case of 8250-type drivers before
8250 port registration.


> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
> Changes in v2:
> - Change commit message description
> - Do not sign patches - Greg reported problem with it
> 
> I have similar patch to 59b3e898ddfc81a65975043b5eb44103cc29ff6e
> in xilinx tree for a while and port->line can be -1.
> 
> The second part of this also should be (what other drivers do)

What 'second part of this'?

I only see one change here (and I'd rather see the 8250 core
return NULL if port->line < 0).

Regards,
Peter Hurley


> reading aliases via of_alias_get_id() in of_serial.c:of_platform_serial_probe()
> which setup port.line.
> ---
>  drivers/tty/serial/8250/8250_core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
> index 65e52c9109e2..aab765177763 100644
> --- a/drivers/tty/serial/8250/8250_core.c
> +++ b/drivers/tty/serial/8250/8250_core.c
> @@ -3512,7 +3512,8 @@ static struct uart_8250_port *serial8250_find_match_or_unused(struct uart_port *
>  
>  	/* try line number first if still available */
>  	i = port->line;
> -	if (i < nr_uarts && serial8250_ports[i].port.type == PORT_UNKNOWN &&
> +	if (i >= 0 && i < nr_uarts &&
> +	    serial8250_ports[i].port.type == PORT_UNKNOWN &&
>  			serial8250_ports[i].port.iobase == 0)
>  		return &serial8250_ports[i];
>  	/*
> 
