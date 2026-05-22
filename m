Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A4B34F26F;
	Fri, 22 May 2026 08:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779439604; cv=none; b=bpJ6apsW0yyiIZfe3qIPxnJDcZm6lUABFVl0ioRxE6U9Deqo4X1dSXMfm5Am5HJL1Gjq46mNSLrJf6LzKXbGSH1pDoQ10nHh7J+/T4QK3Aff/li/+96iRZsvHwmxvvLhcSdFlymGK0781hm9JbdSbstesZVcxNDDAB6BwwJNBIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779439604; c=relaxed/simple;
	bh=6/f+NQcz6NMps2nNiSmNHpgcvHiXoYpCLgxoKim1Tyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kUHPl80jWEeUOQLMijoZE72hTw5huRAAWDwUyhn4mGDkfqrvPxFuht1ogHrSrQ9L6fttAcZtp+mMUS++Q+zvnJq5/FaVDnqgskavyxcN53EAgdrfbP5dFdm/Rt07Yk/fp6+F5fv9byULG2HkE8isBE9nEwumtw1zDVIIHv46tDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Iw45raja; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Iw45raja"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08E7A1F00A3F;
	Fri, 22 May 2026 08:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779439602;
	bh=ohYeGryplqMtvuNCh9eJTw1vBr6mAuDijxirsEWRBDo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Iw45rajasFluTXj7UeTy+x7hCFyQ4g9mx2EXm5d0GJAOdTwrx1vw/+v72OUpALo0+
	 NgVQyHFG+FVvE1Ae+D0eqvkaWDkJx7eIx3ivXvfv4o2XMspdVsuSejiibHIIt9WXJe
	 j3+9MDODHL4dZGnLPZKHsoZE1uietAwxOCqgSXxA=
Date: Fri, 22 May 2026 10:46:45 +0200
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: Matthias Feser <mfe@kbsgmbhfr.onmicrosoft.com>
Cc: Moteen Shah <m-shah@ti.com>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"jirislaby@kernel.org" <jirislaby@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"k-willis@ti.com" <k-willis@ti.com>,
	"msp@baylibre.com" <msp@baylibre.com>,
	"andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2] serial: 8250_omap: clear rx_running on zero-length
 DMA completes
Message-ID: <2026052225-swinger-unnamable-8ccb@gregkh>
References: <BE3P281MB5515563BFB5DE5E093ADAD9DEE0E2@BE3P281MB5515.DEUP281.PROD.OUTLOOK.COM>
 <4b8c59fe-c6a1-47cb-ab3b-855b1edddde2@ti.com>
 <BE3P281MB55153573889A8124C06291F1EE0F2@BE3P281MB5515.DEUP281.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BE3P281MB55153573889A8124C06291F1EE0F2@BE3P281MB5515.DEUP281.PROD.OUTLOOK.COM>

On Fri, May 22, 2026 at 08:24:01AM +0000, Matthias Feser wrote:
> Thanks for the fast response. I've updated the patch accordingly.
> 
> From: Matthias Feser <mfe@KBSgmbhfr.onmicrosoft.com>
> Date: Fri, 22 May 2026 10:11:16 +0200
> Subject: [PATCH v2] serial: 8250_omap: clear rx_running on zero-length DMA completes
> 
> On AM33xx RX DMA only triggers when the FIFO reaches the
> configured threshold (typically 48 bytes). For smaller bursts
> no DMA request is issued and the FIFO is drained by RX timeout.
> 
> In this case __dma_rx_do_complete() can legitimately see count == 0.
> 
> The current code exits early in this case and does not clear
> dma->rx_running, leaving the DMA state inconsistent. This can
> prevent RX DMA from restarting and may cause
> omap_8250_rx_dma_flush() to fail, marking DMA as broken.
> 
> Fix this by clearing dma->rx_running once the DMA transfer has
> completed or been terminated, even if no data was transferred.
> 
> Changes in v2:
> - Move dma->rx_running clear before the count check so the state
>   is updated immediately after DMA completion/termination
> 
> Signed-off-by: Matthias Feser <mfe@KBSgmbhfr.onmicrosoft.com>
> ---
>  drivers/tty/serial/8250/8250_omap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
> index c552c6b9a037..76bc8ad324cb 100644
> --- a/drivers/tty/serial/8250/8250_omap.c
> +++ b/drivers/tty/serial/8250/8250_omap.c
> @@ -944,11 +944,11 @@ static void __dma_rx_do_complete(struct uart_8250_port *p)
>  				dev_err(p->port.dev, "teardown incomplete\n");
>  		}
>  	}
> +	dma->rx_running = 0;
>  	if (!count)
>  		goto out;
>  	ret = tty_insert_flip_string(tty_port, dma->rx_buf, count);
>  
> -	dma->rx_running = 0;
>  	p->port.icount.rx += ret;
>  	p->port.icount.buf_overrun += count - ret;
>  out:
> -- 
> 2.39.5
> 

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

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
