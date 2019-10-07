Return-Path: <SRS0=/4l0=YA=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76399C47404
	for <linux-serial@archiver.kernel.org>; Mon,  7 Oct 2019 12:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FF0D20867
	for <linux-serial@archiver.kernel.org>; Mon,  7 Oct 2019 12:00:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbfJGMAn (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 7 Oct 2019 08:00:43 -0400
Received: from mga04.intel.com ([192.55.52.120]:56885 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727467AbfJGMAn (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 7 Oct 2019 08:00:43 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Oct 2019 05:00:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,268,1566889200"; 
   d="scan'208";a="192260359"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga008.fm.intel.com with ESMTP; 07 Oct 2019 05:00:35 -0700
Received: from andy by smile with local (Exim 4.92.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iHRgn-0007nX-Og; Mon, 07 Oct 2019 15:00:33 +0300
Date:   Mon, 7 Oct 2019 15:00:33 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Felipe Balbi <felipe.balbi@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
Subject: Re: [PATCH v2] serial: 8250_lpss: Switch over to MSI interrupts
Message-ID: <20191007120033.GW32742@smile.fi.intel.com>
References: <20191001115825.795700-1-felipe.balbi@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191001115825.795700-1-felipe.balbi@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Oct 01, 2019 at 02:58:25PM +0300, Felipe Balbi wrote:
> Some devices support MSI interrupts. Let's at least try to use them in
> platforms that provide MSI capability.
> 
> While at that, remove the now duplicated code from qrp_serial_setup().

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
> ---
> 
> Changes since v1:
> 	- Remove duplicated code from qrk_serial_setup()
> 
>  drivers/tty/serial/8250/8250_lpss.c | 21 +++++++++------------
>  1 file changed, 9 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_lpss.c b/drivers/tty/serial/8250/8250_lpss.c
> index 5f72ef3ea574..60eff3240c8a 100644
> --- a/drivers/tty/serial/8250/8250_lpss.c
> +++ b/drivers/tty/serial/8250/8250_lpss.c
> @@ -221,17 +221,6 @@ static void qrk_serial_exit_dma(struct lpss8250 *lpss) {}
>  
>  static int qrk_serial_setup(struct lpss8250 *lpss, struct uart_port *port)
>  {
> -	struct pci_dev *pdev = to_pci_dev(port->dev);
> -	int ret;
> -
> -	pci_set_master(pdev);
> -
> -	ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
> -	if (ret < 0)
> -		return ret;
> -
> -	port->irq = pci_irq_vector(pdev, 0);
> -
>  	qrk_serial_setup_dma(lpss, port);
>  	return 0;
>  }
> @@ -293,16 +282,22 @@ static int lpss8250_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (ret)
>  		return ret;
>  
> +	pci_set_master(pdev);
> +
>  	lpss = devm_kzalloc(&pdev->dev, sizeof(*lpss), GFP_KERNEL);
>  	if (!lpss)
>  		return -ENOMEM;
>  
> +	ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
> +	if (ret < 0)
> +		return ret;
> +
>  	lpss->board = (struct lpss8250_board *)id->driver_data;
>  
>  	memset(&uart, 0, sizeof(struct uart_8250_port));
>  
>  	uart.port.dev = &pdev->dev;
> -	uart.port.irq = pdev->irq;
> +	uart.port.irq = pci_irq_vector(pdev, 0);
>  	uart.port.private_data = &lpss->data;
>  	uart.port.type = PORT_16550A;
>  	uart.port.iotype = UPIO_MEM;
> @@ -337,6 +332,7 @@ static int lpss8250_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  err_exit:
>  	if (lpss->board->exit)
>  		lpss->board->exit(lpss);
> +	pci_free_irq_vectors(pdev);
>  	return ret;
>  }
>  
> @@ -348,6 +344,7 @@ static void lpss8250_remove(struct pci_dev *pdev)
>  
>  	if (lpss->board->exit)
>  		lpss->board->exit(lpss);
> +	pci_free_irq_vectors(pdev);
>  }
>  
>  static const struct lpss8250_board byt_board = {
> -- 
> 2.23.0
> 

-- 
With Best Regards,
Andy Shevchenko


