Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE791C11F65
	for <linux-serial@archiver.kernel.org>; Wed, 30 Jun 2021 09:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CFBA61D06
	for <linux-serial@archiver.kernel.org>; Wed, 30 Jun 2021 09:10:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233675AbhF3JMp (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 30 Jun 2021 05:12:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:53858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233561AbhF3JMo (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 30 Jun 2021 05:12:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D11C561375;
        Wed, 30 Jun 2021 09:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1625044215;
        bh=BwIdTxuROLQE7JivcAvbimKNyDHnZq4N/RWe1m3hc/I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uU7HMRHmwRgQ7OFo/R4xFNBGsqbaoA8jQbPYJykVGXpReVfPl94fjTFqZDiIdOKxT
         NrY6cs69/QH3qllrjLfhrj40CHsAqRJajbSYIZ+njY6b+vgZxf10ZFQMvLqQC+G875
         usXYHoGcwDFyz9jk6u+/FHY3HV/0tOBwNcVzsLsA=
Date:   Wed, 30 Jun 2021 11:10:13 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Bing Fan <hptsfb@gmail.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] arm pl011 serial: support multi-irq request
Message-ID: <YNw09QUcUedGzOeL@kroah.com>
References: <1625018153-14672-1-git-send-email-hptsfb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1625018153-14672-1-git-send-email-hptsfb@gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Jun 30, 2021 at 09:55:53AM +0800, Bing Fan wrote:
> From: Bing Fan <tombinfan@tencent.com>
> 
> In order to make pl011 work better, multiple interrupts are
> required, such as TXIM, RXIM, RTIM, error interrupt(FE/PE/BE/OE);
> at the same time, pl011 to GIC does not merge the interrupt
> lines(each serial-interrupt corresponding to different GIC hardware
> interrupt), so need to enable and request multiple gic interrupt
> numbers in the driver.
> 
> Signed-off-by: Bing Fan <tombinfan@tencent.com>
> ---
>  drivers/tty/serial/amba-pl011.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
> index 78682c12156a..8b471de0e31c 100644
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c
> @@ -1703,9 +1703,26 @@ static void pl011_write_lcr_h(struct uart_amba_port *uap, unsigned int lcr_h)
>  
>  static int pl011_allocate_irq(struct uart_amba_port *uap)
>  {
> +	int ret = 0;
> +	int i;
> +	unsigned int virq;
> +	struct amba_device *amba_dev = container_of(uap->port.dev, struct amba_device, dev);
> +
>  	pl011_write(uap->im, uap, REG_IMSC);
>  
> -	return request_irq(uap->port.irq, pl011_int, IRQF_SHARED, "uart-pl011", uap);
> +	for (i = 0; i < AMBA_NR_IRQS; i++) {
> +		virq = amba_dev->irq[i];
> +		if (virq == 0)
> +			break;
> +
> +		ret = request_irq(virq, pl011_int, IRQF_SHARED, "uart-pl011-*", uap);
> +		if (ret) {
> +			dev_err(uap->port.dev, "request %u interrupt failed\n", virq);
> +			break;

No error handling to put back the irq you requested if an error happens?
That feels like a memory leak...

thanks,

greg k-h
