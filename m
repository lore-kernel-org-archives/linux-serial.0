Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62282D54A1
	for <linux-serial@vger.kernel.org>; Tue,  6 May 2025 04:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746505736; cv=none; b=gfuYg6dmLzyBgN0aQmyO9RRzJT/wKYa0EXgCOORMhh8vnIgisPB4MVNUFwkizSQqAsBElm209VRvKCIZo00lYm2s051XvzJ8o01j9OyYjHaveij4IN+lUe/JeWW3JiYQsQ9UMYtXGaZ9UtHuKxwbcg1kk8RDiQ7gijI5JC1pC9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746505736; c=relaxed/simple;
	bh=uftm2dF8OowlBV4Ju7tMaN4CBLXn6dWungM8xjfXTRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QqZGHUu/7VFD5dN6G4402XVUpljjXeMZslmMAbghEeGbl1Sla1VMU2a8dperlDo3tuotIPpnTQ0FNRMiE2O/mfEOUgOgMj8ig6tmd6t2yzCzvbdN1a6XT+cLQatjwJhNeZVky+clvqJZCYRJJs14rLeHPLAElkVSI37OUZMSj2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2TF3H69N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2TF3H69N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B77E6C4CEE4;
	Tue,  6 May 2025 04:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746505736;
	bh=uftm2dF8OowlBV4Ju7tMaN4CBLXn6dWungM8xjfXTRw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2TF3H69ND1/whqwxRaNDQc3QItqEuQpjuqdIMo2/jzL/u7oNMLtZUXcH0s3Sj8eGK
	 y7WTRVyTPS9wH8MX3+EoKVTgFhn+rIVaMJZ0bIkVwbalVy68KK/LxrOi/nxmzju3Jy
	 WYSHUOcVUad6kFMtkADHZr/eMFeZ2U0VY3w0Js/c=
Date: Tue, 6 May 2025 06:27:12 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Dustin Lundquist <dustin@null-ptr.net>
Cc: linux-serial@vger.kernel.org, Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] serial: jsm: fix NPE during jsm_uart_port_init
Message-ID: <2025050657-banana-deduct-5c67@gregkh>
References: <613DBD1A-3BD8-45B9-BF90-75E907CBE859@null-ptr.net>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <613DBD1A-3BD8-45B9-BF90-75E907CBE859@null-ptr.net>

On Mon, May 05, 2025 at 11:18:34AM -0700, Dustin Lundquist wrote:
> No driver was set which caused serial_base_ctrl_add to crash.
> 
> Fixes: 84a9582fd203 ("serial: core: Start managing serial controllers to enable runtime PM")
> Signed-off-by: Dustin Lundquist <dustin@null-ptr.net>
> ---
> drivers/tty/serial/jsm/jsm_tty.c | 1 +
> 1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/tty/serial/jsm/jsm_tty.c b/drivers/tty/serial/jsm/jsm_tty.c
> index ce0fef7e2c66..be2f130696b3 100644
> --- a/drivers/tty/serial/jsm/jsm_tty.c
> +++ b/drivers/tty/serial/jsm/jsm_tty.c
> @@ -451,6 +451,7 @@ int jsm_uart_port_init(struct jsm_board *brd)
> 		if (!brd->channels[i])
> 			continue;
> 
> +		brd->channels[i]->uart_port.dev = &brd->pci_dev->dev;
> 		brd->channels[i]->uart_port.irq = brd->irq;
> 		brd->channels[i]->uart_port.uartclk = 14745600;
> 		brd->channels[i]->uart_port.type = PORT_JSM;
> -- 
> 2.47.2

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
