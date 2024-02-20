Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BBE376E2
	for <linux-serial@vger.kernel.org>; Tue, 20 Feb 2024 06:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708412031; cv=none; b=tln0MG4/NuSyw1XXYa/XimFamSy9FvYAL7g7Xa2zu8a8rdkA+8b+CNKNBWyTV8ieAxAgldf8thIgOoXVADzQauMPKE1HU7l0Z3AOLjhmMDNwJVW0FRDiavLzB6WZ9XPgitFpoPl8/ifItQokDzJ1NpQ521BCNhSbRfVN8mARB2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708412031; c=relaxed/simple;
	bh=Rv9imuCnQz+g2pewQGDgwWrudq48cUMcplM4LJ5K/Ck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uU3pHpxozYDt3v+o1DrFLVDOwbNpV7p3HCeq9o14gbEhEuMXDN/kBNASGkGyXAIrL2T6t/VC4ArHKsVjPxhIaK4O7ol9/OJLouODO4GQXHIRLbm+0A28R6Hd3CpLUlFmgrZmr/k47CNjAV7YpPG4Gr2ZiP2QaQGKMnDyttkONrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xbb7UEuV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xbb7UEuV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0634EC433C7;
	Tue, 20 Feb 2024 06:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708412030;
	bh=Rv9imuCnQz+g2pewQGDgwWrudq48cUMcplM4LJ5K/Ck=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xbb7UEuVcm4Vv+VRJ+1gDzW4mFiHRmpLIHZiJ7l4EOneLanwHPYUVErLvDTT1nLoJ
	 9vA680bcUNZWmE02jdmZZ+y8MsgiMUFM2qSEpqc48UXfSRIh7N0Wajpk8mxrKSy36G
	 6/X3q0AQlNdXrRpVXSVxIs3sbV+FpauJrNTGTvBg=
Date: Tue, 20 Feb 2024 07:53:46 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Rickard Andersson <rickaran@axis.com>
Cc: linux-serial@vger.kernel.org, rickard314.andersson@gmail.com,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, linux-imx@nxp.com, martin.fuzzey@flowbird.group,
	marex@denx.de, kernel@axis.com
Subject: Re: [PATCH v2] tty: serial: imx: Fix broken RS485
Message-ID: <2024022038-colonize-squeegee-bae9@gregkh>
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
> 
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 4aa72d5aeafb..899e331bdfc8 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -683,8 +683,15 @@ static void imx_uart_start_tx(struct uart_port *port)
>  			imx_uart_writel(sport, ucr2, UCR2);
>  
>  			if (!(port->rs485.flags & SER_RS485_RX_DURING_TX) &&
> -			    !port->rs485_rx_during_tx_gpio)
> +			    !port->rs485_rx_during_tx_gpio) {
>  				imx_uart_stop_rx(port);
> +				/*
> +				 * The function imx_uart_stop_rx right above
> +				 * will enable loopback, but since we are just
> +				 * about to transmit then disable loopback.
> +				 */
> +				imx_uart_disable_loopback_rs485(sport);
> +			}
>  
>  			sport->tx_state = WAIT_AFTER_RTS;
>  
> -- 
> 2.30.2
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
