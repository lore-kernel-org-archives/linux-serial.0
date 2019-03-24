From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v4] tty: 8250: fix a missing check for pci_ioremap_bar
Date: Sun, 24 Mar 2019 20:47:45 +0200
Message-ID: <CAHp75VcXg1HFKS6ve3v_Xs_fH+9ogm1hsOgKEe4Z1OYhABfFgg@mail.gmail.com>
References: <20190324164139.23899-1-pakki001@umn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190324164139.23899-1-pakki001@umn.edu>
Sender: linux-kernel-owner@vger.kernel.org
To: Aditya Pakki <pakki001@umn.edu>
Cc: Kangjie Lu <kjlu@umn.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Vinod Koul <vkoul@kernel.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Sun, Mar 24, 2019 at 6:43 PM Aditya Pakki <pakki001@umn.edu> wrote:
>
> pci_ioremap_bar could fail. The patch returns in case of failure to
> acquire IOMEM. It also releases the acquired resource in the exit path.

This is good per se, but I'm so sorry I found another missed place.
When DMA ->probe() fails, we have to unmap as well.

>
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
>
> ---
> v3: Change the order of pci_iounmap and dw_dma_remove
> v2: Failed to release resource in exit path and incorrect code in non
> DMA case, suggested by Andy Shevchenko
> v1: Missed return by default in CONFIG_SERIAL_8250_DMA, suggested by
> Jiri Slaby
> ---
>  drivers/tty/serial/8250/8250_lpss.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/8250/8250_lpss.c b/drivers/tty/serial/8250/8250_lpss.c
> index 53ca9ba6ab4b..69d6e32da713 100644
> --- a/drivers/tty/serial/8250/8250_lpss.c
> +++ b/drivers/tty/serial/8250/8250_lpss.c
> @@ -170,9 +170,11 @@ static void qrk_serial_setup_dma(struct lpss8250 *lpss, struct uart_port *port)
>         int ret;
>
>         chip->dev = &pdev->dev;
> +       chip->pdata = &qrk_serial_dma_pdata;
>         chip->irq = pci_irq_vector(pdev, 0);
>         chip->regs = pci_ioremap_bar(pdev, 1);
> -       chip->pdata = &qrk_serial_dma_pdata;
> +       if (!chip->regs)
> +               return;
>
>         /* Falling back to PIO mode if DMA probing fails */
>         ret = dw_dma_probe(chip);
> @@ -199,7 +201,10 @@ static void qrk_serial_exit_dma(struct lpss8250 *lpss)
>
>         if (!param->dma_dev)
>                 return;
> +
>         dw_dma_remove(&lpss->dma_chip);
> +
> +       pci_iounmap(param->dma_dev, &lpss->dma_chip->regs);
>  }
>  #else  /* CONFIG_SERIAL_8250_DMA */
>  static void qrk_serial_setup_dma(struct lpss8250 *lpss, struct uart_port *port) {}
> --
> 2.17.1
>


-- 
With Best Regards,
Andy Shevchenko
