From: Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 08/15] of_serial: support for UARTs on I/O ports
Date: Tue, 26 May 2015 09:53:55 -0400
Message-ID: <55647AF3.1000508@hurleysoftware.com>
References: <1432309875-9712-1-git-send-email-paul.burton@imgtec.com> <1432309875-9712-9-git-send-email-paul.burton@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1432309875-9712-9-git-send-email-paul.burton-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Paul Burton <paul.burton-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

[ + Arnd who has been reviewing/acking of_serial.c changes ]

On 05/22/2015 11:51 AM, Paul Burton wrote:
> If the address provided for the UART is of an I/O port rather than
> a regular memory address, then set the port iotype appropriately and
> write the address to iobase rather than mapbase.
> 
> Signed-off-by: Paul Burton <paul.burton-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
> ---
> 
>  drivers/tty/serial/of_serial.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/of_serial.c b/drivers/tty/serial/of_serial.c
> index 137381e..ccff9ba 100644
> --- a/drivers/tty/serial/of_serial.c
> +++ b/drivers/tty/serial/of_serial.c
> @@ -110,7 +110,12 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
>  
>  	port->irq = irq_of_parse_and_map(np, 0);
>  	port->iotype = UPIO_MEM;
> -	if (of_property_read_u32(np, "reg-io-width", &prop) == 0) {
> +
> +	if (resource.flags & IORESOURCE_IO) {
> +		port->iotype = UPIO_PORT;
> +		port->iobase = port->mapbase;
> +		port->mapbase = 0;
> +	} else if (of_property_read_u32(np, "reg-io-width", &prop) == 0) {
>  		switch (prop) {
>  		case 1:
>  			port->iotype = UPIO_MEM;
> 

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
