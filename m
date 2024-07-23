Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CCC315AAB1;
	Tue, 23 Jul 2024 18:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721758300; cv=none; b=TWIFlHM63c6BGJ3SsLyBUD2Fjmclcawjeq1Aa5/cud0ENLQvmRcdeePzsfZJGTUJ9t75XOEACtwNEwoW05VOIxdjY3wxg+92DsyOoQ3Ht82++SWeEF4+9y99pwwGycMn1P5AbndXNa2Vw+pGx75P6f1h3p/p44z1s+PhlIZS+y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721758300; c=relaxed/simple;
	bh=mtrrKId80+HnqOOJ5jNMS2oRckslL6kres5Xd43XQdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K52NqLlom4jgIGFBapPJsrnJdBwCiTQKplFCbO6cuMO/wcBa4whNgEAGB2jsxeLXeBeOqHDWtulXCgjKYphp7aSjERFU/2dGcL0RxXkKZPuzTuywZ93+LnKN2a3dHuLErRV8Hr8tcsJGF5tJ45vhG+5cj1YD7ypZiT5bWIsbIUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VXkLuc1H; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VXkLuc1H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 680C6C4AF11;
	Tue, 23 Jul 2024 18:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721758299;
	bh=mtrrKId80+HnqOOJ5jNMS2oRckslL6kres5Xd43XQdQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VXkLuc1HkXmk5VuIQU645YeZ0qvBoywcyeQe2zkJXaMkC6L9m1/b8Kf6xmF+O71Yv
	 HSOuOntdBXrNsKRGtvvTk7X2fPOOMSoYg16bFf592jrASM6UQdiN3aW+y4z7M0dEcq
	 bPbSvhhFvx6vhKL2C92Oc3m45bowaVSWcINh+kSc=
Date: Tue, 23 Jul 2024 20:11:37 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: James Minor <jminor1@opensource.cirrus.com>
Cc: shubhrajyoti.datta@amd.com, patches@opensource.cirrus.com,
	jirislaby@kernel.org, michal.simek@amd.com,
	linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] tty: xilinx_uartps: Fix break detection
Message-ID: <2024072322-saucy-silent-626f@gregkh>
References: <20240723142858.2905083-1-jminor1@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240723142858.2905083-1-jminor1@opensource.cirrus.com>

On Tue, Jul 23, 2024 at 02:28:58PM +0000, James Minor wrote:
> Commit b8a6c3b3d465 ("tty: xilinx_uartps: Fix the ignore_status")
> used read_status_mask to mask the isrstatus, even though the
> commit appears to be fixing the application of the
> ignore_status_mask.  This has a side effect of clearing any
> pending CDNS_UART_IXR_FRAMING bit, which in turn means that
> cdns_uart_handle_rx break detection will only process framing
> errors when parity is enabled (INPCK set via
> cdns_uart_set_termios).
> 
> Fix this by removing the extra isrstatus masking with
> read_status_mask, which still allows the ignore_status_mask to be
> applied.
> 
> Fixes: b8a6c3b3d465 ("tty: xilinx_uartps: Fix the ignore_status")
> Signed-off-by: James Minor <jminor1@opensource.cirrus.com>
> ---
> 
> The other alternative to this would be a straight revert of
> b8a6c3b3d465, since read_status_mask and ignore_status_mask are
> both applied in cnds_uart_handle_rx anyway.  Let me know the
> preference here and I will change accordingly.
> 
>  drivers/tty/serial/xilinx_uartps.c | 1 -
>  1 file changed, 1 deletion(-)

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
