Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B349F258CE5;
	Tue, 12 May 2026 07:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778571504; cv=none; b=h63t0PpwXur7W4IFjq74XcImZr+1OIluDoZV0ItazWUMMm5u2JAzBFJrS+ABKUpqTd4nP9YbB7/OBuCXRTTLfqTgME3Ix7dXZhEkM5f4cMDFNZ3xN19AqaF4NlxeWeK1fKUro6W4chw4FicVVfKeaqzfnjyMbAogEYoCxDZjjH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778571504; c=relaxed/simple;
	bh=Jv9TaO2hjTbCqZRz8ettFr/wuhIOEDMTUYhHzvA0e0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lAdNj50t/CJPWHc78QkJO2d2fRbjDGkChzXv5VJQnuIyfjZcfV6puNGOSXHEt51ZlQfhFBjGYgKIYwQRP5qqxbUQYEewhFJlWM7xOH9NxBrOQhVSD1+ECtWjGsdT6bRYXTyivSe1A3/iQVazRbT4BcTFXjEMHWMyoov5taSXV9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fpU3TJ5F; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fpU3TJ5F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAF9BC2BCB0;
	Tue, 12 May 2026 07:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778571504;
	bh=Jv9TaO2hjTbCqZRz8ettFr/wuhIOEDMTUYhHzvA0e0U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fpU3TJ5FZTBVUBfkMFFM9BHUYHUUUX+RmuvcYsrc5lp8O5QM7bc8vC/upYuo6DiSV
	 DPGlPS75A76Yxb8QbqgBEO2iRpL1fzkCWo04QXT4kpUzHr8QbZDA1IXEWNXappogft
	 uKXzedgzXHS0S6Q95menZl2lKOi8pTIuI5o31lOA=
Date: Tue, 12 May 2026 09:38:21 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
Cc: linux-kernel@vger.kernel.org, git@amd.com, shubhrajyoti.datta@gmail.com,
	Jiri Slaby <jirislaby@kernel.org>,
	Michal Simek <michal.simek@amd.com>, linux-serial@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [LINUX PATCH] serial: xilinx_uartps: fix runtime PM race during
 probe
Message-ID: <2026051211-ladylike-dormitory-76b6@gregkh>
References: <176bdb50948e99c40f8baaeaac9ffc5eaf10816f.1778567817.git.shubhrajyoti.datta@amd.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176bdb50948e99c40f8baaeaac9ffc5eaf10816f.1778567817.git.shubhrajyoti.datta@amd.com>

On Tue, May 12, 2026 at 12:11:33PM +0530, Shubhrajyoti Datta wrote:
> pm_runtime_enable() was called with usage_count=0, allowing the PM
> core to immediately queue a deferred suspend via pm_runtime_work.
> This raced with console write, causing cdns_runtime_suspend to
> fire before the port was fully registered.
> 
> Hold a reference with pm_runtime_get_noresume() before enabling
> runtime PM.
> 
> Fixes: d62100f1aac2 ("serial: xilinx_uartps: Add pm runtime support")
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
> ---
>  drivers/tty/serial/xilinx_uartps.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
> index a072b75dbaf2..e316cac4f35b 100644
> --- a/drivers/tty/serial/xilinx_uartps.c
> +++ b/drivers/tty/serial/xilinx_uartps.c
> @@ -1800,6 +1800,7 @@ static int cdns_uart_probe(struct platform_device *pdev)
>  	pm_runtime_use_autosuspend(&pdev->dev);
>  	pm_runtime_set_autosuspend_delay(&pdev->dev, UART_AUTOSUSPEND_TIMEOUT);
>  	pm_runtime_set_active(&pdev->dev);
> +	pm_runtime_get_noresume(&pdev->dev);
>  	pm_runtime_enable(&pdev->dev);
>  	device_init_wakeup(port->dev, true);
>  
> @@ -1824,6 +1825,8 @@ static int cdns_uart_probe(struct platform_device *pdev)
>  			"uart_add_one_port() failed; err=%i\n", rc);
>  		goto err_out_pm_disable;
>  	}
> +	pm_runtime_mark_last_busy(&pdev->dev);
> +	pm_runtime_put_autosuspend(&pdev->dev);
>  
>  #ifdef CONFIG_SERIAL_XILINX_PS_UART_CONSOLE
>  	/* This is not port which is used for console that's why clean it up */
> @@ -1842,6 +1845,7 @@ static int cdns_uart_probe(struct platform_device *pdev)
>  	return 0;
>  
>  err_out_pm_disable:
> +	pm_runtime_put_noidle(&pdev->dev);
>  	pm_runtime_disable(&pdev->dev);
>  	pm_runtime_set_suspended(&pdev->dev);
>  	pm_runtime_dont_use_autosuspend(&pdev->dev);
> -- 
> 2.49.1
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
