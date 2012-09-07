From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH] serial: mxs-auart: put the device when exit or error
Date: Fri, 7 Sep 2012 11:14:19 +0800
Message-ID: <20120907031416.GJ26709@S2101-09.ap.freescale.net>
References: <20120907024349.GH26709@S2101-09.ap.freescale.net>
 <1346985187-30459-1-git-send-email-b32955@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:51031 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752487Ab2IGDOF (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 6 Sep 2012 23:14:05 -0400
Received: by pbbrr13 with SMTP id rr13so3396847pbb.19
        for <linux-serial@vger.kernel.org>; Thu, 06 Sep 2012 20:14:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1346985187-30459-1-git-send-email-b32955@freescale.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Huang Shijie <b32955@freescale.com>
Cc: gregkh@linuxfoundation.org, alan@linux.intel.com, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

On Fri, Sep 07, 2012 at 10:33:07AM +0800, Huang Shijie wrote:
> We call the get_device() in the mxs_auart_probe().
> For the balance of the reference count, we should put the
> device in the mxs_auart_remove() or in the error path of
> probe.
> 
> Signed-off-by: Huang Shijie <b32955@freescale.com>

Acked-by: Shawn Guo <shawn.guo@linaro.org>

> ---
>  drivers/tty/serial/mxs-auart.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
> index 3a667ee..203e512 100644
> --- a/drivers/tty/serial/mxs-auart.c
> +++ b/drivers/tty/serial/mxs-auart.c
> @@ -781,6 +781,7 @@ out_free_irq:
>  	auart_port[pdev->id] = NULL;
>  	free_irq(s->irq, s);
>  out_free_clk:
> +	put_device(s->dev);
>  	clk_put(s->clk);
>  out_free:
>  	kfree(s);
> @@ -796,6 +797,7 @@ static int __devexit mxs_auart_remove(struct platform_device *pdev)
>  
>  	auart_port[pdev->id] = NULL;
>  
> +	put_device(s->dev);
>  	clk_put(s->clk);
>  	free_irq(s->irq, s);
>  	kfree(s);
> -- 
> 1.7.0.4
> 
> 
