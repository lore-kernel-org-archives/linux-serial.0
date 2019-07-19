From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] 8250_lpss: check null return when calling pci_ioremap_bar
Date: Fri, 19 Jul 2019 16:37:35 +0300
Message-ID: <20190719133735.GM9224@smile.fi.intel.com>
References: <20190719025443.2368-1-navid.emamdoost@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190719025443.2368-1-navid.emamdoost@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Navid Emamdoost <navid.emamdoost@gmail.com>, Kangjie Lu <kjlu@umn.edu>, Aditya Pakki <pakki001@umn.edu>
Cc: emamd001@umn.edu, smccaman@umn.edu, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Vinod Koul <vkoul@kernel.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Thu, Jul 18, 2019 at 09:54:42PM -0500, Navid Emamdoost wrote:
> pci_ioremap_bar may return null. This is eventually de-referenced at 
> drivers/dma/dw/core.c:1154 and drivers/dma/dw/core.c:1168. A null check is
>  needed to prevent null de-reference. I am adding the check and in case of
>  failure returning -ENOMEM (I am not sure this is the best errno, you may 
> consider it as a placeholder), and subsequently changing the caller’s 
> return type, and propagating the error.

Thanks for the patch, my comments below.

>  	chip->irq = pci_irq_vector(pdev, 0);
>  	chip->regs = pci_ioremap_bar(pdev, 1);
> +	if (!chip->regs)
> +		return -ENOMEM;

This is the same case as below, it's fine to go on without DMA support.

>  	chip->pdata = &qrk_serial_dma_pdata;

So, I would rather to put like this...

Hold on, I remember someone already tried to fix this [1].

I dunno why it wasn't v5, due to [2].

Also, similar to yours, but wrong [3].

Thus, please, collaborate guys, and send one compiling solution  based on [1].

>  	/* Falling back to PIO mode if DMA probing fails */
>  	ret = dw_dma_probe(chip);
>  	if (ret)
> -		return;
> +		return 0;

[1]: https://www.spinics.net/lists/linux-serial/msg33965.html
[2]: https://lists.01.org/pipermail/kbuild-all/2019-March/059215.html
[3]: https://lore.kernel.org/patchwork/patch/1051000/

-- 
With Best Regards,
Andy Shevchenko
