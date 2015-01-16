From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 2/2] tty: serial: 8250_core: Check that port->line is
 >=0
Date: Fri, 16 Jan 2015 10:00:30 +0100
Message-ID: <54B8D32E.5000805@linutronix.de>
References: <3293c93689f5d8c684133a9d9952411a201609dc.1421333585.git.michal.simek@xilinx.com> <d3a26f5ecd44e1415f213e6ee7f33005c1b23f4a.1421333585.git.michal.simek@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d3a26f5ecd44e1415f213e6ee7f33005c1b23f4a.1421333585.git.michal.simek@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Michal Simek <michal.simek@xilinx.com>, linux-kernel@vger.kernel.org, monstr@monstr.eu
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, Peter Hurley <peter@hurleysoftware.com>, Alan Cox <alan@linux.intel.com>, Tony Lindgren <tony@atomide.com>, Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>, Yoshihiro YUNOMAE <yoshihiro.yunomae.ez@hitachi.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-serial@vger.kernel.org

On 01/15/2015 03:55 PM, Michal Simek wrote:
> This patch should be the part of:
> "tty: serial: 8250_core: use the ->line argument as a hint in
> serial8250_find_match_or_unused()"
> (sha1: 59b3e898ddfc81a65975043b5eb44103cc29ff6e)
> 
> port->line can be setup by DT driver to -1 which needs to
> be also checked.

This is what I have in 8250_omap to make sure it does not get < 0:

         if (pdev->dev.of_node) {
                 ret = of_alias_get_id(pdev->dev.of_node, "serial");

                 of_property_read_u32(pdev->dev.of_node, "clock-frequency",
                                      &up.port.uartclk);
                 priv->wakeirq = irq_of_parse_and_map(pdev->dev.of_node, 1);
         } else {
                 ret = pdev->id;
         }
         if (ret < 0) {
                 dev_err(&pdev->dev, "failed to get alias/pdev id\n");
                 return ret;
         }
         up.port.line = ret;

but I didn't think of that others might pass < 0 since it wasn't used
before.
Does the original patch (you noted) break anything as of now? Because
then this patch should go stable.

> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

> ---
> 
> I have similar patch to 59b3e898ddfc81a65975043b5eb44103cc29ff6e
> in xilinx tree for a while and port->line can be -1.
> 
> The second part of this also should be (what other drivers do)
> reading aliases via of_alias_get_id() in of_serial.c:of_platform_serial_probe()
> which setup port.line.

Which second part?
Hmmm. You could use of_alias_get_id(port.dev->of_node, "serial") here,
correct. But I think additionally, since it won't work for the
non-DT devices like pure platform devices.

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
> --
> 1.8.2.3

Sebastian
