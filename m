From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2] tty: 8250: fix a missing check for pci_ioremap_bar
Date: Sun, 24 Mar 2019 14:05:09 +0200
Message-ID: <CAHp75VdeB=jPaqY_VNDA7YeCiEdyVFJAmOmC4sDvZLBv-7KQ0w@mail.gmail.com>
References: <20190323225313.12325-1-pakki001@umn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190323225313.12325-1-pakki001@umn.edu>
Sender: linux-kernel-owner@vger.kernel.org
To: Aditya Pakki <pakki001@umn.edu>
Cc: Kangjie Lu <kjlu@umn.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Vinod Koul <vkoul@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Sun, Mar 24, 2019 at 12:55 AM Aditya Pakki <pakki001@umn.edu> wrote:
>
> pci_ioremap_bar could fail. The fix captures the failure and
> pass an error code upstream. This can avoid potential NULL
> pointer dereferences in the future.
>

NAK.
This will break non-DMA case.

> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
>
> ---
> v1: Missed return by default in CONFIG_SERIAL_8250_DMA, suggested by
> Jiri Slaby
> ---
>  drivers/tty/serial/8250/8250_lpss.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/tty/serial/8250/8250_lpss.c b/drivers/tty/serial/8250/8250_lpss.c
> index 53ca9ba6ab4b..1dc67897dcf8 100644
> --- a/drivers/tty/serial/8250/8250_lpss.c
> +++ b/drivers/tty/serial/8250/8250_lpss.c
> @@ -161,7 +161,7 @@ static const struct dw_dma_platform_data qrk_serial_dma_pdata = {
>         .multi_block = {0},
>  };
>
> -static void qrk_serial_setup_dma(struct lpss8250 *lpss, struct uart_port *port)
> +static int qrk_serial_setup_dma(struct lpss8250 *lpss, struct uart_port *port)
>  {
>         struct uart_8250_dma *dma = &lpss->dma;
>         struct dw_dma_chip *chip = &lpss->dma_chip;
> @@ -172,12 +172,14 @@ static void qrk_serial_setup_dma(struct lpss8250 *lpss, struct uart_port *port)
>         chip->dev = &pdev->dev;
>         chip->irq = pci_irq_vector(pdev, 0);
>         chip->regs = pci_ioremap_bar(pdev, 1);
> +       if (!chip->regs)
> +               return -EIO;
>         chip->pdata = &qrk_serial_dma_pdata;
>
>         /* Falling back to PIO mode if DMA probing fails */
>         ret = dw_dma_probe(chip);
>         if (ret)
> -               return;
> +               return ret;
>
>         pci_try_set_mwi(pdev);
>
> @@ -191,6 +193,7 @@ static void qrk_serial_setup_dma(struct lpss8250 *lpss, struct uart_port *port)
>         param->hs_polarity = true;
>
>         lpss->dma_maxburst = 8;
> +       return 0;
>  }
>
>  static void qrk_serial_exit_dma(struct lpss8250 *lpss)
> @@ -202,7 +205,11 @@ static void qrk_serial_exit_dma(struct lpss8250 *lpss)
>         dw_dma_remove(&lpss->dma_chip);
>  }
>  #else  /* CONFIG_SERIAL_8250_DMA */
> -static void qrk_serial_setup_dma(struct lpss8250 *lpss, struct uart_port *port) {}
> +static int qrk_serial_setup_dma(struct lpss8250 *lpss, struct uart_port *port)
> +{
> +       return 0;
> +}
> +
>  static void qrk_serial_exit_dma(struct lpss8250 *lpss) {}
>  #endif /* !CONFIG_SERIAL_8250_DMA */
>
> @@ -219,8 +226,7 @@ static int qrk_serial_setup(struct lpss8250 *lpss, struct uart_port *port)
>
>         port->irq = pci_irq_vector(pdev, 0);
>
> -       qrk_serial_setup_dma(lpss, port);
> -       return 0;
> +       return qrk_serial_setup_dma(lpss, port);
>  }
>
>  static void qrk_serial_exit(struct lpss8250 *lpss)
> --
> 2.17.1
>


-- 
With Best Regards,
Andy Shevchenko
