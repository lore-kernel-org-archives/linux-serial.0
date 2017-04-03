From: Joel Stanley <joel-U3u1mxZcP9KHXe+LvDLADg@public.gmane.org>
Subject: Re: [PATCH 2/2] drivers/serial: Add driver for Aspeed virtual UART
Date: Mon, 3 Apr 2017 16:41:03 +0930
Message-ID: <CACPK8Xd0U9sbWb-ScJ-MR8qwsXwxhP6_mrnEj4AXkGO66X=7kQ@mail.gmail.com>
References: <20170328054458.29341-1-joel@jms.id.au> <20170328054458.29341-3-joel@jms.id.au>
 <CAHp75VfmbHrPFXO3UFmSciCnVuoB+5vFxy7iOnwVS5YBSPO3+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAHp75VfmbHrPFXO3UFmSciCnVuoB+5vFxy7iOnwVS5YBSPO3+Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jeremy Kerr <jk-mnsaURCQ41sdnm+yROfE0A@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, OpenBMC Maillist <openbmc-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

Hi Andy,

Thanks for the review. I've incorporatd most of your comments in a v2
that I'll send out once I've given it a spin on hardware.

On Sun, Apr 2, 2017 at 10:37 PM, Andy Shevchenko
<andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> +static ssize_t ast_vuart_show_addr(struct device *dev,
>> +               struct device_attribute *attr, char *buf)
>> +{
>> +       struct ast_vuart *vuart = dev_get_drvdata(dev);
>> +       u16 addr;
>> +
>
>> +       addr = (readb(vuart->regs + AST_VUART_ADDRH) << 8) |
>> +               (readb(vuart->regs + AST_VUART_ADDRL));
>
> It looks like you have register shift 2 bits and byte accessors. We
> have some helpers for that (serial_in() / serial_out() or alike).

Thanks for the pointer. I took a look at this. It looks like I need to
define my own accessor?

I don't think it's worth it for the one read and one write we have in
this driver.

>
>> +
>> +       return snprintf(buf, PAGE_SIZE - 1, "0x%x\n", addr);
>> +}
>> +

>> +static int ast_vuart_probe(struct platform_device *pdev)
>> +{
>> +       struct uart_8250_port port;
>> +       struct resource resource;
>> +       struct ast_vuart *vuart;
>> +       struct device_node *np;
>> +       u32 clk, prop;
>> +       int rc;
>> +
>
>> +       np = pdev->dev.of_node;
>
> And if np == NULL?

The driver will fail to probe due to the of_property_read_u32 calls
returning an error.

>> +       /* If current-speed was set, then try not to change it. */
>> +       if (of_property_read_u32(np, "current-speed", &prop) == 0)
>> +               port.port.custom_divisor = clk / (16 * prop);
>> +
>> +       /* Check for shifted address mapping */
>> +       if (of_property_read_u32(np, "reg-offset", &prop) == 0)
>> +               port.port.mapbase += prop;
>> +
>> +       /* Check for registers offset within the devices address range */
>> +       if (of_property_read_u32(np, "reg-shift", &prop) == 0)
>> +               port.port.regshift = prop;
>> +
>> +       /* Check for fifo size */
>> +       if (of_property_read_u32(np, "fifo-size", &prop) == 0)
>> +               port.port.fifosize = prop;
>
> Perhaps you need other way around, check for error and supply a
> default in such case.

We leave port.fifosize unmodified (set to zero) if there is no valid
device tree property. As the property is optional, it's not an error
if it's not present.

>> +
>> +       /* Check for a fixed line number */
>> +       rc = of_alias_get_id(np, "serial");
>> +       if (rc >= 0)
>> +               port.port.line = rc;
>> +
>> +       port.port.irq = irq_of_parse_and_map(np, 0);
>
>> +       port.port.irqflags = IRQF_SHARED;
>
> This is set by core. You already supplied correct flag for that below.

By setting UPF_SHARE_IRQ the core does correctly requset_irq with
IRQF_SHARED set. However, it does not store this in in port->irqflags,
so other tests in eg. serial8250_do_startup that test for IRQF_SHARED
will fail. This is a bug that we hit the other day.

Would you like a patch to the core that either tests for
UPF_SHARE_IRQ, or set IRQF_SHARED early on?

>
>> +       port.port.iotype = UPIO_MEM;
>> +       if (of_property_read_u32(np, "reg-io-width", &prop) == 0) {
>
> You hide an error code from of_property_read_u32() here. Why?

The property is optional, so if it doesn't exist we want to continue
without error.

We return EINVAL if the property is invalid, as the device tree code
will give us ENODATA or EOVERFLOW, which I don't think is informative
for a driver to return.

> And if there is an error you are continuing with what? 0?

we continue with port.port.iotype = UPIO_MEM from above.

>> +               switch (prop) {
>> +               case 1:
>> +                       port.port.iotype = UPIO_MEM;
>> +                       break;
>> +               case 4:
>> +                       port.port.iotype = of_device_is_big_endian(np) ?
>> +                                      UPIO_MEM32BE : UPIO_MEM32;
>> +                       break;
>> +               default:
>> +                       dev_warn(&pdev->dev, "unsupported reg-io-width (%d)\n",
>> +                                prop);
>> +                       rc = -EINVAL;
>> +                       goto err_clk_disable;
>> +               }
>> +       }

Cheers,

Joel
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
