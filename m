Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB29261B80;
	Tue, 19 Aug 2025 11:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755602980; cv=none; b=BcVjUTRiGRBy6ERetbLar2Gaoxi3RTP4D1h9I7bTZbndVKt/DPpfHE7NqymL1HT3ayhYinLSVYKrisI4V3PU29FU7GAc7Gma/t4MJE73lwmMFffBKkmhw4Zlc3iP+e6ry1isqX9wO3fKGdHhFBuHgeNmbl8QB8ykiPZ4rEbyISs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755602980; c=relaxed/simple;
	bh=iQ4OZmwK5U3UpY/eh7oHTtmmrNhpa9VKZe6ZSMq4W+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UWi95I/mhSP7dueSOpAuO/fKN1dC0R+8fAf1IxY4+XdUL+a88gIJ7UQpbdgkzSlYuE7rzZi6rhQPMLhMJjI4KvO6awwbPP36AdsHvLoT9ZATwoqyGZR60unEfnn7NrUr6rx7AhNExF1oidIsGZhlsrodx95cOx7DpGcznYpcsLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Afv2126t; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Afv2126t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 217DAC4CEF1;
	Tue, 19 Aug 2025 11:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755602978;
	bh=iQ4OZmwK5U3UpY/eh7oHTtmmrNhpa9VKZe6ZSMq4W+U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Afv2126t1A0RneG1z0NhbV7iHyXyFT/ntt39IybsFiy0BWy4VS6jvPpk/vdEyug3O
	 /mZAUzEaSF1X+tEHNuNwXMyfQGCRyw7mN49HUh6wf3jKRorS2O7EsCDOm2bSHFg0xf
	 F9Sst5K4RnHJDiVVdL3F+boZkSpAF06Yg8z5RVPY=
Date: Tue, 19 Aug 2025 13:29:35 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Xichao Zhao <zhao.xichao@vivo.com>
Cc: jirislaby@kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH v2] tty: serial: Replace -ENOMEM with -ENOSPC
Message-ID: <2025081923-trend-ravine-ab63@gregkh>
References: <20250819111524.584405-1-zhao.xichao@vivo.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819111524.584405-1-zhao.xichao@vivo.com>

On Tue, Aug 19, 2025 at 07:15:24PM +0800, Xichao Zhao wrote:
> The dev_err_probe() doesn't do anything when error is '-ENOMEM'.
> And using -ENOSPC here is more appropriate. So replace -ENOMEM
> with -ENOSPC.
> 
> Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
> ---
>  drivers/tty/serial/max3100.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/max3100.c b/drivers/tty/serial/max3100.c
> index 67d80f8f801e..3faa1b6aa3ee 100644
> --- a/drivers/tty/serial/max3100.c
> +++ b/drivers/tty/serial/max3100.c
> @@ -705,7 +705,7 @@ static int max3100_probe(struct spi_device *spi)
>  			break;
>  	if (i == MAX_MAX3100) {
>  		mutex_unlock(&max3100s_lock);
> -		return dev_err_probe(dev, -ENOMEM, "too many MAX3100 chips\n");
> +		return dev_err_probe(dev, -ENOSPC, "too many MAX3100 chips\n");
>  	}
>  
>  	max3100s[i] = kzalloc(sizeof(struct max3100_port), GFP_KERNEL);
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
