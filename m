From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH 2/2] SERIAL: allow shared 8250_pnp interrupts
Date: Sat, 1 Jul 2006 09:06:06 +0100
Message-ID: <20060701080605.GA19354@flint.arm.linux.org.uk>
References: <200606301258.37204.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200606301258.37204.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Andrew Morton <akpm@osdl.org>, Adam Belay <ambx1@neo.rr.com>, Matthieu Castet <castet.matthieu@free.fr>, Li Shaohua <shaohua.li@intel.com>, Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Fri, Jun 30, 2006 at 12:58:37PM -0600, Bjorn Helgaas wrote:
> PNP devices can use shared interrupts, so check to see whether
> we'll need SA_SHIRQ for request_irq().
> 
> The builtin PDH UART on the HP rx8640 is an example of an ACPI/PNP
> device that uses a shareable level-triggered, active-low interrupt.
> The interrupt can be shared in very large I/O configurations or by
> artificially lowering IA64_DEF_LAST_DEVICE_VECTOR.
> 
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>

> Index: as3877/drivers/serial/8250_pnp.c
> ===================================================================
> --- as3877.orig/drivers/serial/8250_pnp.c	2006-06-30 10:44:09.000000000 -0600
> +++ as3877/drivers/serial/8250_pnp.c	2006-06-30 11:44:18.000000000 -0600
> @@ -431,6 +431,8 @@
>  #endif
>  
>  	port.flags |= UPF_SKIP_TEST | UPF_BOOT_AUTOCONF;
> +	if (pnp_irq_flags(dev, 0) & IORESOURCE_IRQ_SHAREABLE)
> +		port.flags |= UPF_SHARE_IRQ;
>  	port.uartclk = 1843200;
>  	port.dev = &dev->dev;
>  

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
