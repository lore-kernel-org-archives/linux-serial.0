From: Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH V3 5/7] serial: earlycon: Set UPIO_MEM32BE based on DT
 properties
Date: Sun, 01 Mar 2015 17:23:11 -0500
Message-ID: <54F3914F.3080905@hurleysoftware.com>
References: <1416872182-6440-1-git-send-email-cernekee@gmail.com> <1416872182-6440-6-git-send-email-cernekee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1416872182-6440-6-git-send-email-cernekee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Cernekee <cernekee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, jslaby-AlSwsSmVLrQ@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: arnd-r2nGTMty4D4@public.gmane.org, f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

Hi Kevin,

On 11/24/2014 06:36 PM, Kevin Cernekee wrote:
> If an earlycon (stdout-path) node is being used, check for "big-endian"
> or "native-endian" properties and pass the appropriate iotype to the
> driver.
> 
> Note that LE sets UPIO_MEM (8-bit) but BE sets UPIO_MEM32BE (32-bit).  The
> big-endian property only really makes sense in the context of 32-bit
> registers, since 8-bit accesses never require data swapping.
> 
> At some point, the of_earlycon code may want to pass in the reg-io-width,
> reg-offset, and reg-shift parameters too.
> 
> Signed-off-by: Kevin Cernekee <cernekee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/of/fdt.c              | 7 ++++++-
>  drivers/tty/serial/earlycon.c | 4 ++--
>  include/linux/serial_core.h   | 2 +-
>  3 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index 658656f..9d21472 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -794,6 +794,8 @@ int __init early_init_dt_scan_chosen_serial(void)
>  
>  	while (match->compatible[0]) {
>  		unsigned long addr;
> +		unsigned char iotype = UPIO_MEM;
> +
>  		if (fdt_node_check_compatible(fdt, offset, match->compatible)) {
>  			match++;
>  			continue;
> @@ -803,7 +805,10 @@ int __init early_init_dt_scan_chosen_serial(void)
>  		if (!addr)
>  			return -ENXIO;
>  
> -		of_setup_earlycon(addr, match->data);
> +		if (of_fdt_is_big_endian(fdt, offset))
> +			iotype = UPIO_MEM32BE;
> +
> +		of_setup_earlycon(addr, iotype, match->data);

I know these got ACKs already but as you point out in the commit log,
earlycon _will_ need reg-io-width, reg-offset and reg-shift. Since the
distinction between early_init_dt_scan_chosen_serial() and
of_setup_earlycon() is arbitrary, I'd rather see of_setup_earlycon()
taught to properly decode of_serial driver bindings instead of a
stack of parameters to of_setup_earlycon().

In fact, this patch allows a mis-defined devicetree to bring up a
functioning earlycon because the 'big-endian' property is directly
associated with UPIO_MEM32BE, which will create incompatibility problems
when DT earlycon is fixed to decode the of_serial DT bindings.

[rant]
In general, the ability to query devicetree from all over the
kernel creates all kinds of compatibility issues which eventually
will cause unresolvable breakage.

The same rigor applied to ioctls is the analysis required for how
DT bindings are used in the kernel.

I realize that since this particular case only applies to earlycon, it's
no big deal, but if this same mistake had been made in the of_serial
driver, the serial core would be permanently stuck with the
'big-endian' property == UPIO_MEM32BE which could impact future designs.
[/rant]

Regards,
Peter Hurley

>  		return 0;
>  	}
>  	return -ENODEV;
> diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
> index a514ee6..548f7d7 100644
> --- a/drivers/tty/serial/earlycon.c
> +++ b/drivers/tty/serial/earlycon.c
> @@ -148,13 +148,13 @@ int __init setup_earlycon(char *buf, const char *match,
>  	return 0;
>  }
>  
> -int __init of_setup_earlycon(unsigned long addr,
> +int __init of_setup_earlycon(unsigned long addr, unsigned char iotype,
>  			     int (*setup)(struct earlycon_device *, const char *))
>  {
>  	int err;
>  	struct uart_port *port = &early_console_dev.port;
>  
> -	port->iotype = UPIO_MEM;
> +	port->iotype = iotype;
>  	port->mapbase = addr;
>  	port->uartclk = BASE_BAUD * 16;
>  	port->membase = earlycon_map(addr, SZ_4K);
> diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
> index d2d5bf6..0d60c64 100644
> --- a/include/linux/serial_core.h
> +++ b/include/linux/serial_core.h
> @@ -310,7 +310,7 @@ struct earlycon_device {
>  int setup_earlycon(char *buf, const char *match,
>  		   int (*setup)(struct earlycon_device *, const char *));
>  
> -extern int of_setup_earlycon(unsigned long addr,
> +extern int of_setup_earlycon(unsigned long addr, unsigned char iotype,
>  			     int (*setup)(struct earlycon_device *, const char *));
>  
>  #define EARLYCON_DECLARE(name, func) \
> 

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
