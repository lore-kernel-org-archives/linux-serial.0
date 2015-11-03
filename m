From: Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH 2/2] serial: amba-pl011: abstract register accessors
Date: Tue, 3 Nov 2015 10:43:24 -0600
Message-ID: <5638E42C.3050108@codeaurora.org>
References: <1446562867-5693-1-git-send-email-timur@codeaurora.org>
 <1446562867-5693-2-git-send-email-timur@codeaurora.org>
 <20151103161206.GA8644@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20151103161206.GA8644@n2100.arm.linux.org.uk>
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
Cc: peter@hurleysoftware.com, andre.przywara@arm.com, Linus Walleij <linus.walleij@linaro.org>, Andrew.Jackson@arm.com, linux-serial@vger.kernel.org, Greg Kroah-Hartman <greg@kroah.com>, jslaby@suse.com, jun.nie@linaro.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Russell King - ARM Linux wrote:
> Thanks for pointing that out... that's a mistake in my patches.  It's
> very difficult to see how we could ever support earlyconsole on ZTE
> without massively overhauling the earlycon stuff.  I'll undo the
> changes there in my series.

How about a command-line option for earlycon?  We do this on our kernel 
for now:

earlycon=pl011,0x3blabla,sbsa32

And then in pl011_early_console_setup(), device->con->write is set to 
either pl011_early_write or to pl011_early_write_sbsa32, which looks 
like this:

static void pl011_putc_sbsa32(struct uart_port *port, int c)
{
         while (readl(port->membase + UART01x_FR) & UART01x_FR_TXFF)
                 cpu_relax();
         writel(c, port->membase + UART01x_DR);
         while (!(readl(port->membase + UART01x_FR) & UART011_FR_TXFE))
                 cpu_relax();
}


static void pl011_early_write_sbsa32(struct console *con, const char *s, 
unsigned n)
{
         struct earlycon_device *dev = con->data;

         uart_console_write(&dev->port, s, n, pl011_putc_sbsa32);
}

I would have added this to my patch, but I specifically didn't want to 
add any new functionality.

> Now, as for this patch...
>
>> >  	unsigned int (*get_fifosize)(struct amba_device *dev);
>> >+	u16 (*regreadw)(const void __iomem *addr);
>> >+	void (*regwritew)(u16 val, void __iomem *addr);
>> >+	void (*regwriteb)(u8 val, void __iomem *addr);
> regwriteb() is used nowhere in this patch.

Sorry, I could have sworn I deleted that.  Should I bother posting a 
version 2, since your patch is better?

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, hosted by The Linux Foundation.
