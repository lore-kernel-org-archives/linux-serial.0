From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH v2] 8250_lpss: check null return when calling
 pci_ioremap_bar
Date: Fri, 26 Jul 2019 13:32:21 +0200
Message-ID: <afc360b9-6d05-72a6-4933-2fc0b84a7cf7@samsung.com>
References: <20190719151519.GO9224@smile.fi.intel.com>
        <20190719174848.24216-1-navid.emamdoost@gmail.com>
        <CGME20190726113223eucas1p287f8f2df03f66658bd492c592fd426e6@eucas1p2.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190719174848.24216-1-navid.emamdoost@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Navid Emamdoost <navid.emamdoost@gmail.com>
Cc: andriy.shevchenko@linux.intel.com, emamd001@umn.edu, kjlu@umn.edu, smccaman@umn.edu, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Vinod Koul <vkoul@kernel.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org


Hi,

On 7/19/19 7:48 PM, Navid Emamdoost wrote:
> pci_ioremap_bar may return null. This is eventually de-referenced at 
> drivers/dma/dw/core.c:1154 and drivers/dma/dw/core.c:1168. A null check 
> is needed to prevent null de-reference. I am adding the check and in case
>  of failure. Thanks to Andy Shevchenko for the hint on the necessity of 
> pci_iounmap when exiting.
> 
> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> ---
>  drivers/tty/serial/8250/8250_lpss.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_lpss.c b/drivers/tty/serial/8250/8250_lpss.c
> index 53ca9ba6ab4b..d07e431110d9 100644
> --- a/drivers/tty/serial/8250/8250_lpss.c
> +++ b/drivers/tty/serial/8250/8250_lpss.c
> @@ -169,10 +169,12 @@ static void qrk_serial_setup_dma(struct lpss8250 *lpss, struct uart_port *port)
>  	struct pci_dev *pdev = to_pci_dev(port->dev);
>  	int ret;
>  
> +	chip->pdata = &qrk_serial_dma_pdata;
>  	chip->dev = &pdev->dev;
>  	chip->irq = pci_irq_vector(pdev, 0);
>  	chip->regs = pci_ioremap_bar(pdev, 1);
> -	chip->pdata = &qrk_serial_dma_pdata;
> +	if (!chip->regs)
> +		return;
>  
>  	/* Falling back to PIO mode if DMA probing fails */
>  	ret = dw_dma_probe(chip);

pci_iounmap() should also be called on dw_dma_probe() failure (in such
case param->dma_dev is NULL so pci_iounmap() in qrk_serial_exit_dma()
won't be called during exit).

> @@ -195,11 +197,15 @@ static void qrk_serial_setup_dma(struct lpss8250 *lpss, struct uart_port *port)
>  pci_iounmap
>  static void qrk_serial_exit_dma(struct lpss8250 *lpss)
>  {
> +	struct dw_dma_chip *chip = &lpss->dma_chip;
>  	struct dw_dma_slave *param = &lpss->dma_param;
>  
>  	if (!param->dma_dev)
>  		return;
> -	dw_dma_remove(&lpss->dma_chip);
> +
> +	dw_dma_remove(chip);
> +
> +	pci_iounmap(to_pci_dev(chip->dev), chip->regs);
>  }
>  #else	/* CONFIG_SERIAL_8250_DMA */
>  static void qrk_serial_setup_dma(struct lpss8250 *lpss, struct uart_port *port) {}

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
