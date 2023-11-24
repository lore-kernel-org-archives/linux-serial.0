Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1864168B4
	for <linux-serial@vger.kernel.org>; Fri, 24 Nov 2023 12:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KLmvsSKX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B422C433CA;
	Fri, 24 Nov 2023 12:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700829936;
	bh=HRayAKSlzDs5i112aYEw5QttU3Neh5+nZmBU4rEPlww=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KLmvsSKXtRFmm6LnuDFzkymf7c+o1kIroc5WqidVhhHwaCbm2aWp6HJSLTd6Hrjbj
	 DjcE94go5kTPZVMJaATTGshD2VxZTDZWbG7AtAIATJZdGBNh5obzDdTk/ITbLr8BFJ
	 /Amp6nhB56Z+iMwWI0QniN8nRXD4J2wCQzwninnQ=
Date: Fri, 24 Nov 2023 12:45:34 +0000
From: Greg KH <gregkh@linuxfoundation.org>
To: Paul Geurts <paul_geurts@live.nl>
Cc: jirislaby@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
	u.kleine-koenig@pengutronix.de, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] serial: imx: fix tx statemachine deadlock
Message-ID: <2023112416-rind-gnat-cc80@gregkh>
References: <2023100450-charger-disregard-9683@gregkh>
 <AM0PR09MB26751EFD9552DE4ED1B150A795B8A@AM0PR09MB2675.eurprd09.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM0PR09MB26751EFD9552DE4ED1B150A795B8A@AM0PR09MB2675.eurprd09.prod.outlook.com>

On Fri, Nov 24, 2023 at 01:38:39PM +0100, Paul Geurts wrote:
> When using the serial port as RS485 port, the tx statemachine is used to
> control the RTS pin to drive the RS485 transceiver TX_EN pin. When the
> TTY port is closed in the middle of a transmission (for instance during
> userland application crash), imx_uart_shutdown disables the interface
> and disables the Transmission Complete interrupt. afer that,
> imx_uart_stop_tx bails on an incomplete transmission, to be retriggered
> by the TC interrupt. This interrupt is disabled and therefore the tx
> statemachine never transitions out of SEND. The statemachine is in
> deadlock now, and the TX_EN remains low, making the interface useless.
> 
> imx_uart_stop_tx now checks for incomplete transmission AND whether TC
> interrupts are enabled before bailing to be retriggered. This makes sure
> the state machine handling is reached, and is properly set to
> WAIT_AFTER_SEND.
> 
> Fixes: cb1a60923609 serial: imx: implement rts delaying for rs485
> 
> Signed-off-by: Paul Geurts <paul_geurts@live.nl>
> ---
>  drivers/tty/serial/imx.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 708b9852a575..ad36c49c7898 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -415,13 +415,13 @@ static void imx_uart_stop_tx(struct uart_port *port)
>  	ucr1 = imx_uart_readl(sport, UCR1);
>  	imx_uart_writel(sport, ucr1 & ~UCR1_TRDYEN, UCR1);
>  
> +	ucr4 = imx_uart_readl(sport, UCR4);
>  	usr2 = imx_uart_readl(sport, USR2);
> -	if (!(usr2 & USR2_TXDC)) {
> +	if ((!(usr2 & USR2_TXDC)) && (ucr4 & UCR4_TCEN)) {
>  		/* The shifter is still busy, so retry once TC triggers */
>  		return;
>  	}
>  
> -	ucr4 = imx_uart_readl(sport, UCR4);
>  	ucr4 &= ~UCR4_TCEN;
>  	imx_uart_writel(sport, ucr4, UCR4);
>  
> -- 
> 2.20.1
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
