Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA9FC11F65
	for <linux-serial@archiver.kernel.org>; Wed, 30 Jun 2021 12:27:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49D73613C1
	for <linux-serial@archiver.kernel.org>; Wed, 30 Jun 2021 12:27:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234444AbhF3MaQ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 30 Jun 2021 08:30:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:46150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234426AbhF3MaQ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 30 Jun 2021 08:30:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6FD45613C1;
        Wed, 30 Jun 2021 12:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1625056066;
        bh=uluTb2HnmteXU5pZeTimFt6ItcWD2B3y13nc8+jEXvI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yvS8XtnC5uYb/fQ5De4N3V5Svnt4Bvd6phoC6EwYqWX08sThKJoNtUgup0A6P4La5
         TV7+QR+MMvbh/pQde0VxRTmwzdmj4TL1ql3x/zWJ3nt36gi4gIQOkfZ/nw3adBJtbt
         NPRzp7UR0JufHuXSI3UySAz93H4cqDoDaRl7Hrpc=
Date:   Wed, 30 Jun 2021 14:27:44 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Bing Fan <hptsfb@gmail.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] arm pl011 serial: support multi-irq request
Message-ID: <YNxjQHblAHo04q/+@kroah.com>
References: <1625052305-18929-1-git-send-email-hptsfb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1625052305-18929-1-git-send-email-hptsfb@gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Jun 30, 2021 at 07:25:05PM +0800, Bing Fan wrote:
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
>  drivers/tty/serial/amba-pl011.c | 35 ++++++++++++++++++++++++++++++---
>  1 file changed, 32 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
> index 78682c12156a..e84f4b9dff87 100644
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c
> @@ -1701,11 +1701,40 @@ static void pl011_write_lcr_h(struct uart_amba_port *uap, unsigned int lcr_h)
>  	}
>  }
>  
> +static void pl011_release_irq(struct uart_amba_port *uap, unsigned int max_cnt)
> +{
> +	struct amba_device *amba_dev = container_of(uap->port.dev, struct amba_device, dev);

Pass in the amba_dev instead here, you already have a pointer to it at
all places, right?

> +	int i;
> +
> +	for (i = 0; i < max_cnt; i++) {
> +		if (amba_dev->irq[i])
> +			free_irq(amba_dev->irq[i], uap);
> +	}

You do not need { } here, didn't checkpatch warn about this?

> +}
> +
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
> +		ret = request_irq(virq, pl011_int, IRQF_SHARED, dev_name(&amba_dev->dev), uap);
> +		if (ret) {
> +			dev_err(uap->port.dev, "request %u interrupt failed\n", virq);
> +			pl011_release_irq(uap, i - 1);
> +			break;
> +		}
> +	}
> +
> +	return ret;
>  }
>  
>  /*
> @@ -1864,7 +1893,7 @@ static void pl011_shutdown(struct uart_port *port)
>  
>  	pl011_dma_shutdown(uap);
>  
> -	free_irq(uap->port.irq, uap);
> +	pl011_release_irq(uap, AMBA_NR_IRQS);

Ah, so your original patch was not correct either, how well have you
tested these changes?

thanks,

greg k-h
