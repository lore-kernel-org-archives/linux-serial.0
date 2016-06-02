From: Aleksey Makarov <amakarov.linux@gmail.com>
Subject: Re: [PATCH v8 4/4] serial: pl011: add console matching function
Date: Thu, 2 Jun 2016 21:02:33 +0300
Message-ID: <c37d62c7-1e1b-0b10-a083-c5207fbbb820@gmail.com>
References: <1463749405-11640-1-git-send-email-aleksey.makarov@linaro.org>
 <1463749405-11640-5-git-send-email-aleksey.makarov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1463749405-11640-5-git-send-email-aleksey.makarov@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <linux@arm.linux.org.uk>
Cc: Aleksey Makarov <aleksey.makarov@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Len Brown <lenb@kernel.org>, Leif Lindholm <leif.lindholm@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>, Al Stone <ahs3@redhat.com>, Christopher Covington <cov@codeaurora.org>, Yury Norov <ynorov@caviumnetworks.com>, Peter Hurley <peter@hurleysoftware.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, "Zheng, Lv" <lv.zheng@intel.com>, Mark Salter <msalter@redhat.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Russell King <linux@armlinux.org.uk>, Jiri Slaby <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org


On 05/20/2016 04:03 PM, Aleksey Makarov wrote:
> This patch adds function pl011_console_match() that implements
> method match of struct console.  It allows to match consoles against
> data specified in a string, for example taken from command line or
> compiled by ACPI SPCR table handler.
> 
> Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>
> Reviewed-by: Peter Hurley <peter@hurleysoftware.com>

Hi Greg, Russell,

Can you review this patch and consider ACKing it please?
It had an ACK from Greg in v7 but since then I changed it a bit.

The patch by Christopher Covington [1] specifies that SBSA uart 
does 32-bit access to registers and this breaks the match function.  
In this series the function was changed to match when SPCR specifies
both mmio32 and mmio access.  I removed Acked-by: Greg from this
patch because of these changes.

The difference between v7 and v8:

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 4139b64..388edc8 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2328,10 +2329,10 @@ static int __init pl011_console_match(struct console *co, char *name, int idx,
 
                port = &amba_ports[i]->port;
 
-               if (port->iotype != iotype)
+               if (iotype != UPIO_MEM && iotype != UPIO_MEM32)
                        continue;
-               if ((iotype == UPIO_MEM || iotype == UPIO_MEM32) &&
-                   (port->mapbase != addr))
+
+               if (port->mapbase != addr)
                        continue;
 
                co->index = i;

[1] https://lkml.kernel.org/g/1457415800-8799-1-git-send-email-cov@codeaurora.org

Thank you
Aleksey Makarov

> ---
>  drivers/tty/serial/amba-pl011.c | 56 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 56 insertions(+)
> 
> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
> index a2aa655..388edc8 100644
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c
> @@ -2288,12 +2288,68 @@ static int __init pl011_console_setup(struct console *co, char *options)
>  	return uart_set_options(&uap->port, co, baud, parity, bits, flow);
>  }
>  
> +/**
> + *	pl011_console_match - non-standard console matching
> + *	@co:	  registering console
> + *	@name:	  name from console command line
> + *	@idx:	  index from console command line
> + *	@options: ptr to option string from console command line
> + *
> + *	Only attempts to match console command lines of the form:
> + *	    console=pl011,mmio|mmio32,<addr>[,<options>]
> + *	    console=pl011,0x<addr>[,<options>]
> + *	This form is used to register an initial earlycon boot console and
> + *	replace it with the amba_console at pl011 driver init.
> + *
> + *	Performs console setup for a match (as required by interface)
> + *	If no <options> are specified, then assume the h/w is already setup.
> + *
> + *	Returns 0 if console matches; otherwise non-zero to use default matching
> + */
> +static int __init pl011_console_match(struct console *co, char *name, int idx,
> +				      char *options)
> +{
> +	char match[] = "pl011";	/* pl011-specific earlycon name */
> +	unsigned char iotype;
> +	unsigned long addr;
> +	int i;
> +
> +	if (strncmp(name, match, 5) != 0)
> +		return -ENODEV;
> +
> +	if (uart_parse_earlycon(options, &iotype, &addr, &options))
> +		return -ENODEV;
> +
> +	/* try to match the port specified on the command line */
> +	for (i = 0; i < ARRAY_SIZE(amba_ports); i++) {
> +		struct uart_port *port;
> +
> +		if (!amba_ports[i])
> +			continue;
> +
> +		port = &amba_ports[i]->port;
> +
> +		if (iotype != UPIO_MEM && iotype != UPIO_MEM32)
> +			continue;
> +
> +		if (port->mapbase != addr)
> +			continue;
> +
> +		co->index = i;
> +		port->cons = co;
> +		return pl011_console_setup(co, options);
> +	}
> +
> +	return -ENODEV;
> +}
> +
>  static struct uart_driver amba_reg;
>  static struct console amba_console = {
>  	.name		= "ttyAMA",
>  	.write		= pl011_console_write,
>  	.device		= uart_console_device,
>  	.setup		= pl011_console_setup,
> +	.match		= pl011_console_match,
>  	.flags		= CON_PRINTBUFFER,
>  	.index		= -1,
>  	.data		= &amba_reg,
> 
