From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] serial: 8250_lpss: Unconditionally set PCI master for Quark
Date: Thu, 5 Jan 2017 01:56:19 +0200
Message-ID: <CAHp75Vf9h51xXU9HguU+XuqLAS4Zs7WWFBNT+rwccTdSWdwpYg@mail.gmail.com>
References: <1d0224cc-10ee-df69-b383-c687e08ed44d@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1d0224cc-10ee-df69-b383-c687e08ed44d@siemens.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Wed, Jan 4, 2017 at 10:48 PM, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> MSI needs it as well.
>
> Should have no practical impact, though, as DMA is always available on
> the Quark. But given the few users of pci_alloc_irq_vectors so far, this
> incorrect pattern may spread otherwise.

This looks valid, but let me review it later, need some sleep.

>
> Fixes: 3f3a46951e02 ("serial: 8250_lpss: set PCI master only for private DMA")
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  drivers/tty/serial/8250/8250_lpss.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/8250/8250_lpss.c b/drivers/tty/serial/8250/8250_lpss.c
> index f09f68a..9315197 100644
> --- a/drivers/tty/serial/8250/8250_lpss.c
> +++ b/drivers/tty/serial/8250/8250_lpss.c
> @@ -183,7 +183,6 @@ static void qrk_serial_setup_dma(struct lpss8250 *lpss, struct uart_port *port)
>         if (ret)
>                 return;
>
> -       pci_set_master(pdev);
>         pci_try_set_mwi(pdev);
>
>         /* Special DMA address for UART */
> @@ -216,6 +215,8 @@ static int qrk_serial_setup(struct lpss8250 *lpss, struct uart_port *port)
>         struct pci_dev *pdev = to_pci_dev(port->dev);
>         int ret;
>
> +       pci_set_master(pdev);
> +
>         ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
>         if (ret < 0)
>                 return ret;
> --
> 2.1.4



-- 
With Best Regards,
Andy Shevchenko
