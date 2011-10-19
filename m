From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: patch "tty/serial: atmel_serial: auto-enumerate ports" added
 to tty tree
Date: Wed, 19 Oct 2011 11:40:04 +0200
Message-ID: <4E9E9AF4.1050105@atmel.com>
References: <1318981651741@kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from newsmtp5.atmel.com ([204.2.163.5]:46842 "EHLO
	sjogate2.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751865Ab1JSJkR (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 19 Oct 2011 05:40:17 -0400
In-Reply-To: <1318981651741@kroah.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@suse.de
Cc: grant.likely@secretlab.ca, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-serial@vger.kernel.org

On 10/19/2011 01:47 AM, gregkh@suse.de :
> 
> This is a note to let you know that I've just added the patch titled
> 
>     tty/serial: atmel_serial: auto-enumerate ports
> 
> to my tty git tree which can be found at
>     git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git
> in the tty-next branch.
> 
> The patch will show up in the next release of the linux-next tree
> (usually sometime within the next 24 hours during the week.)
> 
> The patch will also will be merged in the next major kernel release
> during the merge window.
> 
> If you have any questions about this process, please let me know.

Hi Greg,

Thanks for taking this series into your tree.

Can you please consider folding or adding the patch that I have just sent.
It corrects this auto-enumerate implementation and its name is:
"tty/serial: atmel_serial: bootconsole removed from auto-enumerates"

Best regards,

>>From 4cbf9f4864bd4fb2e64d555aacb93c24478e4e8d Mon Sep 17 00:00:00 2001
> From: Nicolas Ferre <nicolas.ferre@atmel.com>
> Date: Wed, 12 Oct 2011 18:06:59 +0200
> Subject: tty/serial: atmel_serial: auto-enumerate ports
> 
> If no platform data provided to enumerate ports, use a bit field
> to choose port number and check if port is already initialized.
> Use this mechanism for both console and plain serial ports.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> Acked-by: Grant Likely <grant.likely@secretlab.ca>
> Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> ---
>  drivers/tty/serial/atmel_serial.c |   44 ++++++++++++++++++++++++++++++------
>  1 files changed, 36 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
> index bb72354..1074329 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -157,6 +157,7 @@ struct atmel_uart_port {
>  };
>  
>  static struct atmel_uart_port atmel_ports[ATMEL_MAX_UART];
> +static unsigned long atmel_ports_in_use;
>  
>  #ifdef SUPPORT_SYSRQ
>  static struct console atmel_console;
> @@ -1423,7 +1424,6 @@ static void __devinit atmel_init_port(struct atmel_uart_port *atmel_port,
>  	port->flags		= UPF_BOOT_AUTOCONF;
>  	port->ops		= &atmel_pops;
>  	port->fifosize		= 1;
> -	port->line		= pdata->num;
>  	port->dev		= &pdev->dev;
>  	port->mapbase	= pdev->resource[0].start;
>  	port->irq	= pdev->resource[1].start;
> @@ -1613,10 +1613,15 @@ static struct console atmel_console = {
>  static int __init atmel_console_init(void)
>  {
>  	if (atmel_default_console_device) {
> -		add_preferred_console(ATMEL_DEVICENAME,
> -				      atmel_default_console_device->id, NULL);
> -		atmel_init_port(&atmel_ports[atmel_default_console_device->id],
> -				atmel_default_console_device);
> +		int id = atmel_default_console_device->id;
> +		struct atmel_uart_port *port = &atmel_ports[id];
> +
> +		set_bit(id, &atmel_ports_in_use);
> +		port->backup_imr = 0;
> +		port->uart.line = id;
> +
> +		add_preferred_console(ATMEL_DEVICENAME, id, NULL);
> +		atmel_init_port(port, atmel_default_console_device);
>  		register_console(&atmel_console);
>  	}
>  
> @@ -1715,12 +1720,33 @@ static int __devinit atmel_serial_probe(struct platform_device *pdev)
>  	struct atmel_uart_port *port;
>  	struct atmel_uart_data *pdata = pdev->dev.platform_data;
>  	void *data;
> -	int ret;
> +	int ret = -ENODEV;
>  
>  	BUILD_BUG_ON(ATMEL_SERIAL_RINGSIZE & (ATMEL_SERIAL_RINGSIZE - 1));
>  
> -	port = &atmel_ports[pdata->num];
> +	if (pdata)
> +		ret = pdata->num;
> +
> +	if (ret < 0)
> +		/* port id not found in platform data:
> +		 * auto-enumerate it */
> +		ret = find_first_zero_bit(&atmel_ports_in_use,
> +				sizeof(atmel_ports_in_use));
> +
> +	if (ret > ATMEL_MAX_UART) {
> +		ret = -ENODEV;
> +		goto err;
> +	}
> +
> +	if (test_and_set_bit(ret, &atmel_ports_in_use)) {
> +		/* port already in use */
> +		ret = -EBUSY;
> +		goto err;
> +	}
> +
> +	port = &atmel_ports[ret];
>  	port->backup_imr = 0;
> +	port->uart.line = ret;
>  
>  	atmel_init_port(port, pdev);
>  
> @@ -1766,7 +1792,7 @@ err_alloc_ring:
>  		clk_put(port->clk);
>  		port->clk = NULL;
>  	}
> -
> +err:
>  	return ret;
>  }
>  
> @@ -1786,6 +1812,8 @@ static int __devexit atmel_serial_remove(struct platform_device *pdev)
>  
>  	/* "port" is allocated statically, so we shouldn't free it */
>  
> +	clear_bit(port->line, &atmel_ports_in_use);
> +
>  	clk_put(atmel_port->clk);
>  
>  	return ret;


-- 
Nicolas Ferre
