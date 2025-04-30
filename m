Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886751684B4;
	Wed, 30 Apr 2025 16:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746031832; cv=none; b=mNxe/Z3ZWfCLKW7G7PSEFn3xmeSXRWd7kZTYjzGga08lsZmXIRGjarDTraRJfWa9wEMu9Nsn44DDmXLigJlSvFXfMrScMFhMPVxVbQkaCDf156FO+s278hm+ALzVanaaKv8Krwzm4QgwGgz+rrYKvXugb7S6hf9Zq+mYxFhvbqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746031832; c=relaxed/simple;
	bh=3jBXJepXjmNP4N+qbPKkMbvcmRppbo5YT1tvJ+K64KM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=swmgUZnOLAqJGBRaPDTByQNQgUar/MSldCR6ysPg0E2q5v2RhUuNW/2cswfvOo1hKQQMb9xlh4UEjSaIpKpOfmxeAc1ycWHNJrxWvPdXE9zdpkINSH01DKoVB7UTxUV3yNKKpK1d5LPTutCvPRus4SkWnM4C1qxiCYdenwTKAPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kRoxNmpo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kRoxNmpo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B264C4CEE7;
	Wed, 30 Apr 2025 16:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746031832;
	bh=3jBXJepXjmNP4N+qbPKkMbvcmRppbo5YT1tvJ+K64KM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kRoxNmpolNXQCpewDofh371vEBllwLrICu1EZ3g7Os1zhQ0t79tu6s71DDPPLfSXY
	 gEPoJlyxQicWM+oezkDBYq5mrBtfEYAAyCz2SRXQ34984Kxl50eIisWlMoAmFIMUCH
	 qNW2OOMvTxxL8I9JpoDZKjDK2NHY7kpHUhuNCEb8=
Date: Wed, 30 Apr 2025 18:50:28 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Mans Rullgard <mans@mansr.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH] tty: serial: 8250_omap: fix tx with dma
Message-ID: <2025043021-vintage-nearly-9048@gregkh>
References: <20250430163709.15850-1-mans@mansr.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250430163709.15850-1-mans@mansr.com>

On Wed, Apr 30, 2025 at 05:37:09PM +0100, Mans Rullgard wrote:
> Commit 1788cf6a91d9 ("tty: serial: switch from circ_buf to kfifo")
> introduced two errors in the TX DMA handling for 8250_omap.
> 
> Firstly, kfifo_dma_out_prepare_mapped() needs a scatterlist with two
> entries whereas only one is provided.  The same error was fixed for
> 8250_dma in 59449c9dbdaa ("tty: serial: 8250_dma: use sgl with 2 nents
> to take care of buffer wrap").
> 
> Secondly, when the OMAP_DMA_TX_KICK flag is set, one byte is pulled from
> the kfifo and emitted directly in order to start the DMA.  This is done
> without updating DMA tx_size which leads to uart_xmit_advance() called
> in the DMA complete callback advancing the kfifo by one too much.
> 
> In practice, transmitting N bytes has been seen to result in the last
> N-1 bytes being sent repeatedly.
> 
> This change fixes both problems.
> 
> Fixes: 1788cf6a91d9 ("tty: serial: switch from circ_buf to kfifo")
> Signed-off-by: Mans Rullgard <mans@mansr.com>
> ---
>  drivers/tty/serial/8250/8250_omap.c | 35 +++++++++++++++--------------
>  1 file changed, 18 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
> index f1aee915bc02..84a2f013015e 100644
> --- a/drivers/tty/serial/8250/8250_omap.c
> +++ b/drivers/tty/serial/8250/8250_omap.c
> @@ -1152,9 +1152,11 @@ static int omap_8250_tx_dma(struct uart_8250_port *p)
>  	struct omap8250_priv		*priv = p->port.private_data;
>  	struct tty_port			*tport = &p->port.state->port;
>  	struct dma_async_tx_descriptor	*desc;
> -	struct scatterlist sg;
> +	struct scatterlist *sg;
> +	struct scatterlist sgl[2];
>  	int skip_byte = -1;
>  	int ret;
> +	int i;
>  
>  	if (dma->tx_running)
>  		return 0;
> @@ -1173,16 +1175,6 @@ static int omap_8250_tx_dma(struct uart_8250_port *p)
>  		return 0;
>  	}
>  
> -	sg_init_table(&sg, 1);
> -	ret = kfifo_dma_out_prepare_mapped(&tport->xmit_fifo, &sg, 1,
> -					   UART_XMIT_SIZE, dma->tx_addr);
> -	if (ret != 1) {
> -		serial8250_clear_THRI(p);
> -		return 0;
> -	}
> -
> -	dma->tx_size = sg_dma_len(&sg);
> -
>  	if (priv->habit & OMAP_DMA_TX_KICK) {
>  		unsigned char c;
>  		u8 tx_lvl;
> @@ -1207,7 +1199,7 @@ static int omap_8250_tx_dma(struct uart_8250_port *p)
>  			ret = -EBUSY;
>  			goto err;
>  		}
> -		if (dma->tx_size < 4) {
> +		if (kfifo_len(&tport->xmit_fifo) < 4) {
>  			ret = -EINVAL;
>  			goto err;
>  		}
> @@ -1216,12 +1208,19 @@ static int omap_8250_tx_dma(struct uart_8250_port *p)
>  			goto err;
>  		}
>  		skip_byte = c;
> -		/* now we need to recompute due to kfifo_get */
> -		kfifo_dma_out_prepare_mapped(&tport->xmit_fifo, &sg, 1,
> -				UART_XMIT_SIZE, dma->tx_addr);
>  	}
>  
> -	desc = dmaengine_prep_slave_sg(dma->txchan, &sg, 1, DMA_MEM_TO_DEV,
> +	sg_init_table(sgl, ARRAY_SIZE(sgl));
> +
> +	ret = kfifo_dma_out_prepare_mapped(&tport->xmit_fifo, sgl, ARRAY_SIZE(sgl),
> +					   UART_XMIT_SIZE, dma->tx_addr);
> +
> +	dma->tx_size = 0;
> +
> +	for_each_sg(sgl, sg, ret, i)
> +		dma->tx_size += sg_dma_len(sg);
> +
> +	desc = dmaengine_prep_slave_sg(dma->txchan, sgl, ret, DMA_MEM_TO_DEV,
>  			DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
>  	if (!desc) {
>  		ret = -EBUSY;
> @@ -1248,8 +1247,10 @@ static int omap_8250_tx_dma(struct uart_8250_port *p)
>  err:
>  	dma->tx_err = 1;
>  out_skip:
> -	if (skip_byte >= 0)
> +	if (skip_byte >= 0) {
>  		serial_out(p, UART_TX, skip_byte);
> +		p->port.icount.tx++;
> +	}
>  	return ret;
>  }
>  
> -- 
> 2.49.0
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
