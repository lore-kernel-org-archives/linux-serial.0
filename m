From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v6] tty: 8250: fix a missing check for pci_ioremap_bar
Date: Tue, 26 Mar 2019 12:17:58 +0200
Message-ID: <20190326101758.GV9224@smile.fi.intel.com>
References: <20190325222147.13342-1-pakki001@umn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190325222147.13342-1-pakki001@umn.edu>
Sender: linux-kernel-owner@vger.kernel.org
To: Aditya Pakki <pakki001@umn.edu>
Cc: kjlu@umn.edu, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Vinod Koul <vkoul@kernel.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Mon, Mar 25, 2019 at 05:21:46PM -0500, Aditya Pakki wrote:
> pci_ioremap_bar could fail. The patch returns in case of failure to
> acquire IOMEM. It also releases the acquired resource in the exit path.

Thanks for an update.
One comment below.

After addressing it, take mine
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> 
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> 
> ---
> v5: change pci_iounmap to iounmap to pass kbuild errors in other arch
> v4: Missed resource release in dma_probe failure.
> v3: Change the order of pci_iounmap and dw_dma_remove
> v2: Failed to release resource in exit path and incorrect code in non
> DMA case, suggested by Andy Shevchenko
> v1: Missed return by default in CONFIG_SERIAL_8250_DMA, suggested by
> Jiri Slaby
> ---
>  drivers/tty/serial/8250/8250_lpss.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_lpss.c b/drivers/tty/serial/8250/8250_lpss.c
> index 53ca9ba6ab4b..c7c7bf5d7e5e 100644
> --- a/drivers/tty/serial/8250/8250_lpss.c
> +++ b/drivers/tty/serial/8250/8250_lpss.c
> @@ -170,14 +170,18 @@ static void qrk_serial_setup_dma(struct lpss8250 *lpss, struct uart_port *port)
>  	int ret;
>  
>  	chip->dev = &pdev->dev;
> +	chip->pdata = &qrk_serial_dma_pdata;
>  	chip->irq = pci_irq_vector(pdev, 0);
>  	chip->regs = pci_ioremap_bar(pdev, 1);
> -	chip->pdata = &qrk_serial_dma_pdata;
> +	if (!chip->regs)
> +		return;
>  
>  	/* Falling back to PIO mode if DMA probing fails */
>  	ret = dw_dma_probe(chip);
> -	if (ret)
> +	if (ret) {
> +		iounmap(chip->regs);
>  		return;
> +	}
>  
>  	pci_try_set_mwi(pdev);
>  
> @@ -199,7 +203,10 @@ static void qrk_serial_exit_dma(struct lpss8250 *lpss)
>  
>  	if (!param->dma_dev)
>  		return;
> +
>  	dw_dma_remove(&lpss->dma_chip);
> +
> +	iounmap(&lpss->dma_chip->regs);

This is a bit fragile form of writing. Perhaps

        struct dw_dma_chip *chip = &lpss->dma_chip;

	...
	dw_dma_remove(chip);

	iounmap(chip->regs);

>  }
>  #else	/* CONFIG_SERIAL_8250_DMA */
>  static void qrk_serial_setup_dma(struct lpss8250 *lpss, struct uart_port *port) {}
> -- 
> 2.17.1
> 

-- 
With Best Regards,
Andy Shevchenko
