From: =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Subject: Re: [PATCH v4 16/28] tty: serial: owl: Implement console driver
Date: Mon, 3 Jul 2017 00:36:28 +0200
Message-ID: <223d7807-fd46-6bf7-1211-1ad5223e75c3@suse.de>
References: <20170606005426.26446-1-afaerber@suse.de>
 <20170606005426.26446-17-afaerber@suse.de>
 <CAHp75VcYtdxknAw5b1zp+qLi1MT3ktwm99rOJEivcBrc+9B-cg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75VcYtdxknAw5b1zp+qLi1MT3ktwm99rOJEivcBrc+9B-cg@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: support@lemaker.org, =?UTF-8?B?5byg5aSp55uK?= <tyzhang@actions-semi.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 96boards@ucrobotics.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Thomas Liau <thomas.liau@actions-semi.com>, mp-cs@actions-semi.com, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, =?UTF-8?B?5YiY54Kc?= <liuwei@actions-semi.com>, Jiri Slaby <jslaby@suse.com>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, =?UTF-8?B?5byg5Lic6aOO?= <zhangdf@actions-semi.com>, =?UTF-8?B?5qKF5Yip?= <harrymei@actions-semi.com>, support@cubietech.com, lee@cubietech.com
List-Id: linux-serial@vger.kernel.org

Am 07.06.2017 um 16:37 schrieb Andy Shevchenko:
> On Tue, Jun 6, 2017 at 3:54 AM, Andreas Färber <afaerber@suse.de> wrote:
>> Implement serial console driver to complement earlycon.
>>
>> Based on LeMaker linux-actions tree.
> 
>> +#define OWL_UART_CTL_DWLS_MASK         (0x3 << 0)
> 
> GENMASK() ?
> 
>> +#define OWL_UART_CTL_PRS_MASK          (0x7 << 4)
> 
> Ditto.
> 
>>  #define OWL_UART_STAT_TRFL_MASK                (0x1f << 11)
> 
> Ditto.

Changed.

>> +static struct owl_uart_port *owl_uart_ports[OWL_UART_PORT_NUM];
> 
> And this is needed for...?

That's what both the downstream driver and several in-tree drivers are
doing. See `git grep '_ports\[' -- drivers/tty/serial/`.

If you feel this is wrong, --verbose explanation please.

>> +static void owl_uart_set_mctrl(struct uart_port *port, unsigned int mctrl)
>> +{
>> +}
> 
> Do we need an empty stub?

The only flag I have found in the CTL register is AFE for automatic
RTS/CTS flow-control - RTS and CTS can only be read in STAT, not set.

And yes, if I drop this empty callback function, I get no serial output.

>> +static void owl_uart_send_chars(struct uart_port *port)
>> +{
> 
>> +               xmit->tail = (xmit->tail + 1) & (SERIAL_XMIT_SIZE - 1);
> 
> % SERIAL_XMIT_SIZE shorter (I hope it's a power of 2), but it's up to you.

crisv10 and meson_uart have it this way, modulo normalized whitespace.
No serial driver uses % for it.

>> +}
> 
>> +static irqreturn_t owl_uart_irq(int irq, void *dev_id)
>> +{
>> +       struct uart_port *port = (struct uart_port *)dev_id;
> 
> Useless casting.

Fixed.

>> +       spin_lock(&port->lock);
> 
> spin_lock_irqsave() ?

Fixed, with matching _irqrestore().

> Consider the kernel command option that switches all IRQ handlers to
> be threaded.
> 
>> +}
> 
>> +static void owl_uart_change_baudrate(struct owl_uart_port *owl_port,
>> +                                    unsigned long baud)
>> +{
>> +       clk_set_rate(owl_port->clk, baud * 8);
>> +}
> 
>> +static void owl_uart_release_port(struct uart_port *port)
>> +{
>> +       struct platform_device *pdev = to_platform_device(port->dev);
>> +       struct resource *res;
>> +
> 
>> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +       if (!res)
>> +               return;
>> +
>> +       if (port->flags & UPF_IOREMAP) {
>> +               devm_release_mem_region(port->dev, port->mapbase,
>> +                       resource_size(res));
>> +               devm_iounmap(port->dev, port->membase);
>> +               port->membase = NULL;
>> +       }
> 
> Above is entirely redundant.

Can you explain what this flag is used for and why some other drivers
implement it? That word alone is not helping.

>> +}
>> +
>> +static int owl_uart_request_port(struct uart_port *port)
>> +{
>> +       struct platform_device *pdev = to_platform_device(port->dev);
>> +       struct resource *res;
>> +
>> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +       if (!res)
>> +               return -ENXIO;
>> +
>> +       if (!devm_request_mem_region(port->dev, port->mapbase,
>> +                       resource_size(res), dev_name(port->dev)))
>> +               return -EBUSY;
>> +
>> +       if (port->flags & UPF_IOREMAP) {
>> +               port->membase = devm_ioremap_nocache(port->dev, port->mapbase,
>> +                               resource_size(res));
>> +               if (!port->membase)
>> +                       return -EBUSY;
>> +       }
>> +
>> +       return 0;
>> +}
> 
>> +static void owl_uart_config_port(struct uart_port *port, int flags)
>> +{
> 
>> +       if (flags & UART_CONFIG_TYPE) {
> 
> if (!(...))
>  return;
> 
> ?

Not a single serial driver does it that way.
I guess it prepares for handling other flags.

>> +               port->type = PORT_OWL;
>> +               owl_uart_request_port(port);
>> +       }
>> +}
> 
> 
>> +static int owl_uart_probe(struct platform_device *pdev)
>> +{
>> +       struct resource *res_mem, *res_irq;
>> +       struct owl_uart_port *owl_port;
>> +       int ret;
>> +
>> +       if (pdev->dev.of_node)
>> +               pdev->id = of_alias_get_id(pdev->dev.of_node, "serial");
>> +
>> +       if (pdev->id < 0 || pdev->id >= OWL_UART_PORT_NUM) {
>> +               dev_err(&pdev->dev, "id %d out of range\n", pdev->id);
>> +               return -EINVAL;
>> +       }
>> +
> 
> 
>> +       res_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +       if (!res_mem) {
>> +               dev_err(&pdev->dev, "could not get mem\n");
>> +               return -ENODEV;
>> +       }
> 
> You can use
> 
> struct resource *mem;
> 
> mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> x = devm_ioremap_resource();
> if (IS_ERR(x))
>  return PTR_ERR(x);
> 
> and remote IOREMAP flag below.

>> +       res_irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
>> +       if (!res_irq) {
>> +               dev_err(&pdev->dev, "could not get irq\n");
>> +               return -ENODEV;
>> +       }
> 
> platform_get_irq()

Adopted.

>> +       if (owl_uart_ports[pdev->id]) {
>> +               dev_err(&pdev->dev, "port %d already allocated\n", pdev->id);
>> +               return -EBUSY;
>> +       }
> 
> I guess it's redundant. It should be conflicting by resource (for example, IRQ).

No, currently not. Memory resources are allocated on request_port, IRQ
is requested on startup.

>> +       owl_port->clk = clk_get(&pdev->dev, NULL);
> 
> devm_ ?

Changed.

>> +       owl_port->port.iotype = UPIO_MEM;
>> +       owl_port->port.mapbase = res_mem->start;
>> +       owl_port->port.irq = res_irq->start;
> 
> 
>> +       owl_port->port.uartclk = clk_get_rate(owl_port->clk);
> 
> You need to check if it's 0 and use device property instead or bail out.

Fixed. Since this is a new driver, I'd rather not fall back to
clock-frequency property here. The binding has clocks property as required.

>> +       owl_port->port.flags = UPF_BOOT_AUTOCONF | UPF_IOREMAP | UPF_LOW_LATENCY;
>> +       owl_port->port.x_char = 0;
>> +       owl_port->port.fifosize = 16;
>> +       owl_port->port.ops = &owl_uart_ops;
>> +
>> +       owl_uart_ports[pdev->id] = owl_port;
> 
>> +       platform_set_drvdata(pdev, owl_port);
> 
> It should be just before return 0, right?..

Does it matter?

>> +
>> +       ret = uart_add_one_port(&owl_uart_driver, &owl_port->port);
>> +       if (ret)
>> +               owl_uart_ports[pdev->id] = NULL;
> 
> ...and thus, taking into consideration redundancy of that global var:
> 
>       ret = uart_add_one_port(&owl_uart_driver, &owl_port->port);
>       if (ret)
>           retrun ret;
> 
>       platform_set_drvdata(pdev, owl_port);
>       return 0;
> 
>> +       return ret;
>> +}
> 
>> +
>> +static int owl_uart_remove(struct platform_device *pdev)
>> +{
> 
>> +       struct owl_uart_port *owl_port;
>> +
>> +       owl_port = platform_get_drvdata(pdev);
> 
> Do above in one line.

Done.

>> +       uart_remove_one_port(&owl_uart_driver, &owl_port->port);
> 
>> +       owl_uart_ports[pdev->id] = NULL;
> 
> Redundant.
> 
>> +
>> +       return 0;
>> +}
> 
>> +/* Actions Semi Owl UART */
>> +#define PORT_OWL       117
> 
> We can use holes for now IIUC.
> 
> See 36 or alike

Okay. 36 works, too.

Please point to a good example of a serial driver that is not
"redundant" in your view. That will help also with other pending serial
drivers of mine. Thanks.

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
