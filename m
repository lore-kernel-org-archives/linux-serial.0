From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 1/7] serial: exar: Fix mapping of port I/O resources
Date: Wed, 8 Feb 2017 00:40:21 +0200
Message-ID: <CAHp75VfGpk_+m=yJAqGNWxVg01UvsFnw5HHOOSCbgXLMLeDUdg@mail.gmail.com>
References: <cover.1486483803.git.jan.kiszka@siemens.com> <52dc04249d65a55fbf1e58c262ca23c4fcc20777.1486483803.git.jan.kiszka@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <52dc04249d65a55fbf1e58c262ca23c4fcc20777.1486483803.git.jan.kiszka@siemens.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
List-Id: linux-serial@vger.kernel.org

On Tue, Feb 7, 2017 at 6:09 PM, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> pcim_iomap_table only returns the table of mapping, it does not perform
> them. For that, we need to call pcim_iomap, but only if that mapping was
> not done before.

Basically by this change you answered to one of my question during review.

FWIW:
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Fixes: d0aeaa83f0b0 ("serial: exar: split out the exar code from 8250_pci")
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  drivers/tty/serial/8250/8250_exar.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
> index e6b44a7..58469d9 100644
> --- a/drivers/tty/serial/8250/8250_exar.c
> +++ b/drivers/tty/serial/8250/8250_exar.c
> @@ -72,6 +72,9 @@ static int default_setup(struct exar8250 *priv, struct pci_dev *pcidev,
>         const struct exar8250_board *board = priv->board;
>         unsigned int bar = 0;
>
> +       if (!pcim_iomap_table(pcidev)[bar] && !pcim_iomap(pcidev, bar, 0))
> +               return -ENOMEM;
> +
>         port->port.iotype = UPIO_MEM;
>         port->port.mapbase = pci_resource_start(pcidev, bar) + offset;
>         port->port.membase = pcim_iomap_table(pcidev)[bar] + offset;
> --
> 2.1.4
>



-- 
With Best Regards,
Andy Shevchenko
