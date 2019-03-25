From: Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCH v5] tty: 8250: fix a missing check for pci_ioremap_bar
Date: Mon, 25 Mar 2019 07:25:38 +0100
Message-ID: <6d82a501-59f7-67e7-85fd-8fe44e7793d3@suse.cz>
References: <20190324192209.27202-1-pakki001@umn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190324192209.27202-1-pakki001@umn.edu>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Aditya Pakki <pakki001@umn.edu>
Cc: Vinod Koul <vkoul@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kjlu@umn.edu, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 24. 03. 19, 20:22, Aditya Pakki wrote:
> pci_ioremap_bar could fail. The patch returns in case of failure to
> acquire IOMEM. It also releases the acquired resource in the exit path.
> 
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> 
> ---
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
> index 53ca9ba6ab4b..a098902221df 100644
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
> +		pci_iounmap(pdev, chip->regs);
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
> +	pci_iounmap(param->dma_dev, &lpss->dma_chip->regs);

pci_iounmap is a counterpart of pci_iomap, not pci_ioremap_bar.

You should use plain iounmap. pci_iounmap should do the right job on x86
at least too. But I am not so sure about the other archs -- I suspect
s390 to emit a WARNING.

>  }
>  #else	/* CONFIG_SERIAL_8250_DMA */
>  static void qrk_serial_setup_dma(struct lpss8250 *lpss, struct uart_port *port) {}
> 

thanks,
-- 
js
suse labs
