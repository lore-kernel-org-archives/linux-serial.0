Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC01713C90A;
	Wed, 13 Nov 2024 05:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731475913; cv=none; b=Gy9PPpzyo7ZYyvH8WZ5EzmADJERfnEDpimkac9BMkFLpVVxhqcugqQ0/rXqqhgZXmkgGXZh3hzrQhUExMS6d4ItQEN+8Zly8LCy9Eqspzapvx2JE1lVEfXmRVwS+Pb2h/Mp7wxjZns/SVJ3DCal0UmkguAQz1YhsYeOAcLjZGh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731475913; c=relaxed/simple;
	bh=nD4PMiCRrW7d72p1BT5XYYPetAcnUV83YaVcdEjJHfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tWgd7X61qGIoUyi6VpVGBb8wnuj9Umxc4MKXBr8XbzH/glkmBptItNZdLeyEUnKKuAPM3k7RZ5WffUT6U6aSAGwSI2+r/8Fix3MS/42X7zT4LA59FCB5qNb8PeyBF6mNx82HudSPGdAhhEfY2+zQa7o8vT3dqRhzyoQK0L7S4es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=a4MZMKyP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="a4MZMKyP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1B4AC4CECD;
	Wed, 13 Nov 2024 05:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731475912;
	bh=nD4PMiCRrW7d72p1BT5XYYPetAcnUV83YaVcdEjJHfo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a4MZMKyPAceGXYjBtG3wlL56WNj0S+GUy9b7uIFrKBMLFzwFqqCB5/PpfVnzmXfJh
	 aXQoRM3kzE7qp86AIY6nyKfH0nkx4ywAX3ebk4Y9gflYREqfjYGPd1Sk4icD4o/Xa+
	 tPkN9Gum+ZJq+4KSO39ii1ytitoiTmm/tleHRBK8=
Date: Wed, 13 Nov 2024 06:31:49 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Kartik <kkartik@nvidia.com>
Cc: linux@armlinux.org.uk, jirislaby@kernel.org, theo.lebrun@bootlin.com,
	linus.walleij@linaro.org, ilpo.jarvinen@linux.intel.com,
	l.sanfilippo@kunbus.com, konradybcio@kernel.org,
	christophe.jaillet@wanadoo.fr, arnd@arndb.de,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: amba-pl011: Fix RX stall when DMA is used
Message-ID: <2024111318-clang-chute-a7f4@gregkh>
References: <20241113051023.3125-1-kkartik@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113051023.3125-1-kkartik@nvidia.com>

On Wed, Nov 13, 2024 at 10:40:23AM +0530, Kartik wrote:
> Function pl011_throttle_rx() calls pl011_stop_rx() to disable RX, which
> also disables the RX DMA by clearing the RXDMAE bit of the DMACR
> register. However, to properly unthrottle RX when DMA is used, the
> function pl011_unthrottle_rx() is expected to set the RXDMAE bit of
> the DMACR register, which it currently lacks. This causes RX to stall
> after the throttle API is called.
> 
> Set RXDMAE bit in the DMACR register while unthrottling RX if RX DMA is
> used.
> 
> Fixes: 211565b10099 ("serial: pl011: UPSTAT_AUTORTS requires .throttle/unthrottle")
> Signed-off-by: Kartik <kkartik@nvidia.com>
> ---
>  drivers/tty/serial/amba-pl011.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
> index 4c4b0d470c65..f40714685166 100644
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c
> @@ -1819,6 +1819,11 @@ static void pl011_unthrottle_rx(struct uart_port *port)
>  
>  	pl011_write(uap->im, uap, REG_IMSC);
>  
> +	if (uap->using_rx_dma) {
> +		uap->dmacr |= UART011_RXDMAE;
> +		pl011_write(uap->dmacr, uap, REG_DMACR);
> +	}
> +
>  	uart_port_unlock_irqrestore(&uap->port, flags);
>  }
>  
> -- 
> 2.47.0
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

- It looks like you did not use your "real" name for the patch on either
  the Signed-off-by: line, or the From: line (both of which have to
  match).  Please read the kernel file,
  Documentation/process/submitting-patches.rst for how to do this
  correctly.

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
