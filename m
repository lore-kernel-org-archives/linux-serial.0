From: Wang YanQing <udknight@gmail.com>
Subject: Re: [PATCH 2/3] serial: 8250_pci: remove unnecessary
 pci_set_drvdata()
Date: Thu, 12 Sep 2013 22:47:08 +0800
Message-ID: <20130912144708.GA2887@udknight>
References: <000d01ceaf81$a9910aa0$fcb31fe0$%han@samsung.com>
 <000e01ceaf82$0a2fff10$1e8ffd30$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:52654 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752828Ab3ILOrj (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 12 Sep 2013 10:47:39 -0400
Received: by mail-pa0-f47.google.com with SMTP id kl13so1189387pab.6
        for <linux-serial@vger.kernel.org>; Thu, 12 Sep 2013 07:47:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <000e01ceaf82$0a2fff10$1e8ffd30$%han@samsung.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jingoo Han <jg1.han@samsung.com>
Cc: 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, 'Ian Abbott' <abbotti@mev.co.uk>, 'Stephen Chivers' <schivers@csc.com>, 'Stephen Hurd' <shurd@broadcom.com>

On Thu, Sep 12, 2013 at 03:33:48PM +0900, Jingoo Han wrote:
> The driver core clears the driver data to NULL after device_release
> or on probe failure. Thus, it is not needed to manually clear the
> device driver data to NULL.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---
>  drivers/tty/serial/8250/8250_pci.c |    2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
> index c810da7..515fd0f 100644
> --- a/drivers/tty/serial/8250/8250_pci.c
> +++ b/drivers/tty/serial/8250/8250_pci.c
> @@ -3520,8 +3520,6 @@ static void pciserial_remove_one(struct pci_dev *dev)
>  {
>  	struct serial_private *priv = pci_get_drvdata(dev);
>  
> -	pci_set_drvdata(dev, NULL);
> -
>  	pciserial_remove_ports(priv);
>  
>  	pci_disable_device(dev);
> -- 
> 1.7.10.4
> 
Hi All
Below shell give me 1267 result for 3.10.11:

"find drivers/ -name "*.[ch]" | xargs grep set_drvdata | grep NULL"

The results include somethings look like below:
drivers/net/wan/dscc4.c:        pci_set_drvdata(pdev, NULL);
drivers/net/wan/wanxl.c:        pci_set_drvdata(pdev, NULL);
drivers/net/wan/lmc/lmc_main.c: pci_set_drvdata(pdev, NULL);
drivers/net/wan/lmc/lmc_main.c:         pci_set_drvdata(pdev, NULL);
drivers/net/wan/ixp4xx_hss.c:   platform_set_drvdata(pdev, NULL);
drivers/net/xen-netback/xenbus.c:       dev_set_drvdata(&dev->dev, NULL);
drivers/net/xen-netfront.c:     dev_set_drvdata(&dev->dev, NULL);
drivers/net/ieee802154/at86rf230.c:     spi_set_drvdata(spi, NULL);
drivers/net/ieee802154/at86rf230.c:     spi_set_drvdata(spi, NULL);
drivers/net/ieee802154/mrf24j40.c:      spi_set_drvdata(spi, NULL);
drivers/net/vmxnet3/vmxnet3_drv.c:      pci_set_drvdata(pdev, NULL);

After a quick search platform_set_drvdata|spi_set_drvdata|pci_set_drvdata,
I found they are just a wrapper for drv_set_drvdata, and almost all drivers
use them in the .remove function in the same pattern *_set_drvdata(DEV, NULL).

Yes, I find driver core in dd.c will call drv_set_drvdata(dev, NULL) after
.remove function. So if all guys think this patch is acceptable, maybe we
could dig into deeper.

Note: I don't say this patch is right or wrong, I hope someone could tell me :)

Thanks.
