From: Ley Foon Tan <lftan@altera.com>
Subject: Re: [PATCH 2/2] serial: of_serial: Handle fifosize property
Date: Thu, 21 Mar 2013 19:41:39 +0800
Message-ID: <1363866099.2289.8.camel@leyfoon-vm>
References: <20130321104651.GC2862@xps8300>
	 <1363862880-17295-1-git-send-email-heikki.krogerus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from va3ehsobe005.messaging.microsoft.com ([216.32.180.31]:50561
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932102Ab3CULly convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 21 Mar 2013 07:41:54 -0400
In-Reply-To: <1363862880-17295-1-git-send-email-heikki.krogerus@linux.intel.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Rob Landley <rob@landley.net>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

On Thu, 2013-03-21 at 12:48 +0200, Heikki Krogerus wrote:
> fifosize property is already used with a number of serial
> devices. This should reduce the need for extra types in
> 8250.c just in case the fifosize differs from the standard.
> 
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
>  Documentation/devicetree/bindings/tty/serial/of-serial.txt |    1 +
>  drivers/tty/serial/of_serial.c                             |    4 ++++
>  2 files changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/tty/serial/of-serial.txt b/Documentation/devicetree/bindings/tty/serial/of-serial.txt
> index 8f01cb1..55fe4e7 100644
> --- a/Documentation/devicetree/bindings/tty/serial/of-serial.txt
> +++ b/Documentation/devicetree/bindings/tty/serial/of-serial.txt
> @@ -33,6 +33,7 @@ Optional properties:
>    RTAS and should not be registered.
>  - no-loopback-test: set to indicate that the port does not implements loopback
>    test mode
> +- fifosize: the fifo size of the UART.
>  
>  Example:
>  
> diff --git a/drivers/tty/serial/of_serial.c b/drivers/tty/serial/of_serial.c
> index b025d54..4f89761 100644
> --- a/drivers/tty/serial/of_serial.c
> +++ b/drivers/tty/serial/of_serial.c
> @@ -97,6 +97,10 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
>  	if (of_property_read_u32(np, "reg-shift", &prop) == 0)
>  		port->regshift = prop;
>  
> +	/* Check for fifo size */
> +	if (of_property_read_u32(np, "fifosize", &prop) == 0)
> +		port->fifosize = prop;
> +
Suggest to use "fifo-size" for the device tree property, to align with
other DT properties.

>  	port->irq = irq_of_parse_and_map(np, 0);
>  	port->iotype = UPIO_MEM;
>  	if (of_property_read_u32(np, "reg-io-width", &prop) == 0) {

I think you need to remove the UPF_FIXED_TYPE from port-flags as well to
use the fifo size from device tree. Otherwise, it will get from the
static array in 8250.c.

LFTan


