Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC57C2B9F4
	for <linux-serial@archiver.kernel.org>; Mon, 28 Jun 2021 08:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5ED5261C2E
	for <linux-serial@archiver.kernel.org>; Mon, 28 Jun 2021 08:48:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232214AbhF1IvH (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 28 Jun 2021 04:51:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:35388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231683AbhF1IvH (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 28 Jun 2021 04:51:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4DD026108B;
        Mon, 28 Jun 2021 08:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1624870121;
        bh=8A0dJggrHgLUXVOsaEGaAZv0/ji2VPqrS/XWZsuMxXI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BrJzt5xIBjMEQUtgjX81Gef4fBD3HxfzeB/7PQ8Vyb+0e+b5REpD68bspiYDau2Bk
         lvzn3L8aQnn9iVhICcZ9391LNkwkzzVriwM5UwNs/1zka9aEQ6HpR4o4yQr3Sx/2Tj
         fXKcD02qYr7NcM9/hBh6buLVpmll4J7lM7VE/UV8=
Date:   Mon, 28 Jun 2021 10:48:39 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     bing fan <hptsfb@gmail.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm pl011 serial: support multi-irq request
Message-ID: <YNmM518c49k9V3Hv@kroah.com>
References: <CADVmyHWOVRNfVaJMm9D9KsFsi+t5cDwYtHcA9wn=v_Jh1QK-Rw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADVmyHWOVRNfVaJMm9D9KsFsi+t5cDwYtHcA9wn=v_Jh1QK-Rw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Jun 28, 2021 at 03:19:13PM +0800, bing fan wrote:
> From: Bing Fan <tombinfan@tencent.com>
> 
> In order to make pl011 work better, multiple interrupts are
> required, such as TXIM, RXIM, RTIM, error interrupt(FE/PE/BE/OE);
> at the same time, pl011 to GIC does not merge the interrupt
> lines(each serial-interrupt corresponding to different GIC hardware
> interrupt), so need to enable and request multiple gic interrupt
> numbers in the driver.
> 
> Signed-off-by: Bing Fan <hptsfb@gmail.com>
> ---
>  drivers/tty/serial/amba-pl011.c | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
> index 78682c12156a..2b6f43c27dea 100644
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c
> @@ -1703,9 +1703,30 @@ static void pl011_write_lcr_h(struct
> uart_amba_port *uap, unsigned int lcr_h)
> 
>  static int pl011_allocate_irq(struct uart_amba_port *uap)
>  {
> +       int ret = -1;
> +       int i = 0;
> +       unsigned int virq = 0;
> +       struct amba_device *amba_dev = (struct amba_device *)uap->port.dev;
> +
> +       if (!amba_dev)
> +               return -1;
> +
>         pl011_write(uap->im, uap, REG_IMSC);
> 
> -       return request_irq(uap->port.irq, pl011_int, IRQF_SHARED,
> "uart-pl011", uap);
> +       for (i = 0; i < AMBA_NR_IRQS; i++) {
> +               virq = amba_dev->irq[i];
> +               if (virq == 0)          // request irq until virq is 0
> +                       break;
> +
> +               ret = request_irq(virq, pl011_int, IRQF_SHARED,
> "uart-pl011-*", uap);
> +               if (ret < 0) {
> +                       dev_info(uap->port.dev, "%s %d request %u
> interrupt failed\n",
> +                                       __func__, __LINE__, virq);
> +                       break;
> +               }
> +       }
> +
> +       return ret;
>  }
> 
>  /*
> -- 
> 2.17.1


Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- Your patch is malformed (tabs converted to spaces, linewrapped, etc.)
  and can not be applied.  Please read the file,
  Documentation/email-clients.txt in order to fix this.


If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
