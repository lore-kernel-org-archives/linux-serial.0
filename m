Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2E2283C91;
	Mon, 30 Jun 2025 11:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751284113; cv=none; b=ZfKAgwz00y+opqXbfOFMFZmPoIVbh5ezdWG7659SB78v54bLw+ZCV7LrIh4PXs/Na63lIn87uNZairurC5yhGqF+VJz7V0USUmc261qF2gAI/8ffxjpGXTEbfozPydD/U5UUUEuwK8dn6hfg4+YHlMuXV07x0zZuTVFz3lQUxFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751284113; c=relaxed/simple;
	bh=ZLG+dfOp6gCCqsb2hqq71Os2R1FhzXb6eRkDh54XICc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UjXpUlVNtsQik89dH9JmuFhConFsSzVrmANu9AUpcJrLMtKozR7TUfio5geyfgX6ggS32afCq0tGomkgx5KGyOAJE7ilQL5MNIoQNh68crzFN4pPZYWB018kfySYen8bUsB6HmFpJ2oHS8w+hdPNS7WzCq0F7sxt/zo2+gplV5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QYPs8D0k; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QYPs8D0k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBC37C4CEF4;
	Mon, 30 Jun 2025 11:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751284112;
	bh=ZLG+dfOp6gCCqsb2hqq71Os2R1FhzXb6eRkDh54XICc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QYPs8D0kJufNgRQIIqXGQVQaWwgfrYg1xu/IGpmSo+msKFNkKp2kyfCwyk1vomDHY
	 QRGOkDY8bs/7vIDmLsJpqlw1I0YSkubfn7LDdBLsPsbQU5fnXqD1VtjnxuO1T68BFC
	 8io2+247xI3wkMG6BbmvXumUq24/+Sp5+ebJSBTs=
Date: Mon, 30 Jun 2025 13:48:29 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Tomoya MORINAGA <tomoya-linux@dsn.okisemi.com>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] pch_uart: Fix dma_sync_sg_for_device() nents value
Message-ID: <2025063019-unpadded-gradient-7f61@gregkh>
References: <20250630114124.102326-2-fourier.thomas@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630114124.102326-2-fourier.thomas@gmail.com>

On Mon, Jun 30, 2025 at 01:41:21PM +0200, Thomas Fourier wrote:
> The dma_sync_sg_for_device() functions should be called with the same
> nents as the dma_map_sg(), not the value the map function returned.
> 
> Fixes: da3564ee027e ("pch_uart: add multi-scatter processing")
> Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
> ---
>  drivers/tty/serial/pch_uart.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/pch_uart.c b/drivers/tty/serial/pch_uart.c
> index 508e8c6f01d4..5aee3fdba8a1 100644
> --- a/drivers/tty/serial/pch_uart.c
> +++ b/drivers/tty/serial/pch_uart.c
> @@ -954,7 +954,7 @@ static unsigned int dma_handle_tx(struct eg20t_port *priv)
>  			__func__);
>  		return 0;
>  	}
> -	dma_sync_sg_for_device(port->dev, priv->sg_tx_p, nent, DMA_TO_DEVICE);
> +	dma_sync_sg_for_device(port->dev, priv->sg_tx_p, priv->nent, DMA_TO_DEVICE);
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
