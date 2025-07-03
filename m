Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DF72F235D;
	Thu,  3 Jul 2025 18:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751568163; cv=none; b=psL9RrTKZEsls+pcGYAiXpt5/MJlYA4UoSXdP+0SJeA5smQ4RLwwZafNiKVKd3lW/9rCZ3TxZ8txuJmCtOm8hHBRFPSo5FgBn6ohZiphySzYQrYVZVfPzpsdwwhx7ONSQsbgWyFy/t+VgH3P5OokEX9jJnyBJlgSTz4IEbgmoR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751568163; c=relaxed/simple;
	bh=7axBr7rJL1+v/lcfDtk/VAEZMThHmwhbNXGb5WvBwfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FrYpIDizfEr0IXNm0uRSS+Ff+lNPFt1HhfczeQ7qXijdGP9fXOPUe95cFrCtQaD3TJFubcYw8sRJgnJOTdlepKrhoIezWoHq34vI1selBtKpiChfCWSwKE+JrY7dwFurVuW7ye3gxe9Jjotpw2aggIlirG6xD+HNf8HJG8n2nO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aaRTV7e3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aaRTV7e3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C113C4CEE3;
	Thu,  3 Jul 2025 18:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751568161;
	bh=7axBr7rJL1+v/lcfDtk/VAEZMThHmwhbNXGb5WvBwfc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aaRTV7e32mXWYnSuF0YTMGrRXnoqWC/9HCMZEz9voofslNpp4kdBCWUT2Fw4yCvy0
	 C+grdCMn9b++Cvk/2FInSINSY1+VTGjOH9dVoG5VKnEiw6aj86O7bjnCIXrX5P+pdr
	 L5S9b1jTUY+b21ENyIpR2BOyZ1jlDg3NeLS5reHA=
Date: Thu, 3 Jul 2025 20:42:38 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tty: jsm: fix misreading of "once in a while"
Message-ID: <2025070307-confirm-cataract-e859@gregkh>
References: <7qcs4vwj3pbv6e6neh73e3an432jgdhbyrtcbrsv3ntuoboh6d@tarta.nabijaczleweli.xyz>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7qcs4vwj3pbv6e6neh73e3an432jgdhbyrtcbrsv3ntuoboh6d@tarta.nabijaczleweli.xyz>

On Thu, Jul 03, 2025 at 08:21:25PM +0200, Ahelenia Ziemiańska wrote:
> Signed-off-by: Ahelenia Ziemiańska <nabijaczleweli@nabijaczleweli.xyz>
> ---
> v1: https://lore.kernel.org/lkml/h2ieddqja5jfrnuh3mvlxt6njrvp352t5rfzp2cvnrufop6tch@tarta.nabijaczleweli.xyz/t/#u
> 
>  drivers/tty/serial/jsm/jsm_neo.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/jsm/jsm_neo.c b/drivers/tty/serial/jsm/jsm_neo.c
> index e8e13bf056e2..2eb9ff26d6e8 100644
> --- a/drivers/tty/serial/jsm/jsm_neo.c
> +++ b/drivers/tty/serial/jsm/jsm_neo.c
> @@ -1189,7 +1189,7 @@ static irqreturn_t neo_intr(int irq, void *voidbrd)
>  			/*
>  			 * The UART triggered us with a bogus interrupt type.
>  			 * It appears the Exar chip, when REALLY bogged down, will throw
> -			 * these once and awhile.
> +			 * these periodically.
>  			 * Its harmless, just ignore it and move on.
>  			 */
>  			jsm_dbg(INTR, &brd->pci_dev,
> -- 
> 2.39.5


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

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/process/submitting-patches.rst for what is needed in
  order to properly describe the change.

- You did not write a descriptive Subject: for the patch, allowing Greg,
  and everyone else, to know what this patch is all about.  Please read
  the section entitled "The canonical patch format" in the kernel file,
  Documentation/process/submitting-patches.rst for what a proper
  Subject: line should look like.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
