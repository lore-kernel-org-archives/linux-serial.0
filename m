Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4B55A0EA
	for <linux-serial@vger.kernel.org>; Tue, 20 Feb 2024 06:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708412011; cv=none; b=QiokxGZDkczN9cEhqrlznWPnXVlRUoPisa4sqmzfGfTjru9VvvCUxg63XMROCKCTZL1e85W30VPrzdlv8jdemsgDFfY0NWqs3Ak13qfAIja0kEpotsyi98y9w0VIwMBdgKqJJAAnpDwr4z0xzxz2/CEWyHNIdKVyZ05DrkXlZHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708412011; c=relaxed/simple;
	bh=/eMB2ICS65XOPkzKeI3yiZVejPXNTj61WnBTKNQt0oc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VEWif+jOTFxsIl4FUtoBxm0J2c5GogV5BwFYrct2eP6Ep5FajP7ZxlPFnjvZMGLnBh8U9XxnDBBQEinkUswrUMdwQFAh4E5Qx8anOGlBYnO+Ap0Fxvz/uWP45Jpd2xrXhvDHh5ExIm/Tqyar6vkaxWnRxTj7YWQYkk4K1/T+CcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gQHZQemP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gQHZQemP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29052C433C7;
	Tue, 20 Feb 2024 06:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708412010;
	bh=/eMB2ICS65XOPkzKeI3yiZVejPXNTj61WnBTKNQt0oc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gQHZQemPA3sRnWagSyWc62lrmT98LpTIRKU0bVWlPmREFlFRLWWdHbiaPtG4viaya
	 mNPmJoyFkbv8bwGZ+YU+4nbmmkl6Ui8/bALrAsFoZ34JU85S33+iYtufS/XfFIBFRE
	 Fav0cBVL47D5ydyBIYMN3Q/a14VDN2wefPn2/Lo8=
Date: Tue, 20 Feb 2024 07:53:27 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Rickard Andersson <rickaran@axis.com>
Cc: linux-serial@vger.kernel.org, rickard314.andersson@gmail.com,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, linux-imx@nxp.com, martin.fuzzey@flowbird.group,
	marex@denx.de, kernel@axis.com
Subject: Re: [PATCH v2] tty: serial: imx: Fix broken RS485
Message-ID: <2024022009-childcare-scorch-07a7@gregkh>
References: <20240220061243.4169045-1-rickaran@axis.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220061243.4169045-1-rickaran@axis.com>

On Tue, Feb 20, 2024 at 07:12:43AM +0100, Rickard Andersson wrote:
> From: Rickard x Andersson <rickaran@axis.com>
> 
> When about to transmit the function imx_uart_start_tx is called and in
> some RS485 configurations this function will call imx_uart_stop_rx. The
> problem is that imx_uart_stop_rx will enable loopback and when loopback
> is enabled transmitted data will just be looped to RX.
> 
> This patch fixes the above problem by explicitly disabling loopback in
> the case described above.
> 
> Fixes: 79d0224f6bf2 ("tty: serial: imx: Handle RS485 DE signal active high")
> Signed-off-by: Rickard x Andersson <rickaran@axis.com>
> ---
>  drivers/tty/serial/imx.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

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

- You sent a patch that has been sent multiple times in the past few
  days, and is identical to ones that has been recently rejected.
  Please always look at the mailing list traffic to determine if you are
  duplicating other people's work.

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
