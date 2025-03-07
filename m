Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F01F7346F;
	Fri,  7 Mar 2025 06:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741330775; cv=none; b=UzG8yNzRHy67Q4udGzoXBZ8+ip/HG//TxEVeGNQ76/Jag4HOvhJv9BHPNOoE/IAe0QN0VxIlAIy2trX+KGzBhVFpCa7Eq31kXr9t+YkBoJ6C/cgir4KHjH3Tmqb/2X0V4tE8ahH6RGCsdaccAIOLVdtBNEI1tF2DAAn1yTkEcl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741330775; c=relaxed/simple;
	bh=0PBL0VFDxdx8N7YeUikHBNJ/ULAH10Yn+J6F9Dd5bMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fYgqgKuy/+7luSxW+dpzCIgcBOjox56tFLwaogDftbw3AsB5XH+NXL2emmg0v3beA5RzE8hp+xfwfVGoT+rgq+ZQk7BdauEyrRIACy9/oDeJU6ALTV+3C1h+82q5tUzQm5wEO7tDdDJI/siwiwym5wIu6/97qkS3Pbl1MZ3j3Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GSytPwV4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GSytPwV4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07B51C4CED1;
	Fri,  7 Mar 2025 06:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741330773;
	bh=0PBL0VFDxdx8N7YeUikHBNJ/ULAH10Yn+J6F9Dd5bMk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GSytPwV4H72JLlDgmZ3LeRIOj759VJsVDUYnGnTVOcGah6wR0U8kCSXAYCmFGydfe
	 wFx/5q6+bOMK8wUgmEaNMeKAgFXDUj1ysCtki0DWe5y4/b252csYj6d5+rd0yov70t
	 ohzSu1qsrqz3N7Vt5uTjQslKQCrU4XZTsqQk2ZyQ=
Date: Fri, 7 Mar 2025 07:58:18 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Sherry Sun <sherry.sun@nxp.com>
Cc: jirislaby@kernel.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	shenwei.wang@nxp.com
Subject: Re: [PATCH] tty: serial: lpuart: only disable CTS instead of
 overwriting the whole UARTMODIR register
Message-ID: <2025030705-carrousel-hamstring-81c6@gregkh>
References: <20250307065446.1122482-1-sherry.sun@nxp.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307065446.1122482-1-sherry.sun@nxp.com>

On Fri, Mar 07, 2025 at 02:54:46PM +0800, Sherry Sun wrote:
> No need to overwrite the whole UARTMODIR register before waiting the
> transmit engine complete, actually our target here is only to disable
> CTS flow control to avoid the dirty data in TX FIFO may block the
> transmit engine complete.
> Also delete the following duplicate CTS disable configuration.
> 
> Fixes: d5a2e0834364 ("tty: serial: lpuart: disable flow control while waiting for the transmit engine to complete")
> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> ---
>  drivers/tty/serial/fsl_lpuart.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)

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
