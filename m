From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v12 1/2] serial: exar: split out the exar code from 8250_pci
Date: Mon, 30 Jan 2017 12:57:36 +0200
Message-ID: <CAHp75VewLwJjRyQXNcKfV6-eFY4xgwkrUH7FVK4OGb-WjCgeBA@mail.gmail.com>
References: <1485728541-8901-1-git-send-email-sudipm.mukherjee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1485728541-8901-1-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Mon, Jan 30, 2017 at 12:22 AM, Sudip Mukherjee
<sudipm.mukherjee@gmail.com> wrote:
> From: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
>
> Add the serial driver for the Exar chips. And also register the
> platform device for the GPIO provided by the Exar chips.

Looks almost perfect, just few finishing strokes below and take my
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> +/**
> + * struct exar8250_board - board information
> + * @num_ports: number of serial ports
> + * @reg_shift: describes UART register mapping in PCI memory
> + */
> +struct exar8250_board {
> +       unsigned int num_ports;
> +       unsigned int reg_shift;
> +       bool has_slave;
> +       int     (*setup)(struct exar8250 *, struct pci_dev *,

> +                        const struct exar8250_board *,

This is not needed. See below.

> +                        struct uart_8250_port *, int);
> +       void    (*exit)(struct pci_dev *pcidev);
> +};

> +struct exar8250 {
> +       unsigned int            nr;

> +       struct exar8250_board   *board;

...since you have this one and continuing below...

> +       int                     line[0];
> +};

> +static int default_setup(struct exar8250 *priv, struct pci_dev *pcidev,
> +                        const struct exar8250_board *board, int idx,
> +                        unsigned int offset, struct uart_8250_port *port)
> +{

const struct exar8250_board *board = priv->board;

> +       unsigned int bar = 0;
> +
> +       port->port.iotype = UPIO_MEM;
> +       port->port.mapbase = pci_resource_start(pcidev, bar) + offset;
> +       port->port.membase = pcim_iomap_table(pcidev)[bar] + offset;
> +       port->port.regshift = board->reg_shift;
> +
> +       return 0;
> +}

> +static int
> +pci_connect_tech_setup(struct exar8250 *priv, struct pci_dev *pcidev,

> +                      const struct exar8250_board *board,

Redundant.

> +                      struct uart_8250_port *port, int idx)
> +{
> +       unsigned int offset = idx * 0x200;
> +       unsigned int baud = 1843200;
> +
> +       port->port.uartclk = baud * 16;
> +       return default_setup(priv, pcidev, board, idx, offset, port);
> +}
> +
> +static int
> +pci_xr17c154_setup(struct exar8250 *priv, struct pci_dev *pcidev,
> +                  const struct exar8250_board *board,

Ditto.

> +                  struct uart_8250_port *port, int idx)
> +{
> +       unsigned int offset = idx * 0x200;
> +       unsigned int baud = 921600;
> +
> +       port->port.uartclk = baud * 16;
> +       return default_setup(priv, pcidev, board, idx, offset, port);
> +}

> +static int
> +pci_xr17v35x_setup(struct exar8250 *priv, struct pci_dev *pcidev,

> +                  const struct exar8250_board *board,

Ditto.

> +                  struct uart_8250_port *port, int idx)
> +{

const struct exar8250_board *board = priv->board;

> +       unsigned int offset = idx * 0x400;
> +       unsigned int baud = 7812500;

> +static int
> +exar_pci_probe(struct pci_dev *pcidev, const struct pci_device_id *ent)
> +{
> +       unsigned int nr_ports, i, bar = 0, maxnr;
> +       struct exar8250_board *board;
> +       struct uart_8250_port uart;
> +       struct exar8250 *priv;
> +       int rc;
> +

> +       board = (struct exar8250_board *)ent->driver_data;

if (!board)
 return -EINVAL;

board now is mandatory to have.

> +       rc = pcim_enable_device(pcidev);
> +       if (rc)
> +               return rc;
> +
> +       maxnr = pci_resource_len(pcidev, bar) >> (board->reg_shift + 3);
> +
> +       nr_ports = board->num_ports ? board->num_ports : pcidev->device & 0x0f;
> +
> +       priv = devm_kzalloc(&pcidev->dev, sizeof(*priv) +
> +                           sizeof(unsigned int) * nr_ports,
> +                           GFP_KERNEL);
> +       if (!priv)
> +               return -ENOMEM;
> +

> +       priv->board = board;

Yes! This what allows you to get rid of the above.

> +static const struct exar8250_board pbn_connect = {
> +       .setup          = pci_connect_tech_setup,
> +};

Yep! You got the idea.

> +
> +static const struct exar8250_board pbn_exar_ibm_saturn = {
> +       .num_ports      = 1,
> +       .setup          = pci_xr17c154_setup,
> +};

-- 
With Best Regards,
Andy Shevchenko
