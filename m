From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v8 2/3] serial: exar: split out the exar code from 8250_pci
Date: Mon, 9 Jan 2017 02:14:29 +0200
Message-ID: <CAHp75VficfU+BTgW_Mm_UTC8oDKJA0yxrUz_PBY=w4jT2LFbMA@mail.gmail.com>
References: <1483914727-6076-1-git-send-email-sudipm.mukherjee@gmail.com> <1483914727-6076-2-git-send-email-sudipm.mukherjee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1483914727-6076-2-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
List-Id: linux-serial@vger.kernel.org

On Mon, Jan 9, 2017 at 12:32 AM, Sudip Mukherjee
<sudipm.mukherjee@gmail.com> wrote:
> From: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
>
> Add the serial driver for the Exar chips. And also register the
> platform device for the gpio provided by the Exar chips.

GPIO ?

> Andy,
> I hope its ok this time. All your comments taken into account. :)
> I could not think of any other way to reduce the number of boards.

Almost but not entirely. Hope v9 will be in a really good shape.
Please wait also for my comment regarding patch 1 (basically style
ones since it will be v9)/

> +#undef DEBUG
> +

> +#include <asm/byteorder.h>

What I meant previously is a grouping like following

<linux/*>

<asm/*>

"*"

Each group is sorted, except special cases like 8250_pci.h here.

> +#define PCI_DEVICE_ID_COMMTECH_4224PCIE        0x0020
> +#define PCI_DEVICE_ID_COMMTECH_4228PCIE        0x0021
> +#define PCI_DEVICE_ID_COMMTECH_4222PCIE        0x0022
> +#define PCI_DEVICE_ID_EXAR_XR17V4358   0x4358
> +#define PCI_DEVICE_ID_EXAR_XR17V8358   0x8358

> +#define PCI_NUM_BAR_RESOURCES  6

Hmm... Do you use it somewhere? If no, remove, otherwise remove and
replace by generic definition.

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

Those comments are good candidates to be a kernel doc description
above the struct definition.

> +       unsigned int reg_shift;
> +       unsigned int first_offset;
> +       bool has_slave;
> +       int     (*setup)(struct exar8250 *, struct pci_dev *,
> +                        const struct exar8250_board *,
> +                        struct uart_8250_port *, int);
> +       void    (*exit)(struct pci_dev *dev);
> +};
> +
> +struct exar8250 {
> +       unsigned int            nr;
> +       struct exar8250_board   *board;
> +       int                     line[0];
> +};
> +
> +static int default_setup(struct exar8250 *priv, struct pci_dev *pcidev,

I would use pci_dev, but it is matter of taste.

> +                        const struct exar8250_board *board,
> +                        struct uart_8250_port *port, int idx)
> +{
> +       unsigned int offset = board->first_offset, bar = 0;
> +
> +       offset += idx * board->uart_offset;
> +
> +       port->port.iotype = UPIO_MEM;
> +       port->port.iobase = 0;
> +       port->port.mapbase = pci_resource_start(pcidev, bar) + offset;
> +       port->port.membase = pcim_iomap_table(pcidev)[bar] + offset;
> +       port->port.regshift = board->reg_shift;
> +
> +       return 0;
> +}
> +
> +static int
> +pci_xr17c154_setup(struct exar8250 *priv, struct pci_dev *pcidev,
> +                  const struct exar8250_board *board,
> +                  struct uart_8250_port *port, int idx)
> +{
> +       port->port.flags |= UPF_EXAR_EFR;
> +       return default_setup(priv, pcidev, board, port, idx);
> +}
> +
> +static void setup_gpio(u8 __iomem *p)
> +{
> +       writeb(0x00, p + UART_EXAR_MPIOINT_7_0);
> +       writeb(0x00, p + UART_EXAR_MPIOLVL_7_0);
> +       writeb(0x00, p + UART_EXAR_MPIO3T_7_0);
> +       writeb(0x00, p + UART_EXAR_MPIOINV_7_0);
> +       writeb(0x00, p + UART_EXAR_MPIOSEL_7_0);
> +       writeb(0x00, p + UART_EXAR_MPIOOD_7_0);
> +       writeb(0x00, p + UART_EXAR_MPIOINT_15_8);
> +       writeb(0x00, p + UART_EXAR_MPIOLVL_15_8);
> +       writeb(0x00, p + UART_EXAR_MPIO3T_15_8);
> +       writeb(0x00, p + UART_EXAR_MPIOINV_15_8);
> +       writeb(0x00, p + UART_EXAR_MPIOSEL_15_8);
> +       writeb(0x00, p + UART_EXAR_MPIOOD_15_8);
> +}
> +
> +static void *
> +xr17v35x_register_gpio(struct pci_dev *pcidev)
> +{
> +       struct platform_device *pdev;
> +
> +       pdev = platform_device_alloc("gpio_exar", PLATFORM_DEVID_AUTO);
> +       if (!pdev)
> +               return NULL;
> +
> +       platform_set_drvdata(pdev, pcidev);
> +       if (platform_device_add(pdev) < 0) {
> +               platform_device_put(pdev);
> +               return NULL;
> +       }
> +

> +       return (void *)pdev;

No need to explicit cast.

> +}
> +
> +static int
> +pci_xr17v35x_setup(struct exar8250 *priv, struct pci_dev *pcidev,
> +                  const struct exar8250_board *board,
> +                  struct uart_8250_port *port, int idx)
> +{
> +       u8 __iomem *p;
> +       int ret;
> +
> +       p = pci_ioremap_bar(pcidev, 0);
> +       if (!p)
> +               return -ENOMEM;
> +
> +       port->port.flags |= UPF_EXAR_EFR;
> +
> +       /*
> +        * Setup the uart clock for the devices on expansion slot to
> +        * half the clock speed of the main chip (which is 125MHz)
> +        */
> +       if (board->has_slave && idx >= 8)
> +               port->port.uartclk = (7812500 * 16 / 2);
> +

> +       /*
> +        * Setup Multipurpose Input/Output pins.
> +        */
> +       if (idx == 0)
> +               setup_gpio(p);

So, my question is can we do this in GPIO driver?

Can we register it beforehand if needed?

> +
> +       writeb(0x00, p + UART_EXAR_8XMODE);
> +       writeb(UART_FCTR_EXAR_TRGD, p + UART_EXAR_FCTR);
> +       writeb(128, p + UART_EXAR_TXTRG);
> +       writeb(128, p + UART_EXAR_RXTRG);
> +       iounmap(p);
> +
> +       ret = default_setup(priv, pcidev, board, port, idx);
> +       if (ret)
> +               return ret;
> +
> +       if (idx == 0)
> +               port->port.private_data =
> +                       xr17v35x_register_gpio(pcidev);
> +
> +       return 0;
> +}
> +
> +static void pci_xr17v35x_exit(struct pci_dev *dev)

Be consistent pci_dev or pcidev. Check all your patches all occurrences.

> +{
> +       struct exar8250 *priv = pci_get_drvdata(dev);
> +       struct uart_8250_port *port = serial8250_get_port(priv->line[0]);
> +       struct platform_device *pdev = port->port.private_data;
> +
> +       if (pdev) {
> +               platform_device_unregister(pdev);
> +               port->port.private_data = NULL;
> +       }

Would

if (!pdev)
 return;

be more suitable here?

> +}
> +
> +static int
> +exar_pci_probe(struct pci_dev *pcidev, const struct pci_device_id *ent)
> +{

> +       int rc;

Make it last in the definition block. I think I mentioned this earlier.

> +       struct exar8250_board *board;
> +       struct uart_8250_port uart;
> +       struct exar8250 *priv;
> +       unsigned int nr_ports, i, bar = 0, maxnr;
> +
> +       board = (struct exar8250_board *)ent->driver_data;
> +
> +       rc = pcim_enable_device(pcidev);
> +       if (rc)
> +               return rc;
> +

> +       if (!pcim_iomap(pcidev, bar, 0) && !pcim_iomap_table(pcidev))
> +               return -ENOMEM;

You ignored my comment, we may never finish the review in such case :-(

Asking again: do you really need this part? I know why I did so and
put it to 8250_pci, but let's focus on your code.

> +
> +       maxnr = (pci_resource_len(pcidev, bar) - board->first_offset) >>
> +               (board->reg_shift + 3);
> +
> +       nr_ports = board->num_ports;
> +
> +       priv = devm_kzalloc(&pcidev->dev, sizeof(*priv) +
> +                           sizeof(unsigned int) * nr_ports,
> +                           GFP_KERNEL);
> +       if (!priv)
> +               return -ENOMEM;
> +
> +       priv->board = board;
> +
> +       memset(&uart, 0, sizeof(uart));
> +       uart.port.flags = UPF_SKIP_TEST | UPF_BOOT_AUTOCONF | UPF_SHARE_IRQ;
> +       uart.port.uartclk = board->base_baud * 16;
> +       uart.port.irq = pcidev->irq;
> +       uart.port.dev = &pcidev->dev;
> +
> +       for (i = 0; i < nr_ports && i < maxnr; i++) {

> +               if (board->setup(priv, pcidev, board, &uart, i))
> +                       break;

Shouldn't you inform user that something went wrong? Or is it okay?

> +
> +               dev_dbg(&pcidev->dev, "Setup PCI port: port %lx, irq %d, type %d\n",
> +                       uart.port.iobase, uart.port.irq, uart.port.iotype);
> +
> +               priv->line[i] = serial8250_register_8250_port(&uart);
> +               if (priv->line[i] < 0) {
> +                       dev_err(&pcidev->dev,
> +                               "Couldn't register serial port %lx, irq %d, type %d, error %d\n",
> +                               uart.port.iobase, uart.port.irq,
> +                               uart.port.iotype, priv->line[i]);
> +                       break;
> +               }
> +       }
> +       priv->nr = i;
> +       pci_set_drvdata(pcidev, priv);
> +       return 0;
> +}
> +
> +static void exar_pci_remove(struct pci_dev *pcidev)
> +{

> +       int i;

Move it after next line and perhaps make unsigned int i;

> +       struct exar8250 *priv = pci_get_drvdata(pcidev);

> +
> +       for (i = 0; i < priv->nr; i++)
> +               serial8250_unregister_port(priv->line[i]);
> +
> +       if (priv->board->exit)
> +               priv->board->exit(pcidev);
> +}
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int exar_suspend(struct device *dev)
> +{
> +       struct pci_dev *pdev = to_pci_dev(dev);

pci_dev or pcidev.

> +       struct exar8250 *priv = pci_get_drvdata(pdev);
> +       unsigned int i;
> +
> +       for (i = 0; i < priv->nr; i++)
> +               if (priv->line[i] >= 0)
> +                       serial8250_suspend_port(priv->line[i]);
> +

> +       /*
> +        * Ensure that every init quirk is properly torn down
> +        */

One line?

> +       if (priv->board->exit)
> +               priv->board->exit(pdev);
> +
> +       return 0;
> +}
> +
> +static int exar_resume(struct device *dev)
> +{
> +       struct pci_dev *pdev = to_pci_dev(dev);
> +       struct exar8250 *priv = pci_get_drvdata(pdev);
> +       unsigned int i;
> +

> +       if (priv) {

Would be the case that priv == NULL here?

> +               for (i = 0; i < priv->nr; i++)
> +                       if (priv->line[i] >= 0)
> +                               serial8250_resume_port(priv->line[i]);
> +       }
> +
> +       return 0;
> +}
> +#endif
> +
> +static SIMPLE_DEV_PM_OPS(exar_pci_pm, exar_suspend, exar_resume);
> +

Now see how we can reduce more.

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

Port number is easily to get from device ID, I already said this.
nr = subvendor == PCI_VENDOR_ID_IBM ? 1 : device & 0x0f;

Yes, it means ->setup() hook will allocate memory for lines (declare
them as int *line and use devm_kcalloc).

And if you think smarter about returning value, you may not even need
to move registration code into it!

Moreover all above have same setup function and uart_offset. Use it.

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
> +       .has_slave      = true,
> +       .setup          = pci_xr17v35x_setup,
> +       .exit           = pci_xr17v35x_exit,
> +};
> +
> +static const struct exar8250_board pbn_exar_XR17V8358 = {
> +       .num_ports      = 16,
> +       .base_baud      = 7812500,
> +       .uart_offset    = 0x400,
> +       .has_slave      = true,
> +       .setup          = pci_xr17v35x_setup,
> +       .exit           = pci_xr17v35x_exit,

Offset  + baud rate are same.

So, offset is not needed in the struct at all.

Does it make sense to you?

> +};

Below looks much better!

> +#define CONNECT_DEVICE(devid, sdevid, board) { PCI_DEVICE_SUB(\

Please do use separate line for PCI_DEVICE_SUB

> +                       PCI_VENDOR_ID_EXAR,\
> +                       PCI_DEVICE_ID_EXAR_##devid,\
> +                       PCI_SUBVENDOR_ID_CONNECT_TECH,\
> +                       PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_##sdevid),\
> +                       0, 0, (kernel_ulong_t)&board }

...also for }

And shift this line to show that is related to top level

> +
> +#define EXAR_DEVICE(vend, devid, bd) { PCI_VDEVICE(vend,\
> +               PCI_DEVICE_ID_##devid), (kernel_ulong_t)&bd }

Same comments.

> +
> +static struct pci_device_id exar_pci_tbl[] = {
> +       CONNECT_DEVICE(XR17C152, UART_2_232, pbn_b0_2_1843200_200),
> +       CONNECT_DEVICE(XR17C154, UART_4_232, pbn_b0_4_1843200_200),
> +       CONNECT_DEVICE(XR17C158, UART_8_232, pbn_b0_8_1843200_200),
> +       CONNECT_DEVICE(XR17C152, UART_1_1, pbn_b0_2_1843200_200),
> +       CONNECT_DEVICE(XR17C154, UART_2_2, pbn_b0_4_1843200_200),
> +       CONNECT_DEVICE(XR17C158, UART_4_4, pbn_b0_8_1843200_200),
> +       CONNECT_DEVICE(XR17C152, UART_2, pbn_b0_2_1843200_200),
> +       CONNECT_DEVICE(XR17C154, UART_4, pbn_b0_4_1843200_200),
> +       CONNECT_DEVICE(XR17C158, UART_8, pbn_b0_8_1843200_200),
> +       CONNECT_DEVICE(XR17C152, UART_2_485, pbn_b0_2_1843200_200),
> +       CONNECT_DEVICE(XR17C154, UART_4_485, pbn_b0_4_1843200_200),
> +       CONNECT_DEVICE(XR17C158, UART_8_485, pbn_b0_8_1843200_200),

> +       {       PCI_DEVICE_SUB(PCI_VENDOR_ID_EXAR,
> +               PCI_DEVICE_ID_EXAR_XR17C152,
> +               PCI_VENDOR_ID_IBM,
> +               PCI_SUBDEVICE_ID_IBM_SATURN_SERIAL_ONE_PORT), 0, 0,
> +               (kernel_ulong_t)&pbn_exar_ibm_saturn },

Ditto.

> +       /*
> +        * Exar Corp. XR17C15[248] Dual/Quad/Octal UART
> +        */

One line?

> +       EXAR_DEVICE(EXAR, EXAR_XR17C152, pbn_exar_XR17C152),
> +       EXAR_DEVICE(EXAR, EXAR_XR17C154, pbn_exar_XR17C154),
> +       EXAR_DEVICE(EXAR, EXAR_XR17C158, pbn_exar_XR17C158),

> +       /*
> +        * Exar Corp. XR17V[48]35[248] Dual/Quad/Octal/Hexa PCIe UARTs
> +        */

Ditto.

> +       EXAR_DEVICE(EXAR, EXAR_XR17V352, pbn_exar_XR17V352),
> +       EXAR_DEVICE(EXAR, EXAR_XR17V354, pbn_exar_XR17V354),
> +       EXAR_DEVICE(EXAR, EXAR_XR17V358, pbn_exar_XR17V358),
> +       EXAR_DEVICE(EXAR, EXAR_XR17V4358, pbn_exar_XR17V4358),
> +       EXAR_DEVICE(EXAR, EXAR_XR17V8358, pbn_exar_XR17V8358),
> +       EXAR_DEVICE(COMMTECH, COMMTECH_4222PCIE, pbn_exar_XR17V352),
> +       EXAR_DEVICE(COMMTECH, COMMTECH_4224PCIE, pbn_exar_XR17V354),
> +       EXAR_DEVICE(COMMTECH, COMMTECH_4228PCIE, pbn_exar_XR17V358),
> +       { 0, }
> +};

> +MODULE_DEVICE_TABLE(pci, exar_pci_tbl);
Move this to the next line after actual structure.

> --- a/drivers/tty/serial/8250/Kconfig
> +++ b/drivers/tty/serial/8250/Kconfig

> +config SERIAL_8250_EXAR
> +        tristate "8250/16550 PCI device support"
> +        depends on SERIAL_8250_PCI

> +       default SERIAL_8250

Looks like this line has indentation issue. Moreover I told you to do
this in patch 3, not here. Otherwise you will have drivers overlap.

-- 
With Best Regards,
Andy Shevchenko
