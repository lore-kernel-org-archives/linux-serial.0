From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v7 2/3] serial: exar: split out the exar code from 8250_pci
Date: Sun, 8 Jan 2017 03:02:30 +0200
Message-ID: <CAHp75Vdirfo6ioAa_mZ+gXRHRjFUqy13-naBJYn8+O2FxPMDYg@mail.gmail.com>
References: <1483833469-11422-1-git-send-email-sudipm.mukherjee@gmail.com> <1483833469-11422-3-git-send-email-sudipm.mukherjee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1483833469-11422-3-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Sun, Jan 8, 2017 at 1:57 AM, Sudip Mukherjee
<sudipm.mukherjee@gmail.com> wrote:
> Add the serial driver for the exar chips. And also register the
> platform device for the exar gpio.

Did you ignore some comments?

IIRC I recommended to use proper vendor name like Exar (or how is it spelled?).

> Headers, if arranged in alphabetical order, will give a build warning.

I think I know how to make it better.

> And thanks for revewing that v6. I think those were the worst patch I
> have ever posted.

You may do even more better. See below.

> +#undef DEBUG

> +#include <asm/byteorder.h>

(1)

> +#include <linux/pci.h>

Squeez this to the rest

> +#include <linux/8250_pci.h>

(2)

> +#include <linux/bitops.h>
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/serial_core.h>
> +#include <linux/serial_reg.h>
> +#include <linux/slab.h>
> +#include <linux/string.h>
> +#include <linux/tty.h>

You perhaps need something like this here:

+ empty line
(1) +#include <asm/byteorder.h>

> +

(2) +#include <linux/8250_pci.h>

> +#include "8250.h"

> +
> +#define PCI_NUM_BAR_RESOURCES  6
> +
> +struct exar8250;


> +
> +struct exar8250_board {
> +       unsigned int num_ports;
> +       unsigned int base_baud;
> +       unsigned int uart_offset; /* the space between channels */
> +       /*
> +        * reg_shift:  describes how the UART registers are mapped
> +        * to PCI memory by the card.
> +        */
> +       unsigned int reg_shift;
> +       unsigned int first_offset;
> +       int     (*setup)(struct exar8250 *,
> +                        const struct exar8250_board *,
> +                        struct uart_8250_port *, int);
> +       void    (*exit)(struct pci_dev *dev);
> +};
> +
> +struct exar8250 {

> +       struct pci_dev          *dev;

You perhaps don't need to save parent device, thus

struct device *dev;

here and users will do

struct pci_dev *pci_dev = to_pci_dev(dev);

when needed.

> +       unsigned int            nr;
> +       struct exar8250_board   *board;
> +       int                     line[0];
> +};
> +
> +static int default_setup(struct exar8250 *priv,
> +                            const struct exar8250_board *board,
> +                            struct uart_8250_port *port, int idx)
> +{
> +       unsigned int bar = 0, offset = board->first_offset, maxnr;
> +       struct pci_dev *dev = priv->dev;
> +
> +       offset += idx * board->uart_offset;
> +

> +       maxnr = (pci_resource_len(dev, bar) - board->first_offset) >>
> +               (board->reg_shift + 3);

Can be calculated once?

> +
> +       if (idx >= maxnr)
> +               return 1;
> +

> +       if (!pcim_iomap(dev, bar, 0) && !pcim_iomap_table(dev))
> +               return -ENOMEM;

Do you need to check this per port? In probe you would know this.

> +
> +       port->port.iotype = UPIO_MEM;
> +       port->port.iobase = 0;
> +       port->port.mapbase = pci_resource_start(dev, bar) + offset;
> +       port->port.membase = pcim_iomap_table(dev)[bar] + offset;
> +       port->port.regshift = board->reg_shift;
> +
> +       return 0;
> +}
> +
> +static int
> +pci_xr17c154_setup(struct exar8250 *priv,
> +                  const struct exar8250_board *board,
> +                 struct uart_8250_port *port, int idx)
> +{
> +       port->port.flags |= UPF_EXAR_EFR;
> +       return default_setup(priv, board, port, idx);
> +}
> +

> +static inline int
> +xr17v35x_has_slave(struct exar8250 *priv)
> +{
> +       const int dev_id = priv->dev->device;
> +
> +       return ((dev_id == PCI_DEVICE_ID_EXAR_XR17V4358) ||
> +               (dev_id == PCI_DEVICE_ID_EXAR_XR17V8358));
> +}

Can be easily converted to
unsigned int flags;
in your custom struct, and be assigned constantly based on ID.

> +
> +static int
> +pci_xr17v35x_setup(struct exar8250 *priv,
> +                  const struct exar8250_board *board,
> +                 struct uart_8250_port *port, int idx)
> +{
> +       u8 __iomem *p;
> +       int ret;
> +
> +       p = pci_ioremap_bar(priv->dev, 0);
> +       if (!p)
> +               return -ENOMEM;
> +
> +       port->port.flags |= UPF_EXAR_EFR;
> +
> +       /*
> +        * Setup the uart clock for the devices on expansion slot to
> +        * half the clock speed of the main chip (which is 125MHz)
> +        */
> +       if (xr17v35x_has_slave(priv) && idx >= 8)
> +               port->port.uartclk = (7812500 * 16 / 2);
> +
> +       /*
> +        * Setup Multipurpose Input/Output pins.
> +        */

> +       if (idx == 0) {
> +               writeb(0x00, p + UART_EXAR_MPIOINT_7_0);
> +               writeb(0x00, p + UART_EXAR_MPIOLVL_7_0);
> +               writeb(0x00, p + UART_EXAR_MPIO3T_7_0);
> +               writeb(0x00, p + UART_EXAR_MPIOINV_7_0);
> +               writeb(0x00, p + UART_EXAR_MPIOSEL_7_0);
> +               writeb(0x00, p + UART_EXAR_MPIOOD_7_0);
> +               writeb(0x00, p + UART_EXAR_MPIOINT_15_8);
> +               writeb(0x00, p + UART_EXAR_MPIOLVL_15_8);
> +               writeb(0x00, p + UART_EXAR_MPIO3T_15_8);
> +               writeb(0x00, p + UART_EXAR_MPIOINV_15_8);
> +               writeb(0x00, p + UART_EXAR_MPIOSEL_15_8);
> +               writeb(0x00, p + UART_EXAR_MPIOOD_15_8);
> +       }

I would move it to some helper function.

> +       writeb(0x00, p + UART_EXAR_8XMODE);
> +       writeb(UART_FCTR_EXAR_TRGD, p + UART_EXAR_FCTR);
> +       writeb(128, p + UART_EXAR_TXTRG);
> +       writeb(128, p + UART_EXAR_RXTRG);
> +       iounmap(p);
> +
> +       ret = default_setup(priv, board, port, idx);
> +       if (ret)
> +               return ret;
> +
> +       if (idx == 0) {

> +               struct platform_device *device;

Be consistent.
*pdev;

> +
> +               device = platform_device_alloc("gpio_exar",
> +                                              PLATFORM_DEVID_AUTO);
> +               if (!device)
> +                       return -ENOMEM;
> +
> +               platform_set_drvdata(device, priv->dev);
> +               if (platform_device_add(device) < 0) {
> +                       platform_device_put(device);
> +                       return -ENODEV;
> +               }
> +
> +               port->port.private_data = device;

Either this to move to another helper.

xr17v35x_register_gpio();

> +       }
> +
> +       return 0;
> +}
> +
> +static void pci_xr17v35x_exit(struct pci_dev *dev)
> +{
> +       struct exar8250 *priv = pci_get_drvdata(dev);
> +       struct uart_8250_port *port = serial8250_get_port(priv->line[0]);
> +       struct platform_device *pdev = port->port.private_data;
> +
> +       if (pdev) {
> +               platform_device_unregister(pdev);
> +               port->port.private_data = NULL;
> +       }
> +}
> +
> +static int
> +exar_pci_probe(struct pci_dev *dev, const struct pci_device_id *ent)
> +{
> +       struct exar8250_board *board;
> +       struct uart_8250_port uart;
> +       struct exar8250 *priv;
> +       int nr_ports, i;
> +       int rc;
> +
> +       board = (struct exar8250_board *)ent->driver_data;
> +
> +       rc = pcim_enable_device(dev);

> +       pci_save_state(dev);

What for?

> +       if (rc)
> +               return rc;
> +
> +       nr_ports = board->num_ports;
> +
> +       priv = kzalloc(sizeof(*priv) + sizeof(unsigned int) * nr_ports,
> +                      GFP_KERNEL);

devm_kzalloc();

> +       if (!priv)
> +               return -ENOMEM;
> +
> +       priv->dev = dev;
> +       priv->board = board;
> +
> +       memset(&uart, 0, sizeof(uart));
> +       uart.port.flags = UPF_SKIP_TEST | UPF_BOOT_AUTOCONF | UPF_SHARE_IRQ;
> +       uart.port.uartclk = board->base_baud * 16;
> +       uart.port.irq = dev->irq;
> +       uart.port.dev = &dev->dev;
> +
> +       for (i = 0; i < nr_ports; i++) {
> +               if (board->setup(priv, board, &uart, i))
> +                       break;
> +
> +               dev_dbg(&dev->dev, "Setup PCI port: port %lx, irq %d, type %d\n",
> +                       uart.port.iobase, uart.port.irq, uart.port.iotype);
> +
> +               priv->line[i] = serial8250_register_8250_port(&uart);
> +               if (priv->line[i] < 0) {
> +                       dev_err(&dev->dev,
> +                               "Couldn't register serial port %lx, irq %d, type %d, error %d\n",
> +                               uart.port.iobase, uart.port.irq,
> +                               uart.port.iotype, priv->line[i]);
> +                       break;
> +               }
> +       }
> +       priv->nr = i;
> +       pci_set_drvdata(dev, priv);
> +       return 0;
> +}
> +
> +static void exar_pci_remove(struct pci_dev *dev)
> +{
> +       int i;
> +       struct exar8250 *priv = pci_get_drvdata(dev);
> +
> +       for (i = 0; i < priv->nr; i++)
> +               serial8250_unregister_port(priv->line[i]);
> +
> +       if (priv->board->exit)
> +               priv->board->exit(priv->dev);
> +
> +       kfree(priv);
> +}
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int exar_suspend(struct device *dev)
> +{

> +       int i;

Move it below...

> +       struct pci_dev *pdev = to_pci_dev(dev);
> +       struct exar8250 *priv = pci_get_drvdata(pdev);

...here
unsigned int i;

> +
> +
> +       for (i = 0; i < priv->nr; i++)
> +               if (priv->line[i] >= 0)
> +                       serial8250_suspend_port(priv->line[i]);
> +
> +       /*
> +        * Ensure that every init quirk is properly torn down
> +        */
> +       if (priv->board->exit)
> +               priv->board->exit(priv->dev);
> +
> +       return 0;
> +}
> +
> +static int exar_resume(struct device *dev)
> +{
> +       int i;
> +       int err;
> +       struct pci_dev *pdev = to_pci_dev(dev);
> +       struct exar8250 *priv = pci_get_drvdata(pdev);

Ditto.

> +
> +       if (priv) {

> +               /*
> +                * The device may have been disabled.  Re-enable it.
> +                */
> +               err = pci_enable_device(pdev);
> +               /* FIXME: We cannot simply error out here */
> +               if (err)
> +                       dev_err(dev, "Unable to re-enable ports, trying to continue.\n");

Do you really need this?

> +
> +               for (i = 0; i < priv->nr; i++)
> +                       if (priv->line[i] >= 0)
> +                               serial8250_resume_port(priv->line[i]);
> +       }
> +       return 0;
> +}
> +#endif
> +
> +static SIMPLE_DEV_PM_OPS(exar_pci_pm, exar_suspend, exar_resume);
> +
> +static const struct exar8250_board pbn_b0_2_1843200_200 = {
> +       .num_ports      = 2,
> +       .base_baud      = 1843200,
> +       .uart_offset    = 0x200,
> +       .setup          = pci_xr17c154_setup
> +};
> +
> +static const struct exar8250_board pbn_b0_4_1843200_200 = {
> +       .num_ports      = 4,
> +       .base_baud      = 1843200,
> +       .uart_offset    = 0x200,
> +       .setup          = pci_xr17c154_setup
> +};
> +
> +static const struct exar8250_board pbn_b0_8_1843200_200 = {
> +       .num_ports      = 8,
> +       .base_baud      = 1843200,
> +       .uart_offset    = 0x200,
> +       .setup          = pci_xr17c154_setup,
> +};
> +
> +static const struct exar8250_board pbn_exar_ibm_saturn = {
> +       .num_ports      = 1,
> +       .base_baud      = 921600,
> +       .uart_offset    = 0x200,
> +       .setup          = pci_xr17c154_setup,
> +};
> +
> +static const struct exar8250_board pbn_exar_XR17C152 = {
> +       .num_ports      = 2,
> +       .base_baud      = 921600,
> +       .uart_offset    = 0x200,
> +       .setup          = pci_xr17c154_setup,
> +};
> +
> +static const struct exar8250_board pbn_exar_XR17C154 = {
> +       .num_ports      = 4,
> +       .base_baud      = 921600,
> +       .uart_offset    = 0x200,
> +       .setup          = pci_xr17c154_setup,
> +};
> +
> +static const struct exar8250_board pbn_exar_XR17C158 = {
> +       .num_ports      = 8,
> +       .base_baud      = 921600,
> +       .uart_offset    = 0x200,
> +       .setup          = pci_xr17c154_setup,
> +};
> +
> +static const struct exar8250_board pbn_exar_XR17V352 = {
> +       .num_ports      = 2,
> +       .base_baud      = 7812500,
> +       .uart_offset    = 0x400,
> +       .setup          = pci_xr17v35x_setup,
> +       .exit           = pci_xr17v35x_exit,
> +};
> +
> +static const struct exar8250_board pbn_exar_XR17V354 = {
> +       .num_ports      = 4,
> +       .base_baud      = 7812500,
> +       .uart_offset    = 0x400,
> +       .setup          = pci_xr17v35x_setup,
> +       .exit           = pci_xr17v35x_exit,
> +};
> +
> +static const struct exar8250_board pbn_exar_XR17V358 = {
> +       .num_ports      = 8,
> +       .base_baud      = 7812500,
> +       .uart_offset    = 0x400,
> +       .setup          = pci_xr17v35x_setup,
> +       .exit           = pci_xr17v35x_exit,
> +};
> +
> +static const struct exar8250_board pbn_exar_XR17V4358 = {
> +       .num_ports      = 12,
> +       .base_baud      = 7812500,
> +       .uart_offset    = 0x400,
> +       .setup          = pci_xr17v35x_setup,
> +       .exit           = pci_xr17v35x_exit,
> +};
> +
> +static const struct exar8250_board pbn_exar_XR17V8358 = {
> +       .num_ports      = 16,
> +       .base_baud      = 7812500,
> +       .uart_offset    = 0x400,
> +       .setup          = pci_xr17v35x_setup,
> +       .exit           = pci_xr17v35x_exit,
> +};
> +
> +static struct pci_device_id exar_pci_tbl[] = {
> +       {       PCI_DEVICE_SUB(PCI_VENDOR_ID_EXAR,
> +               PCI_DEVICE_ID_EXAR_XR17C152,
> +               PCI_SUBVENDOR_ID_CONNECT_TECH,
> +               PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_232), 0, 0,
> +               (kernel_ulong_t)&pbn_b0_2_1843200_200 },

You ignored my comment regarding to make a macro(s).

Moreover, some of data, like number of ports, can be easily calculated
from device ID.

Try smarter, you may reduce amount of lines here at least twice! And
don't ignore my comments.

> +       {       PCI_DEVICE_SUB(PCI_VENDOR_ID_EXAR,
> +               PCI_DEVICE_ID_EXAR_XR17C154,
> +               PCI_SUBVENDOR_ID_CONNECT_TECH,
> +               PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_232), 0, 0,
> +               (kernel_ulong_t)&pbn_b0_4_1843200_200 },
> +       {       PCI_DEVICE_SUB(PCI_VENDOR_ID_EXAR,
> +               PCI_DEVICE_ID_EXAR_XR17C158,
> +               PCI_SUBVENDOR_ID_CONNECT_TECH,
> +               PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_232), 0, 0,
> +               (kernel_ulong_t)&pbn_b0_8_1843200_200 },
> +       {       PCI_DEVICE_SUB(PCI_VENDOR_ID_EXAR,
> +               PCI_DEVICE_ID_EXAR_XR17C152,
> +               PCI_SUBVENDOR_ID_CONNECT_TECH,
> +               PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_1_1), 0, 0,
> +               (kernel_ulong_t)&pbn_b0_2_1843200_200 },
> +       {       PCI_DEVICE_SUB(PCI_VENDOR_ID_EXAR,
> +               PCI_DEVICE_ID_EXAR_XR17C154,
> +               PCI_SUBVENDOR_ID_CONNECT_TECH,
> +               PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_2), 0, 0,
> +               (kernel_ulong_t)&pbn_b0_4_1843200_200 },
> +       {       PCI_DEVICE_SUB(PCI_VENDOR_ID_EXAR,
> +               PCI_DEVICE_ID_EXAR_XR17C158,
> +               PCI_SUBVENDOR_ID_CONNECT_TECH,
> +               PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_4), 0, 0,
> +               (kernel_ulong_t)&pbn_b0_8_1843200_200 },
> +       {       PCI_DEVICE_SUB(PCI_VENDOR_ID_EXAR,
> +               PCI_DEVICE_ID_EXAR_XR17C152,
> +               PCI_SUBVENDOR_ID_CONNECT_TECH,
> +               PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2), 0, 0,
> +               (kernel_ulong_t)&pbn_b0_2_1843200_200 },
> +       {       PCI_DEVICE_SUB(PCI_VENDOR_ID_EXAR,
> +               PCI_DEVICE_ID_EXAR_XR17C154,
> +               PCI_SUBVENDOR_ID_CONNECT_TECH,
> +               PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4), 0, 0,
> +               (kernel_ulong_t)&pbn_b0_4_1843200_200 },
> +       {       PCI_DEVICE_SUB(PCI_VENDOR_ID_EXAR,
> +               PCI_DEVICE_ID_EXAR_XR17C158,
> +               PCI_SUBVENDOR_ID_CONNECT_TECH,
> +               PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8), 0, 0,
> +               (kernel_ulong_t)&pbn_b0_8_1843200_200 },
> +       {       PCI_DEVICE_SUB(PCI_VENDOR_ID_EXAR,
> +               PCI_DEVICE_ID_EXAR_XR17C152,
> +               PCI_SUBVENDOR_ID_CONNECT_TECH,
> +               PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_485), 0, 0,
> +               (kernel_ulong_t)&pbn_b0_2_1843200_200 },
> +       {       PCI_DEVICE_SUB(PCI_VENDOR_ID_EXAR,
> +               PCI_DEVICE_ID_EXAR_XR17C154,
> +               PCI_SUBVENDOR_ID_CONNECT_TECH,
> +               PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_485), 0, 0,
> +               (kernel_ulong_t)&pbn_b0_4_1843200_200 },
> +       {       PCI_DEVICE_SUB(PCI_VENDOR_ID_EXAR,
> +               PCI_DEVICE_ID_EXAR_XR17C158,
> +               PCI_SUBVENDOR_ID_CONNECT_TECH,
> +               PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_485), 0, 0,
> +               (kernel_ulong_t)&pbn_b0_8_1843200_200 },
> +       {       PCI_DEVICE_SUB(PCI_VENDOR_ID_EXAR,
> +               PCI_DEVICE_ID_EXAR_XR17C152,
> +               PCI_VENDOR_ID_IBM,
> +               PCI_SUBDEVICE_ID_IBM_SATURN_SERIAL_ONE_PORT), 0, 0,
> +               (kernel_ulong_t)&pbn_exar_ibm_saturn },
> +       /*
> +        * Exar Corp. XR17C15[248] Dual/Quad/Octal UART
> +        */
> +       {       PCI_VDEVICE(EXAR, PCI_DEVICE_ID_EXAR_XR17C152),
> +               (kernel_ulong_t)&pbn_exar_XR17C152 },
> +       {       PCI_VDEVICE(EXAR, PCI_DEVICE_ID_EXAR_XR17C154),
> +               (kernel_ulong_t)&pbn_exar_XR17C154 },
> +       {       PCI_VDEVICE(EXAR, PCI_DEVICE_ID_EXAR_XR17C158),
> +               (kernel_ulong_t)&pbn_exar_XR17C158 },
> +       /*
> +        * Exar Corp. XR17V[48]35[248] Dual/Quad/Octal/Hexa PCIe UARTs
> +        */
> +       {       PCI_VDEVICE(EXAR, PCI_DEVICE_ID_EXAR_XR17V352),
> +               (kernel_ulong_t)&pbn_exar_XR17V352 },
> +       {       PCI_VDEVICE(EXAR, PCI_DEVICE_ID_EXAR_XR17V354),
> +               (kernel_ulong_t)&pbn_exar_XR17V354 },
> +       {       PCI_VDEVICE(EXAR, PCI_DEVICE_ID_EXAR_XR17V358),
> +               (kernel_ulong_t)&pbn_exar_XR17V358 },
> +       {       PCI_VDEVICE(EXAR, PCI_DEVICE_ID_EXAR_XR17V4358),
> +               (kernel_ulong_t)&pbn_exar_XR17V4358 },
> +       {       PCI_VDEVICE(EXAR, PCI_DEVICE_ID_EXAR_XR17V8358),
> +               (kernel_ulong_t)&pbn_exar_XR17V8358 },
> +       {       PCI_VDEVICE(COMMTECH, PCI_DEVICE_ID_COMMTECH_4222PCIE),
> +               (kernel_ulong_t)&pbn_exar_XR17V352 },
> +       {       PCI_VDEVICE(COMMTECH, PCI_DEVICE_ID_COMMTECH_4224PCIE),
> +               (kernel_ulong_t)&pbn_exar_XR17V354 },
> +       {       PCI_VDEVICE(COMMTECH, PCI_DEVICE_ID_COMMTECH_4228PCIE),
> +               (kernel_ulong_t)&pbn_exar_XR17V358 },
> +       { 0, }
> +};
> +
> +static struct pci_driver exar_pci_driver = {
> +       .name           = "exar_serial",
> +       .probe          = exar_pci_probe,
> +       .remove         = exar_pci_remove,
> +       .driver         = {
> +               .pm     = &exar_pci_pm,
> +       },
> +       .id_table       = exar_pci_tbl,
> +};
> +
> +module_pci_driver(exar_pci_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Exar Serial Dricer");
> +MODULE_DEVICE_TABLE(pci, exar_pci_tbl);
> diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
> index 8998347..9f8bd0a 100644
> --- a/drivers/tty/serial/8250/Kconfig
> +++ b/drivers/tty/serial/8250/Kconfig
> @@ -127,6 +127,11 @@ config SERIAL_8250_PCI
>           Note that serial ports on NetMos 9835 Multi-I/O cards are handled
>           by the parport_serial driver, enabled with CONFIG_PARPORT_SERIAL.
>
> +config SERIAL_8250_EXAR
> +        tristate "8250/16550 PCI device support"
> +        depends on SERIAL_8250_PCI
> +       default SERIAL_8250
> +
>  config SERIAL_8250_HP300
>         tristate
>         depends on SERIAL_8250 && HP300
> diff --git a/drivers/tty/serial/8250/Makefile b/drivers/tty/serial/8250/Makefile
> index 276c6fb..b771d37 100644
> --- a/drivers/tty/serial/8250/Makefile
> +++ b/drivers/tty/serial/8250/Makefile
> @@ -10,6 +10,7 @@ obj-$(CONFIG_SERIAL_8250)             += 8250.o 8250_base.o
>  8250_base-$(CONFIG_SERIAL_8250_FINTEK) += 8250_fintek.o
>  obj-$(CONFIG_SERIAL_8250_GSC)          += 8250_gsc.o
>  obj-$(CONFIG_SERIAL_8250_PCI)          += 8250_pci.o
> +obj-$(CONFIG_SERIAL_8250_EXAR)         += 8250_exar.o
>  obj-$(CONFIG_SERIAL_8250_HP300)                += 8250_hp300.o
>  obj-$(CONFIG_SERIAL_8250_CS)           += serial_cs.o
>  obj-$(CONFIG_SERIAL_8250_ACORN)                += 8250_acorn.o
> --
> 1.9.1
>



-- 
With Best Regards,
Andy Shevchenko
