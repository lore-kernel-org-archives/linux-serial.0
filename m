Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF282D6607;
	Sun, 19 Oct 2025 09:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760864425; cv=none; b=jFdLTq4IAc3QuA84KBHRAeS5MsSQrLjGNgJbX9Db9VPYyRBbuYh8zglBs118cbv2qAjqO9U2BAdQM4H7q3UVpee5k5quqOGYcYrAOnHgCDSbgyXFVRvdJ/NnKQon44T2V62+2Uo0ALxy8oc0J/olWui9Gspkiy3b8FSTGpQvPZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760864425; c=relaxed/simple;
	bh=vsRdO5x48n8Qsgha9Fa97rP+S0QIi7O6PlRofBpVoNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=to3DYGc3fgPRnmhGZHZx3ZkDsc1IO7rS+KSNPtaWY3lHEM8Qm4wLR87CqhQIcadXFuYpGAODSby+JzWpUvYwciFF71Gx9eDiW2dRMVTaPkuwUJH5kiJ6suALt93ySImhHYTYJaTNGov+bkkAQvdRdbl7fbLsTLHIOSbCG8IW4lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uJw1C6aA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uJw1C6aA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2497AC4CEE7;
	Sun, 19 Oct 2025 09:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760864424;
	bh=vsRdO5x48n8Qsgha9Fa97rP+S0QIi7O6PlRofBpVoNQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uJw1C6aAcqqCnRTkLxi9/njbbKvrR8oRb8EDsfb/zOfMQxKlHD+MdEvpIoAlBmi8C
	 4qLrPFB0nkiQ+komiwl6ltmf6ufBZQfBxArmxZkoX8ebEsvRwyoZSLqzAd6bdf5gAy
	 UK6fR0RkIjBeDrdvtrOQRmIYCkDQFv8vkt4QpKKI=
Date: Sun, 19 Oct 2025 11:00:21 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Artem Shimko <a.shimko.dev@gmail.com>
Cc: andriy.shevchenko@linux.intel.com, ilpo.jarvinen@linux.intel.com,
	jirislaby@kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, p.zabel@pengutronix.de
Subject: Re: [PATCH v2] serial: 8250_dw: handle reset control deassert error
Message-ID: <2025101902-puritan-thrift-b2d4@gregkh>
References: <aO_NYGFCKb0J2uqK@smile.fi.intel.com>
 <20251019085325.250657-1-a.shimko.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251019085325.250657-1-a.shimko.dev@gmail.com>

On Sun, Oct 19, 2025 at 11:53:25AM +0300, Artem Shimko wrote:
> Check the return value of reset_control_deassert() in the probe
> function to prevent continuing probe when reset deassertion fails.
> 
> Previously, reset_control_deassert() was called without checking its
> return value, which could lead to probe continuing even when the
> device reset wasn't properly deasserted.
> 
> The fix checks the return value and returns an error with dev_err_probe()
> if reset deassertion fails, providing better error handling and
> diagnostics.
> 
> Fixes: acbdad8dd1ab ("serial: 8250_dw: simplify optional reset handling")
> Signed-off-by: Artem Shimko <a.shimko.dev@gmail.com>
> ---
> Hi Andy,
> 
> Thank you for your review.
> 
> The v1 patch hasn't been applied.
> 
> I've addressed your comments in v2 - could you please take a look when you have time?
> 
> Best regards,
> Artem Shimko
> 
> ChangeLog:
>   v1:
>     * https://lore.kernel.org/all/20251009081309.2021600-1-a.shimko.dev@gmail.com/T/#u
>   v2:
>     * Add fix tag to commit description
> 
>  drivers/tty/serial/8250/8250_dw.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
> index a53ba04d9770..710ae4d40aec 100644
> --- a/drivers/tty/serial/8250/8250_dw.c
> +++ b/drivers/tty/serial/8250/8250_dw.c
> @@ -635,7 +635,9 @@ static int dw8250_probe(struct platform_device *pdev)
>  	if (IS_ERR(data->rst))
>  		return PTR_ERR(data->rst);
>  
> -	reset_control_deassert(data->rst);
> +	err = reset_control_deassert(data->rst);
> +	if (err)
> +		return dev_err_probe(dev, err, "failed to deassert resets\n");
>  
>  	err = devm_add_action_or_reset(dev, dw8250_reset_control_assert, data->rst);
>  	if (err)
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
