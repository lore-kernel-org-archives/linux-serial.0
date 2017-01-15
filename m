From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v9 2/3] serial: exar: split out the exar code from 8250_pci
Date: Sun, 15 Jan 2017 17:40:41 +0200
Message-ID: <CAHp75VdhyK-yYEEVUUKcRD10dKTiMGm1k1fjARPeerB-5NAc1A@mail.gmail.com>
References: <1484434252-7663-1-git-send-email-sudipm.mukherjee@gmail.com> <1484434252-7663-2-git-send-email-sudipm.mukherjee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1484434252-7663-2-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Sun, Jan 15, 2017 at 12:50 AM, Sudip Mukherjee
<sudipm.mukherjee@gmail.com> wrote:
> From: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
>
> Add the serial driver for the Exar chips. And also register the
> platform device for the GPIO provided by the Exar chips.

Thanks!
Still v10 is needed for my opinion. See my comments below.

(Telling ahead, I like your idea with allocating board info struct for
some devices, though you still might have just a normal ->setup hook
for them as well to be in align with the rest of the code)

> I hope the grouping and ordering of the header files are ok this time.
> One comment has been changed to Kerneldoc description, but as I have never
> made a kerneldoc description before so not sure if it is correct.

It should look like
/**
 * struct foo_bar - board information
 * @field1: number of ports
 * @filed2: register offset
 */

Try to fit all field descriptions to one line, same for title

> I have already replied in a separate mail about the problem if we
> register gpio before.

Okay.

> +++ b/drivers/tty/serial/8250/8250_exar.c
> @@ -0,0 +1,433 @@

> +#undef DEBUG

I hope you know _why_ you are doing this.

> +static int default_setup(struct exar8250 *priv, struct pci_dev *pcidev,
> +                        const struct exar8250_board *board,
> +                        struct uart_8250_port *port, int idx)
> +{
> +       unsigned int offset, bar = 0;
> +

> +       if (board->uart_offset)
> +               offset = idx * board->uart_offset;
> +       else
> +               offset = idx * 0x200;

No, you have for now two groups of devices with offset = 0x200 and
0x400. Do the explicit assignment in different ->setup() hooks.

default_setup()
{
}

setup1()
{
 offset = 0x200;
 return default setup
}

setup2()
{
 offset = 0x400;
 return default setup
}

> +
> +       port->port.iotype = UPIO_MEM;

> +       port->port.iobase = 0;

Isn't it by default?

> +       port->port.mapbase = pci_resource_start(pcidev, bar) + offset;
> +       port->port.membase = pcim_iomap_table(pcidev)[bar] + offset;
> +       port->port.regshift = board->reg_shift;
> +
> +       return 0;
> +}

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

Move this line above ioremap() call. It would make lines grouped by logic.

> +
> +       /*
> +        * Setup the uart clock for the devices on expansion slot to
> +        * half the clock speed of the main chip (which is 125MHz)
> +        */
> +       if (board->has_slave && idx >= 8)
> +               port->port.uartclk = (7812500 * 16 / 2);

Ditto.

> +
> +       /* Setup Multipurpose Input/Output pins. */
> +       if (idx == 0)
> +               setup_gpio(p);
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

Still one question, does working GPIO driver without serial make sense?

> +
> +       return 0;
> +}
> +
> +static void pci_xr17v35x_exit(struct pci_dev *pcidev)
> +{
> +       struct exar8250 *priv = pci_get_drvdata(pcidev);
> +       struct uart_8250_port *port = serial8250_get_port(priv->line[0]);
> +       struct platform_device *pdev = port->port.private_data;
> +

> +       if (!pdev)
> +               return;

Is it possible?

> +
> +       platform_device_unregister(pdev);
> +       port->port.private_data = NULL;
> +}
> +
> +static int
> +exar_pci_probe(struct pci_dev *pcidev, const struct pci_device_id *ent)
> +{
> +       unsigned int nr_ports, i, bar = 0, maxnr;
> +       struct exar8250_board *board;
> +       struct uart_8250_port uart;
> +       struct exar8250 *priv;
> +       int rc;
> +
> +       rc = pcim_enable_device(pcidev);
> +       if (rc)
> +               return rc;
> +
> +       board = (struct exar8250_board *)ent->driver_data;
> +       if (!board) {

> +               board = devm_kzalloc(&pcidev->dev, sizeof(*board),
> +                                    GFP_KERNEL);
> +               board->base_baud = 1843200;

Ah, this is clever, though make it separate helper, and assign offset
there and other necessary stuff.
But to be in align with the rest I would recommend to use just another
setup3() hook.

> +       }
> +

> +       maxnr = pci_resource_len(pcidev, bar) >>
> +                       (board->reg_shift + 3);

One line?

> +
> +       nr_ports = board->num_ports ? board->num_ports :
> +                                       pcidev->device & 0x0f;

Ditto.

(Perhaps make num_ports shorter?)

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
> +               if (board->setup)
> +                       rc = board->setup(priv, pcidev, board, &uart, i);
> +               else
> +                       rc = pci_xr17c154_setup(priv, pcidev, board, &uart, i);

> +

Redundant empty line.

> +               if (rc) {

> +                       dev_err(&pcidev->dev,
> +                               "Failed to setup port %u\n", i);

One line?

> +                       break;
> +               }

> +       pci_set_drvdata(pcidev, priv);
> +       return 0;
> +}

> +#ifdef CONFIG_PM_SLEEP

> +static int exar_suspend(struct device *dev)

Preferred way is to use __maybe_unused instead of #ifdef:s

> +{
> +       struct pci_dev *pcidev = to_pci_dev(dev);
> +       struct exar8250 *priv = pci_get_drvdata(pcidev);
> +       unsigned int i;
> +
> +       for (i = 0; i < priv->nr; i++)
> +               if (priv->line[i] >= 0)
> +                       serial8250_suspend_port(priv->line[i]);
> +
> +       /* Ensure that every init quirk is properly torn down */

> +

Redundant empty line (check all your patches for this subtle increased
amount of useless lines).

> +       if (priv->board->exit)
> +               priv->board->exit(pcidev);



> +static const struct exar8250_board pbn_exar_ibm_saturn = {
> +       .num_ports      = 1,
> +       .base_baud      = 921600,

Since you found the way how to split it, baud rate is not needed any
more here, you set it explicitly in setup1() and setup2() (see above)
and setup_for_no_board() (which you create with allocation and some
assignments).

> +};
> +
> +static const struct exar8250_board pbn_exar_XR17C152 = {
> +       .base_baud      = 921600,
> +};
> +
> +static const struct exar8250_board pbn_exar_XR17C154 = {
> +       .base_baud      = 921600,
> +};
> +
> +static const struct exar8250_board pbn_exar_XR17C158 = {
> +       .base_baud      = 921600,
> +};

So, leave only ->setup() hook in above.
And as you may now notice those all are identical. Use one instead of 3x.


> +static const struct exar8250_board pbn_exar_XR17V352 = {

> +       .base_baud      = 7812500,
> +       .uart_offset    = 0x400,

Assign this in a corresponding ->setup() hook.

> +       .setup          = pci_xr17v35x_setup,
> +       .exit           = pci_xr17v35x_exit,
> +};
> +
> +static const struct exar8250_board pbn_exar_XR17V354 = {
> +       .base_baud      = 7812500,
> +       .uart_offset    = 0x400,
> +       .setup          = pci_xr17v35x_setup,
> +       .exit           = pci_xr17v35x_exit,
> +};
> +
> +static const struct exar8250_board pbn_exar_XR17V358 = {
> +       .base_baud      = 7812500,
> +       .uart_offset    = 0x400,
> +       .setup          = pci_xr17v35x_setup,
> +       .exit           = pci_xr17v35x_exit,
> +};

Ditto, use one istead of 3x.

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
> +};

Same comment about assignment for for above.

> +
> +#define CONNECT_DEVICE(devid, sdevid) {\
> +       PCI_DEVICE_SUB(\
> +               PCI_VENDOR_ID_EXAR,\
> +               PCI_DEVICE_ID_EXAR_##devid,\
> +               PCI_SUBVENDOR_ID_CONNECT_TECH,\
> +               PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_##sdevid)\
> +       }

Can you indent \ to one column using TABs?

> +
> +#define EXAR_DEVICE(vend, devid, bd) {\
> +       PCI_VDEVICE(\
> +               vend, PCI_DEVICE_ID_##devid), (kernel_ulong_t)&bd \
> +       }

Ditto.
Btw, can PCI_VDEVICE() be on one line?

> +static struct pci_device_id exar_pci_tbl[] = {

> +       {
> +               PCI_DEVICE_SUB(PCI_VENDOR_ID_EXAR,
> +                              PCI_DEVICE_ID_EXAR_XR17C152,
> +                              PCI_VENDOR_ID_IBM,
> +                              PCI_SUBDEVICE_ID_IBM_SATURN_SERIAL_ONE_PORT),
> +                              0, 0, (kernel_ulong_t)&pbn_exar_ibm_saturn
> +       },

To make it neat do macro for this one
IBM_DEVICE(XR17C152, IBM_SATURN_..., pbn_exar_ibm_saturn),

-- 
With Best Regards,
Andy Shevchenko
