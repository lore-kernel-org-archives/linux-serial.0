From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] serial: 8250_lpss: Release Quark MSI vectors on exit
Date: Thu, 5 Jan 2017 00:19:56 +0200
Message-ID: <CAHp75VdyJXGUp0YOX_15wM0Fv+arnQNEcLN6+OMtXGBgG-6jrA@mail.gmail.com>
References: <0250c46e-da6c-71f3-50ae-b7c17fd0bd2c@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0250c46e-da6c-71f3-50ae-b7c17fd0bd2c@siemens.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jan Kiszka <jan.kiszka@siemens.com>, Christoph Hellwig <hch@lst.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Wed, Jan 4, 2017 at 9:36 PM, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> No one seems to do this magically in the background, so we have to do
> the job in the exit handler that corresponds to the board setup handler.
>
> Fixes: 60a9244a5d14 ("serial: 8250_lpss: enable MSI for Intel Quark")
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>

NAK, check the PCI devres code, please.

Christoph, can you amend documentation to make this clear?

I NAKed already third patch related to PCI managed resources (couple
of those regarding to pci_irq_* API)/

> ---
>  drivers/tty/serial/8250/8250_lpss.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/tty/serial/8250/8250_lpss.c b/drivers/tty/serial/8250/8250_lpss.c
> index 58cbb30..f09f68a 100644
> --- a/drivers/tty/serial/8250/8250_lpss.c
> +++ b/drivers/tty/serial/8250/8250_lpss.c
> @@ -47,7 +47,7 @@ struct lpss8250_board {
>         unsigned long freq;
>         unsigned int base_baud;
>         int (*setup)(struct lpss8250 *, struct uart_port *p);
> -       void (*exit)(struct lpss8250 *);
> +       void (*exit)(struct lpss8250 *, struct pci_dev *pdev);
>  };
>
>  struct lpss8250 {
> @@ -226,9 +226,10 @@ static int qrk_serial_setup(struct lpss8250 *lpss, struct uart_port *port)
>         return 0;
>  }
>
> -static void qrk_serial_exit(struct lpss8250 *lpss)
> +static void qrk_serial_exit(struct lpss8250 *lpss, struct pci_dev *pdev)
>  {
>         qrk_serial_exit_dma(lpss);
> +       pci_free_irq_vectors(pdev);
>  }
>
>  static bool lpss8250_dma_filter(struct dma_chan *chan, void *param)
> @@ -324,7 +325,7 @@ static int lpss8250_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>
>  err_exit:
>         if (lpss->board->exit)
> -               lpss->board->exit(lpss);
> +               lpss->board->exit(lpss, pdev);
>         return ret;
>  }
>
> @@ -333,7 +334,7 @@ static void lpss8250_remove(struct pci_dev *pdev)
>         struct lpss8250 *lpss = pci_get_drvdata(pdev);
>
>         if (lpss->board->exit)
> -               lpss->board->exit(lpss);
> +               lpss->board->exit(lpss, pdev);
>
>         serial8250_unregister_port(lpss->line);
>  }
> --
> 2.1.4



-- 
With Best Regards,
Andy Shevchenko
