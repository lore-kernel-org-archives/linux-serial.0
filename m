Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76B81A5B91;
	Thu,  3 Apr 2025 06:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743663041; cv=none; b=llZ422bqeFFBsq4sa4czonI9OshmaUCFxZ0s97Rswmq6pjt0kHDmdU0PickenzP1Fnh0A0b5e5Bi4IxydGsGKwIpJEyMibwoLXinhFavCKQ8HrvDCafsJeq+wLn9kj2AyT6UkjwX8mpegGIR258x42MCChhS3y/9xA0zKuXOXRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743663041; c=relaxed/simple;
	bh=Jh/rY+EfIjSo98Z/ve5BziCFk7Rx6+VKfxCcaVbDtEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rFd13bvK3E2ARUJ9SlhQfs++Tn3bIKsFldIGp8aXJnNW4a2jMGiWgJ7EE6ez7QSLUxtnTkrPKNkWidniip7SzVEdqJyfJTUCjVUxVzM2CV3kSNrpO2UnSCilYA0yW13LfNQtue0SLuJ4G6Q6yhAl5041ECnEBeKdV38YIkjXW7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fCYukXs5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fCYukXs5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C66E5C4CEE8;
	Thu,  3 Apr 2025 06:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1743663040;
	bh=Jh/rY+EfIjSo98Z/ve5BziCFk7Rx6+VKfxCcaVbDtEs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fCYukXs5RtwOJrW0aHvACYhB+w3VtDovh0h0XSAhtrAwlJkHFzQeCCHaQraayIh3I
	 dHdEbfeqNFPw1YeIa6iNSkmi8yws9CsIqRuoBjddeX78VdjQpufEHWDCXbxm0J1WD3
	 2h82qoGnao1EdRCrUrGeUG54x30CxU0kNJqj5Dxo=
Date: Thu, 3 Apr 2025 07:49:13 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Henry Martin <bsdhenrymartin@gmail.com>
Cc: jirislaby@kernel.org, sugaya.taichi@socionext.com,
	orito.takao@socionext.com, u.kleine-koenig@baylibre.com,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1] serial: Fix null-ptr-deref in mlb_usio_probe()
Message-ID: <2025040301-unmanned-lapdog-5446@gregkh>
References: <20250403062808.63428-1-bsdhenrymartin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250403062808.63428-1-bsdhenrymartin@gmail.com>

On Thu, Apr 03, 2025 at 02:28:08PM +0800, Henry Martin wrote:
> devm_ioremap() returns NULL on error. Currently, mlb_usio_probe() does
> not check for this case, which results in a NULL pointer dereference.
> 
> Add NULL check after devm_ioremap() to prevent this issue.
> 
> Fixes: ba44dc043004 ("serial: Add Milbeaut serial control")
> Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
> ---
>  drivers/tty/serial/milbeaut_usio.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/milbeaut_usio.c b/drivers/tty/serial/milbeaut_usio.c
> index 059bea18dbab..4e47dca2c4ed 100644
> --- a/drivers/tty/serial/milbeaut_usio.c
> +++ b/drivers/tty/serial/milbeaut_usio.c
> @@ -523,7 +523,10 @@ static int mlb_usio_probe(struct platform_device *pdev)
>  	}
>  	port->membase = devm_ioremap(&pdev->dev, res->start,
>  				resource_size(res));
> -
> +	if (!port->membase) {
> +		ret = -ENOMEM;
> +		goto failed;
> +	}
>  	ret = platform_get_irq_byname(pdev, "rx");
>  	mlb_usio_irq[index][RX] = ret;
>  
> -- 
> 2.34.1
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
