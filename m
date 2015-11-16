From: Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH 10/12] tty: amba-pl011: add support for 32-bit register
 access
Date: Mon, 16 Nov 2015 12:25:45 -0600
Message-ID: <564A1FA9.8010109@codeaurora.org>
References: <20151116173935.GQ8644@n2100.arm.linux.org.uk>
 <E1ZyNls-0003kA-Fe@rmk-PC.arm.linux.org.uk> <564A1628.9010900@codeaurora.org>
 <20151116175217.GT8644@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20151116175217.GT8644@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Peter Hurley <peter@hurleysoftware.com>, Andre Przywara <andre.przywara@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Andrew.Jackson@arm.com, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Jun Nie <jun.nie@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Russell King - ARM Linux wrote:
> Well, it looks a bit weird, because we use 16-bit accesses for other
> values, and there isn't a UPIO_MEM16 type.

Fair enough, but I don't think it's that weird that the absence of 
UPIO_MEM32 means that we can use non-32-bit accessors.

> Although that could be
> added, it's extending the scope of the patch to touching core files.

How is it touching core files?  Granted, we might still need access_32b 
in vendor_data, but not for SBSA, since SBSA already has a mechanism to 
determine what 32-bit is needed or not.

Then in pl011_probe(), just have:

	uap->port.iotype = vendor->access_32b ? UPIO_MEM32 : 0;

For sbsa_uart_probe(), we would just the set that field if we detect 
subtype 13 debug port.  That depends on Leif Lindholm's patches: 
https://lkml.org/lkml/2015/9/8/287

This also has the advantage of being able to use the existing "mmio32" 
option to earlycon, as I have in my other patch:

  static void pl011_putc(struct uart_port *port, int c)
  {
	while (readl(port->membase + UART01x_FR) & UART01x_FR_TXFF)
  		;
-	writeb(c, port->membase + REG_DR);
+	if (port->iotype == UPIO_MEM32)
+		writel(c, port->membase + UART01x_DR);
+	else
+		writeb(c, port->membase + UART01x_DR);
	while (readl(port->membase + UART01x_FR) & UART01x_FR_BUSY)
  		;
  }


-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
