Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4585C4338F
	for <linux-serial@archiver.kernel.org>; Fri, 13 Aug 2021 07:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DD286103E
	for <linux-serial@archiver.kernel.org>; Fri, 13 Aug 2021 07:19:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239291AbhHMHTr (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 13 Aug 2021 03:19:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:42258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239248AbhHMHTr (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 13 Aug 2021 03:19:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 306F86103A;
        Fri, 13 Aug 2021 07:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1628839160;
        bh=gdGgukaTpNdeTLbR8bjikQFUEVSQ0BaQIAOZfGs68jo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ND/Rg/bTL4d2NqRZenL/APCn/E3Jty+o4CGqb8+/OHOPO4elGa5Irf5Sg7FE0nkss
         r/XBF/dz+arpWigTWsJ1xtMwczdym3LDmJk+g692b/s5tsZWN5AYmOPTuCZ2vFyxkb
         V3m+rg9dGE5StSWQd5XsDhTOG8W0T+6zvh75MKzs=
Date:   Fri, 13 Aug 2021 09:19:18 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Bing Fan <hptsfb@gmail.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] arm pl011 serial: support multi-irq request
Message-ID: <YRYc9nCcpGOs4SaJ@kroah.com>
References: <1628825490-18937-1-git-send-email-hptsfb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1628825490-18937-1-git-send-email-hptsfb@gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Aug 13, 2021 at 11:31:30AM +0800, Bing Fan wrote:
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
>  drivers/tty/serial/amba-pl011.c | 39 +++++++++++++++++++++++++++++++--
>  1 file changed, 37 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
> index e14f3378b8a0..eaac3431459c 100644
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c
> @@ -1701,6 +1701,41 @@ static void pl011_write_lcr_h(struct uart_amba_port *uap, unsigned int lcr_h)
>  	}
>  }
>  
> +static void pl011_release_multi_irqs(struct uart_amba_port *uap, unsigned int max_cnt)
> +{
> +	struct amba_device *amba_dev = container_of(uap->port.dev, struct amba_device, dev);
> +	int i;
> +
> +	for (i = 0; i < max_cnt; i++)
> +		if (amba_dev->irq[i])
> +			free_irq(amba_dev->irq[i], uap);
> +}
> +
> +static int pl011_allocate_multi_irqs(struct uart_amba_port *uap)
> +{
> +	int ret = 0;
> +	int i;
> +	unsigned int virq;
> +	struct amba_device *amba_dev = container_of(uap->port.dev, struct amba_device, dev);
> +
> +	pl011_write(uap->im, uap, REG_IMSC);
> +
> +	for (i = 0; i < AMBA_NR_IRQS; i++) {
> +		virq = amba_dev->irq[i];
> +		if (virq == 0)
> +			break;
> +
> +		ret = request_irq(virq, pl011_int, IRQF_SHARED, dev_name(&amba_dev->dev), uap);
> +		if (ret) {
> +			dev_err(uap->port.dev, "request %u interrupt failed\n", virq);
> +			pl011_release_multi_irqs(uap, i - 1);
> +			break;
> +		}
> +	}
> +
> +	return ret;
> +}

This function looks identical to pl011_allocate_irq(), so what is the
difference here?  Why is this still needed at all?  What does it do that
is different from pl011_allocate_irq()?

confused,

greg k-h
