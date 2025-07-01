Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0AF3275B0F;
	Tue,  1 Jul 2025 14:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751378853; cv=none; b=Da0/maHN8O/Dbu1bpgvYzH47qI2KeJCbxSfrweqDNVgs9Ht8cr8Eqvkz+biqV+aqOo66P4DsihPTHwQAAxyTU1f7Tuh27UgYinnk1EVHCQ2wqUQF52sIFGUdKVEMc503e500NmyMb+cR81KjxkvscpJ1qYQXZNFuVdt/+sRnf+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751378853; c=relaxed/simple;
	bh=OycoOkoLhHBvnekRqOGdTwCNdtAIEjmFOv3yyuw9LiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oZ2Bg69WuhPaVak+0esfNRWtlGdBheO7y3OWcsskoYKxyO9WdoQ1cPZH90WKnP9BrLaWIFkiGSnEbqu78x4sYZEBs++4fIDhePIW30AMmgW5eErbWYTjZ4PkYX08f67K2XBFb02ai/ptjv/TskZJ8SKtOon1U5bo593Frfj+RfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KSVzv1HN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KSVzv1HN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4AB2C4CEED;
	Tue,  1 Jul 2025 14:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751378853;
	bh=OycoOkoLhHBvnekRqOGdTwCNdtAIEjmFOv3yyuw9LiI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KSVzv1HNWQ35IVpyzbLDw1WFkDAvFLks/MX6tdtic1/MaqbRZwD0k0AXGA6YKbmTa
	 MpGkCgMT2DNolDd3JoZoLvU+c3FahI3P0YJeFaSDq3I2Xk0RO7xiqrf+TO5Ljzfzdy
	 zBsIQJSeroTPWitnE1d0OIXPeX2/W0WokbpAAy6s=
Date: Tue, 1 Jul 2025 16:07:29 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Tomoya MORINAGA <tomoya-linux@dsn.okisemi.com>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v3] pch_uart: Fix dma_sync_sg_for_device() nents value
Message-ID: <2025070119-borrowing-smith-2e15@gregkh>
References: <20250701113452.18590-2-fourier.thomas@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701113452.18590-2-fourier.thomas@gmail.com>

On Tue, Jul 01, 2025 at 01:34:52PM +0200, Thomas Fourier wrote:
> The dma_sync_sg_for_device() functions should be called with the same
> nents as the dma_map_sg(), not the value the map function returned
> according to the documentation in Documentation/core-api/dma-api.rst:450:
> 	With the sync_sg API, all the parameters must be the same
> 	as those passed into the sg mapping API.
> 
> 
> Fixes: da3564ee027e ("pch_uart: add multi-scatter processing")
> Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
> ---
> 
> v2 -> v3:
> 
> - Adding reference to documentation
> 
> v1 -> v2:
> 
> - Fixing value
> 
>  drivers/tty/serial/pch_uart.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/pch_uart.c b/drivers/tty/serial/pch_uart.c
> index 508e8c6f01d4..884fefbfd5a1 100644
> --- a/drivers/tty/serial/pch_uart.c
> +++ b/drivers/tty/serial/pch_uart.c
> @@ -954,7 +954,7 @@ static unsigned int dma_handle_tx(struct eg20t_port *priv)
>  			__func__);
>  		return 0;
>  	}
> -	dma_sync_sg_for_device(port->dev, priv->sg_tx_p, nent, DMA_TO_DEVICE);
> +	dma_sync_sg_for_device(port->dev, priv->sg_tx_p, num, DMA_TO_DEVICE);
>  	priv->desc_tx = desc;
>  	desc->callback = pch_dma_tx_complete;
>  	desc->callback_param = priv;
> -- 
> 2.43.0
> 
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

- You have marked a patch with a "Fixes:" tag for a commit that is in an
  older released kernel, yet you do not have a cc: stable line in the
  signed-off-by area at all, which means that the patch will not be
  applied to any older kernel releases.  To properly fix this, please
  follow the documented rules in the
  Documentation/process/stable-kernel-rules.rst file for how to resolve
  this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
