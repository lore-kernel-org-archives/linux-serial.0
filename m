Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF868C11F68
	for <linux-serial@archiver.kernel.org>; Tue, 29 Jun 2021 06:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2FE461DC5
	for <linux-serial@archiver.kernel.org>; Tue, 29 Jun 2021 06:19:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232041AbhF2GV3 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 29 Jun 2021 02:21:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:35642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232029AbhF2GV2 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 29 Jun 2021 02:21:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C9A1B61DC1;
        Tue, 29 Jun 2021 06:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1624947541;
        bh=j/QptbEon823E8WlB8x1s+cyTfvYWt/sjkL6rYuUcHw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ePZcphumiKcimv6vrOnb5OBSEFKNGf24hs+NN1mYQUxyDUw1dhIFWi2u2VP7H73Sf
         3xczPj1sk7+hXvCCw+hHpiI0UaORO6A9D3J/SoHxdzWSs9MFaFrTnuMesBW90J3iyK
         JRz6QasoLlzTkViC5iWkwmaepdMViA+O7r/boRfs=
Date:   Tue, 29 Jun 2021 08:18:59 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Bing Fan <hptsfb@gmail.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm pl011 serial: support multi-irq request
Message-ID: <YNq7Uwj/yJi7NvE8@kroah.com>
References: <1624930164-18411-1-git-send-email-hptsfb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1624930164-18411-1-git-send-email-hptsfb@gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Jun 29, 2021 at 09:29:24AM +0800, Bing Fan wrote:
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
>  drivers/tty/serial/amba-pl011.c | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
> index 78682c12156a..b63164e89903 100644
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c
> @@ -1703,9 +1703,30 @@ static void pl011_write_lcr_h(struct uart_amba_port *uap, unsigned int lcr_h)
>  
>  static int pl011_allocate_irq(struct uart_amba_port *uap)
>  {
> +	int ret = -1;

Pick a real error value.

> +	int i = 0;

Why is this initialized?

> +	unsigned int virq = 0;

Why is this initialized?

> +	struct amba_device *amba_dev = (struct amba_device *)uap->port.dev;

Are you sure you can just cast this like this?  Did you test this?

> +
> +	if (!amba_dev)
> +		return -1;

Do not make up error numbers, return a specific -ERR* value.

And how can this happen?

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
> +		if (ret < 0) {
> +			dev_info(uap->port.dev, "%s %d request %u interrupt failed\n",
> +					__func__, __LINE__, virq);

dev_err() is for errors, not dev_info().

And no need for __func__ and __LINE__ for the dev_* calls.



> +			break;
> +		}
> +	}
> +
> +	return ret;
>  }
>  
>  /*
> -- 
> 2.17.1
> 
