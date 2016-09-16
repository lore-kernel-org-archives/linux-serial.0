From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v3 1/3] tty: amba-pl011: define flag register bits for ZTE
 device
Date: Fri, 16 Sep 2016 15:23:57 +0100
Message-ID: <b549cd51-a81f-b693-e3c2-9e3c598d3d9e@arm.com>
References: <1467968441-4056-1-git-send-email-shawn.guo@linaro.org>
 <1467968441-4056-2-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1467968441-4056-2-git-send-email-shawn.guo@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Shawn Guo <shawn.guo@linaro.org>, Russell King <linux@armlinux.org.uk>
Cc: xie.baoyou@zte.com.cn, Peter Hurley <peter@hurleysoftware.com>, Jason Liu <jason.liu@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Timur Tabi <timur@codeaurora.org>, Sudeep Holla <sudeep.holla@arm.com>, linux-serial@vger.kernel.org, Andre Przywara <andre.przywara@arm.com>, Jun Nie <jun.nie@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Hi Shawn, Russell,

I noticed this change is in linux-next and but I happen to hit an issue
with this as I tested it with earlycon enabled today for the first time.

On 08/07/16 10:00, Shawn Guo wrote:
> For some reason we do not really understand, ZTE hardware designers
> choose to define PL011 Flag Register bit positions differently from
> standard ones as below.
>
> 	Bit		Standard	ZTE
> 	-----------------------------------
> 	CTS		0		1
> 	DSR		1		3
> 	BUSY		3		8
> 	RI		8		0
>
> Let's define these bits into vendor data and get ZTE PL011 supported
> properly.
>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

[...]

> @@ -2303,13 +2325,16 @@ static struct console amba_console = {
>
>  static void pl011_putc(struct uart_port *port, int c)
>  {
> +	struct uart_amba_port *uap =
> +		container_of(port, struct uart_amba_port, port);
> +
>  	while (readl(port->membase + UART01x_FR) & UART01x_FR_TXFF)
>  		cpu_relax();
>  	if (port->iotype == UPIO_MEM32)
>  		writel(c, port->membase + UART01x_DR);
>  	else
>  		writeb(c, port->membase + UART01x_DR);
> -	while (readl(port->membase + UART01x_FR) & UART01x_FR_BUSY)
> +	while (readl(port->membase + UART01x_FR) & uap->vendor->fr_busy)
>  		cpu_relax();
>  }

The above hunk won't work for early console devices. The earlycon_device
just has uart_port and is not uart_amba_port. I don't know how to fix
this properly but I thought we could reuse private_data in uart_port for
early_con devices. Something like below(incomplete for other vendors,
works only for ARM)

Regards,
Sudeep

-->8

diff --git i/drivers/tty/serial/amba-pl011.c 
w/drivers/tty/serial/amba-pl011.c
index 0b78b04e895e..abe88223790c 100644
--- i/drivers/tty/serial/amba-pl011.c
+++ w/drivers/tty/serial/amba-pl011.c
@@ -2330,8 +2330,7 @@ static struct console amba_console = {

  static void pl011_putc(struct uart_port *port, int c)
  {
-       struct uart_amba_port *uap =
-               container_of(port, struct uart_amba_port, port);
+       struct vendor_data *vendor = port->private_data;

         while (readl(port->membase + UART01x_FR) & UART01x_FR_TXFF)
                 cpu_relax();
@@ -2339,7 +2338,7 @@ static void pl011_putc(struct uart_port *port, int c)
                 writel(c, port->membase + UART01x_DR);
         else
                 writeb(c, port->membase + UART01x_DR);
-       while (readl(port->membase + UART01x_FR) & uap->vendor->fr_busy)
+       while (readl(port->membase + UART01x_FR) & vendor->fr_busy)
                 cpu_relax();
  }

@@ -2356,6 +2355,7 @@ static int __init pl011_early_console_setup(struct 
earlycon_device *device,
         if (!device->port.membase)
                 return -ENODEV;

+       device->port.private_data = &vendor_arm;
         device->con->write = pl011_early_write;
         return 0;
  }
