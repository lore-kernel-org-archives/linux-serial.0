Return-Path: <SRS0=YMt1=X2=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EEAFC352AA
	for <linux-serial@archiver.kernel.org>; Tue,  1 Oct 2019 08:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0451215EA
	for <linux-serial@archiver.kernel.org>; Tue,  1 Oct 2019 08:59:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733107AbfJAI7n (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 1 Oct 2019 04:59:43 -0400
Received: from mga06.intel.com ([134.134.136.31]:22969 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729031AbfJAI7n (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 1 Oct 2019 04:59:43 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Oct 2019 01:59:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,570,1559545200"; 
   d="scan'208";a="197801234"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by FMSMGA003.fm.intel.com with ESMTP; 01 Oct 2019 01:59:41 -0700
Received: from andy by smile with local (Exim 4.92.1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iFE0S-00007r-90; Tue, 01 Oct 2019 11:59:40 +0300
Date:   Tue, 1 Oct 2019 11:59:40 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Felipe Balbi <felipe.balbi@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: 8250_lpss: Switch over to MSI interrupts
Message-ID: <20191001085940.GE32742@smile.fi.intel.com>
References: <20191001081617.766084-1-felipe.balbi@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191001081617.766084-1-felipe.balbi@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Oct 01, 2019 at 11:16:17AM +0300, Felipe Balbi wrote:
> Some devices support MSI interrupts. Let's at least try to use them in
> platforms that provide MSI capability.

Thanks for the patch!

I think you may clean up qrk_serial_setup() as well.

> Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
> ---
>  drivers/tty/serial/8250/8250_lpss.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_lpss.c b/drivers/tty/serial/8250/8250_lpss.c
> index 5f72ef3ea574..f0f7a2777557 100644
> --- a/drivers/tty/serial/8250/8250_lpss.c
> +++ b/drivers/tty/serial/8250/8250_lpss.c
> @@ -293,16 +293,22 @@ static int lpss8250_probe(struct pci_dev *pdev, const struct pci_device_id *id)
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
> @@ -337,6 +343,7 @@ static int lpss8250_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  err_exit:
>  	if (lpss->board->exit)
>  		lpss->board->exit(lpss);
> +	pci_free_irq_vectors(pdev);
>  	return ret;
>  }
>  
> @@ -348,6 +355,7 @@ static void lpss8250_remove(struct pci_dev *pdev)
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


