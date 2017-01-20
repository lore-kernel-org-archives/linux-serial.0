From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v10 2/3] serial: exar: split out the exar code from 8250_pci
Date: Sat, 21 Jan 2017 00:25:36 +0200
Message-ID: <CAHp75VeQOHdKd7C_yO-ts9W_Gv5BYJSUp+JdpkhvaJFSYnFpzw@mail.gmail.com>
References: <1484864602-5266-1-git-send-email-sudipm.mukherjee@gmail.com> <1484864602-5266-2-git-send-email-sudipm.mukherjee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1484864602-5266-2-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Fri, Jan 20, 2017 at 12:23 AM, Sudip Mukherjee
<sudipm.mukherjee@gmail.com> wrote:
> From: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
>
> Add the serial driver for the Exar chips. And also register the
> platform device for the GPIO provided by the Exar chips.

Thanks, this is indeed much cleaner that v6 I saw couple of weeks before!

> Andy,
> Having 3 setup hooks and assigning everything there was becoming too
> complicated for me to follow, so i left it as it is. Though some more
> parts from the board setup has been removed. uart_offset has been
> completely removed.

Yes, what about baudrate?
I will check later, but for me it seems other way, i.e. simpler to
have just 3 setup functions in a row than one is lurking somewhere
with allocation et al.

> To answer your questions:
> 1. In pci_xr17v35x_exit() pdev can be NULL if xr17v35x_register_gpio()
> failed while it was called. And if the gpio fails to register then we
> should not try to unregister it afterwards.

See below.

> 2. A working GPIO driver without serial does not make sense. I think
> I will send a patch afterwards to change that.

OK

> +/**
> + * struct exar8250_board - board information
> + * @num_ports: number of serial ports
> + * @base_baud: baudrate
> + * @reg_shift: describes UART register mapping in PCI memory
> + */

Good!

> +static int
> +pci_xr17c154_setup(struct exar8250 *priv, struct pci_dev *pcidev,
> +                  const struct exar8250_board *board,
> +                  struct uart_8250_port *port, int idx)
> +{
> +       unsigned int offset = idx * 0x200;

Yep.

> +
> +       port->port.flags |= UPF_EXAR_EFR;
> +       return default_setup(priv, pcidev, board, idx, offset, port);
> +}

> +static void pci_xr17v35x_exit(struct pci_dev *pcidev)
> +{
> +       struct exar8250 *priv = pci_get_drvdata(pcidev);
> +       struct uart_8250_port *port = serial8250_get_port(priv->line[0]);
> +       struct platform_device *pdev = port->port.private_data;
> +

> +       if (!pdev)
> +               return;

Just checked, platform_device_unregister() is NULL-aware, so, please
remove this check.

> +
> +       platform_device_unregister(pdev);
> +       port->port.private_data = NULL;
> +}

> +exar_pci_probe(struct pci_dev *pcidev, const struct pci_device_id *ent)
> +{

> +               board = devm_kzalloc(&pcidev->dev, sizeof(*board),
> +                                    GFP_KERNEL);
> +               board->base_baud = 1843200;

That's candidate for
pci_connect_tech_setup();

But let me still look and compare.

> +       for (i = 0; i < nr_ports && i < maxnr; i++) {
> +               if (board->setup)
> +                       rc = board->setup(priv, pcidev, board, &uart, i);

> +               else
> +                       rc = pci_xr17c154_setup(priv, pcidev, board, &uart, i);

> +static const struct exar8250_board pbn_exar_ibm_saturn = {
> +       .num_ports      = 1,
> +       .base_baud      = 921600,
> +};
> +
> +static const struct exar8250_board pbn_exar_XR17C15x = {
> +       .base_baud      = 921600,
> +};

You see, that no setup has been using same baud rate. Just replace
baud rate with setup. In that case you will remove above
if (board->setup)

> +static const struct exar8250_board pbn_exar_XR17V35x = {

> +       .base_baud      = 7812500,

> +       .setup          = pci_xr17v35x_setup,
> +       .exit           = pci_xr17v35x_exit,

> +static const struct exar8250_board pbn_exar_XR17V4358 = {

> +       .base_baud      = 7812500,

> +       .setup          = pci_xr17v35x_setup,
> +       .exit           = pci_xr17v35x_exit,

> +static const struct exar8250_board pbn_exar_XR17V8358 = {
> +       .base_baud      = 7812500,

> +       .setup          = pci_xr17v35x_setup,
> +       .exit           = pci_xr17v35x_exit,
> +};

In all above you call same setup with same baud rate. Move it there.

> +#define EXAR_DEVICE(vend, devid, bd) {                                 \
> +       PCI_VDEVICE(vend, PCI_DEVICE_ID_##devid), (kernel_ulong_t)&bd   \
> +       }
> +
> +#define IBM_DEVICE(devid, sdevid, bd) {                        \
> +       PCI_DEVICE_SUB(                                 \
> +               PCI_VENDOR_ID_EXAR,                     \
> +               PCI_DEVICE_ID_EXAR_##devid,             \
> +               PCI_VENDOR_ID_IBM,                      \
> +               PCI_SUBDEVICE_ID_IBM_##sdevid), 0, 0,   \
> +               (kernel_ulong_t)&bd                     \
> +       }

Yep!

> +static struct pci_device_id exar_pci_tbl[] = {
> +       CONNECT_DEVICE(XR17C152, UART_2_232),
> +       CONNECT_DEVICE(XR17C154, UART_4_232),
> +       CONNECT_DEVICE(XR17C158, UART_8_232),
> +       CONNECT_DEVICE(XR17C152, UART_1_1),
> +       CONNECT_DEVICE(XR17C154, UART_2_2),
> +       CONNECT_DEVICE(XR17C158, UART_4_4),
> +       CONNECT_DEVICE(XR17C152, UART_2),
> +       CONNECT_DEVICE(XR17C154, UART_4),
> +       CONNECT_DEVICE(XR17C158, UART_8),
> +       CONNECT_DEVICE(XR17C152, UART_2_485),
> +       CONNECT_DEVICE(XR17C154, UART_4_485),
> +       CONNECT_DEVICE(XR17C158, UART_8_485),

Perhaps it takes few LOC more, but having same defined struct here
with dedicated ->setup() looks cleaner to me.

-- 
With Best Regards,
Andy Shevchenko
