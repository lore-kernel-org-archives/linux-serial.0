From: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] drivers/serial: Add driver for Aspeed virtual UART
Date: Sun, 2 Apr 2017 16:07:59 +0300
Message-ID: <CAHp75VfmbHrPFXO3UFmSciCnVuoB+5vFxy7iOnwVS5YBSPO3+Q@mail.gmail.com>
References: <20170328054458.29341-1-joel@jms.id.au> <20170328054458.29341-3-joel@jms.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170328054458.29341-3-joel-U3u1mxZcP9KHXe+LvDLADg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joel Stanley <joel-U3u1mxZcP9KHXe+LvDLADg@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jeremy Kerr <jk-mnsaURCQ41sdnm+yROfE0A@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, openbmc-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On Tue, Mar 28, 2017 at 8:44 AM, Joel Stanley <joel-U3u1mxZcP9KHXe+LvDLADg@public.gmane.org> wrote:
> This change adds a driver for the 16550-based Aspeed virtual UART
> device. We use a similar process to the of_serial driver for device
> probe, but expose some VUART-specific functions through sysfs too.
>
> OpenPOWER host firmware doesn't like it when the host-side of the
> VUART's FIFO is not drained. This driver only disables host TX discard
> mode when the port is in use. We set the VUART enabled bit when we bind
> to the device, and clear it on unbind.
>
> We don't want to do this on open/release, as the host may be using this
> bit to configure serial output modes, which is independent of whether
> the devices has been opened by BMC userspace.

>  Documentation/devicetree/bindings/serial/8250.txt |   2 +
>  drivers/tty/serial/Kconfig                        |  10 +
>  drivers/tty/serial/Makefile                       |   1 +
>  drivers/tty/serial/aspeed-vuart.c                 | 335 ++++++++++++++++++++++

And why it's not under 8250 folder?

> +#include <linux/device.h>
> +#include <linux/module.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +#include <linux/of_platform.h>
> +#include <linux/clk.h>
> +
> +#include "8250/8250.h"
> +
> +#define AST_VUART_GCRA         0x20

> +#define AST_VUART_GCRA_VUART_EN                0x01
> +#define AST_VUART_GCRA_HOST_TX_DISCARD 0x20

BIT(x) ?

> +#define AST_VUART_GCRB         0x24

> +#define AST_VUART_GCRB_HOST_SIRQ_MASK  0xf0

GENMASK() ?

> +#define AST_VUART_GCRB_HOST_SIRQ_SHIFT 4
> +#define AST_VUART_ADDRL                0x28
> +#define AST_VUART_ADDRH                0x2c
> +
> +struct ast_vuart {

> +       struct platform_device *pdev;

Ususally there is no need to keep pointer to sturct platform_device,
rahter we need struct device *dev.

> +       void __iomem            *regs;
> +       struct clk              *clk;
> +       int                     line;
> +};
> +
> +static ssize_t ast_vuart_show_addr(struct device *dev,
> +               struct device_attribute *attr, char *buf)
> +{
> +       struct ast_vuart *vuart = dev_get_drvdata(dev);
> +       u16 addr;
> +

> +       addr = (readb(vuart->regs + AST_VUART_ADDRH) << 8) |
> +               (readb(vuart->regs + AST_VUART_ADDRL));

It looks like you have register shift 2 bits and byte accessors. We
have some helpers for that (serial_in() / serial_out() or alike).

> +
> +       return snprintf(buf, PAGE_SIZE - 1, "0x%x\n", addr);
> +}
> +
> +static ssize_t ast_vuart_set_addr(struct device *dev,
> +               struct device_attribute *attr,
> +               const char *buf, size_t count)
> +{
> +       struct ast_vuart *vuart = dev_get_drvdata(dev);
> +       unsigned long val;
> +       int err;
> +
> +       err = kstrtoul(buf, 0, &val);
> +       if (err)
> +               return err;
> +

> +       writeb((val >> 8) & 0xff, vuart->regs + AST_VUART_ADDRH);
> +       writeb((val >> 0) & 0xff, vuart->regs + AST_VUART_ADDRL);

Useless & 0xff.

> +
> +       return count;
> +}

> +}
> +
> +

Extra empty line.

> +/**

If you are going to use kernel doc do it in accordance with howto.

> + * The device tree parsing code here is heavily based on that of the of_serial
> + * driver, but we have a few core differences, as we need to use our own
> + * ioremapping for extra register support
> + */

> +static int ast_vuart_probe(struct platform_device *pdev)
> +{
> +       struct uart_8250_port port;
> +       struct resource resource;
> +       struct ast_vuart *vuart;
> +       struct device_node *np;
> +       u32 clk, prop;
> +       int rc;
> +

> +       np = pdev->dev.of_node;

And if np == NULL?

> +
> +       vuart = devm_kzalloc(&pdev->dev, sizeof(*vuart), GFP_KERNEL);
> +       if (!vuart)
> +               return -ENOMEM;
> +
> +       vuart->pdev = pdev;


> +       rc = of_address_to_resource(np, 0, &resource);
> +       if (rc) {
> +               dev_warn(&pdev->dev, "invalid address\n");
> +               return rc;
> +       }
> +
> +       /* create our own mapping for VUART-specific registers */
> +       vuart->regs = devm_ioremap_resource(&pdev->dev, &resource);
> +       if (IS_ERR(vuart->regs)) {
> +               dev_warn(&pdev->dev, "failed to map registers\n");
> +               return PTR_ERR(vuart->regs);
> +       }

Can you use platform_get-resource() + devm_ioremap_resource() ?
If no, why?

> +
> +       memset(&port, 0, sizeof(port));
> +       port.port.private_data = vuart;
> +       port.port.membase = vuart->regs;
> +       port.port.mapbase = resource.start;
> +       port.port.mapsize = resource_size(&resource);
> +       port.port.startup = ast_vuart_startup;
> +       port.port.shutdown = ast_vuart_shutdown;
> +
> +       if (of_property_read_u32(np, "clock-frequency", &clk)) {
> +               vuart->clk = devm_clk_get(&pdev->dev, NULL);
> +               if (IS_ERR(vuart->clk)) {
> +                       dev_warn(&pdev->dev,
> +                               "clk or clock-frequency not defined\n");
> +                       return PTR_ERR(vuart->clk);
> +               }
> +
> +               rc = clk_prepare_enable(vuart->clk);
> +               if (rc < 0)
> +                       return rc;
> +
> +               clk = clk_get_rate(vuart->clk);
> +       }
> +

> +       /* If current-speed was set, then try not to change it. */
> +       if (of_property_read_u32(np, "current-speed", &prop) == 0)
> +               port.port.custom_divisor = clk / (16 * prop);
> +
> +       /* Check for shifted address mapping */
> +       if (of_property_read_u32(np, "reg-offset", &prop) == 0)
> +               port.port.mapbase += prop;
> +
> +       /* Check for registers offset within the devices address range */
> +       if (of_property_read_u32(np, "reg-shift", &prop) == 0)
> +               port.port.regshift = prop;
> +
> +       /* Check for fifo size */
> +       if (of_property_read_u32(np, "fifo-size", &prop) == 0)
> +               port.port.fifosize = prop;

Perhaps you need other way around, check for error and supply a
default in such case.

> +
> +       /* Check for a fixed line number */
> +       rc = of_alias_get_id(np, "serial");
> +       if (rc >= 0)
> +               port.port.line = rc;
> +
> +       port.port.irq = irq_of_parse_and_map(np, 0);

> +       port.port.irqflags = IRQF_SHARED;

This is set by core. You already supplied correct flag for that below.

> +       port.port.iotype = UPIO_MEM;
> +       if (of_property_read_u32(np, "reg-io-width", &prop) == 0) {

You hide an error code from of_property_read_u32() here. Why?

And if there is an error you are continuing with what? 0?

> +               switch (prop) {
> +               case 1:
> +                       port.port.iotype = UPIO_MEM;
> +                       break;
> +               case 4:
> +                       port.port.iotype = of_device_is_big_endian(np) ?
> +                                      UPIO_MEM32BE : UPIO_MEM32;
> +                       break;
> +               default:
> +                       dev_warn(&pdev->dev, "unsupported reg-io-width (%d)\n",
> +                                prop);
> +                       rc = -EINVAL;
> +                       goto err_clk_disable;
> +               }
> +       }
> +
> +       port.port.type = PORT_16550A;
> +       port.port.uartclk = clk;
> +       port.port.flags = UPF_SHARE_IRQ | UPF_BOOT_AUTOCONF
> +               | UPF_FIXED_PORT | UPF_FIXED_TYPE | UPF_NO_THRE_TEST;
> +

> +       if (of_find_property(np, "no-loopback-test", NULL))
> +               port.port.flags |= UPF_SKIP_TEST;

You perhaps meant _read_bool() for sake of consistency.

> +
> +       port.port.dev = &pdev->dev;
> +
> +       if (port.port.fifosize)
> +               port.capabilities = UART_CAP_FIFO;
> +

> +       if (of_property_read_bool(pdev->dev.of_node,
> +                                 "auto-flow-control"))

One line?

> +               port.capabilities |= UART_CAP_AFE;
> +
> +       rc = serial8250_register_8250_port(&port);
> +       if (rc < 0)
> +               goto err_clk_disable;
> +
> +
> +       vuart->line = rc;
> +       ast_vuart_set_enabled(vuart, true);
> +       ast_vuart_set_host_tx_discard(vuart, true);
> +       platform_set_drvdata(pdev, vuart);
> +
> +       /* extra sysfs control */
> +       rc = device_create_file(&pdev->dev, &dev_attr_lpc_address);
> +       if (rc)
> +               dev_warn(&pdev->dev, "can't create lpc_address file\n");
> +       rc = device_create_file(&pdev->dev, &dev_attr_sirq);
> +       if (rc)
> +               dev_warn(&pdev->dev, "can't create sirq file\n");
> +
> +       return 0;
> +
> +err_clk_disable:
> +       if (vuart->clk)
> +               clk_disable_unprepare(vuart->clk);
> +
> +       irq_dispose_mapping(port.port.irq);
> +       return rc;
> +}
> +
> +static int ast_vuart_remove(struct platform_device *pdev)
> +{
> +       struct ast_vuart *vuart = platform_get_drvdata(pdev);
> +
> +       ast_vuart_set_enabled(vuart, false);
> +
> +       if (vuart->clk)
> +               clk_disable_unprepare(vuart->clk);
> +       return 0;
> +}

-- 
With Best Regards,
Andy Shevchenk
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
