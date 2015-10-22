From: Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH v13 2/5] uart: pl011: Introduce register accessor
Date: Thu, 22 Oct 2015 18:36:32 -0500
Message-ID: <CAOZdJXUZDTzEn4f4FGhmKfq7HeEFKPKp4BAbR6_=wXGVw5_0GQ@mail.gmail.com>
References: <1438328959-16177-1-git-send-email-jun.nie@linaro.org>
 <1438328959-16177-3-git-send-email-jun.nie@linaro.org>
 <55FBECCD.2080906@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <55FBECCD.2080906@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Andre Przywara <andre.przywara@arm.com>
Cc: "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "peter@hurleysoftware.com" <peter@hurleysoftware.com>, "jason.liu@linaro.org" <jason.liu@linaro.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, Andrew Jackson <Andrew.Jackson@arm.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Jun Nie <jun.nie@linaro.org>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>, "wan.zhijun@zte.com.cn" <wan.zhijun@zte.com.cn>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

On Fri, Sep 18, 2015 at 5:51 AM, Andre Przywara <andre.przywara@arm.com> wrote:
>
>>  static void pl011_putc(struct uart_port *port, int c)
>>  {
>> -       while (readl(port->membase + REG_FR) & UART01x_FR_TXFF)
>> +       struct uart_amba_port *uap =
>> +           container_of(port, struct uart_amba_port, port);
>> +
>> +       while (pl011_readw(uap, REG_FR) & UART01x_FR_TXFF)
>>                 ;
>> -       writeb(c, port->membase + REG_DR);
>> -       while (readl(port->membase + REG_FR) & UART01x_FR_BUSY)
>> +       pl011_writeb(uap, c, REG_DR);
>> +       while (pl011_readw(uap, REG_FR) & UART01x_FR_BUSY)
>>                 ;
>>  }
>
> Just for the records, as this has been discussed before: pl011_putc() is
> called by the earlycon code, before the uart_port is actually
> initialized. So we cannot rely on the accessors, but have to use the
> old-fashioned director accessors for this.
>
> Which means you cannot use that approach to get earlycon support for the
> ZTE UART, if I get this correctly. It shouldn't be to hard to introduce
> another earlycon type specificly for that one, copying pl011_early_write
> and pl011_early_console_setup and changing pl011_putc into
> zte_uart_putc. But of course this belongs into the final patch (or a
> separate one), not in this. So I guess you just leave that function
> unchanged in this patch.

How about something like this?  It adds the "sbsa32" option to the
earlycon command-line parameter.

static void pl011_putc(struct uart_port *port, int c)
{
    while (readl(port->membase + UART01x_FR) & UART01x_FR_TXFF)
        cpu_relax();
    writeb(c, port->membase + UART01x_DR);
    while (readl(port->membase + UART01x_FR) & UART01x_FR_BUSY)
        cpu_relax();
}

static void pl011_early_write(struct console *con, const char *s, unsigned n)
{
    struct earlycon_device *dev = con->data;

    uart_console_write(&dev->port, s, n, pl011_putc);
}

static void pl011_putc_sbsa32(struct uart_port *port, int c)
{
    while (readl(port->membase + UART01x_FR) & UART01x_FR_TXFF)
        cpu_relax();
    writel(c, port->membase + UART01x_DR);
    while (readl(port->membase + UART01x_FR) & UART01x_FR_BUSY)
        cpu_relax();
}

static void pl011_early_write_sbsa32(struct console *con, const char
*s, unsigned n)
{
    struct earlycon_device *dev = con->data;

    uart_console_write(&dev->port, s, n, pl011_putc_sbsa32);
}

static int __init pl011_early_console_setup(struct earlycon_device *device,
                        const char *opt)
{
    if (!device->port.membase)
        return -ENODEV;

    if (strcmp(device->options, "sbsa32"))
        device->con->write = pl011_early_write_sbsa32;
    else
        device->con->write = pl011_early_write;

    return 0;
}


-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
