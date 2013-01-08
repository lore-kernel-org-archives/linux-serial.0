From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH] serial: mxs-auart: Index is unsigned
Date: Tue, 8 Jan 2013 07:58:04 +0100
Message-ID: <201301080758.05051.marex@denx.de>
References: <1357607466-20358-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:54497 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751393Ab3AHG6H (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 8 Jan 2013 01:58:07 -0500
In-Reply-To: <1357607466-20358-1-git-send-email-festevam@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: alan@linux.intel.com, shawn.guo@linaro.org, linux-serial@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

Dear Fabio Estevam,

> From: Fabio Estevam <fabio.estevam@freescale.com>>
> 
> Fix the following warning when building with W=1 option:
> 
> drivers/tty/serial/mxs-auart.c: In function 'mxs_auart_tx_chars':
> drivers/tty/serial/mxs-auart.c:272:10: warning: comparison between signed
> and unsigned integer expressions [-Wsign-compare]
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Acked-by: Marek Vasut <marex@denx.de>

> ---
>  drivers/tty/serial/mxs-auart.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/mxs-auart.c
> b/drivers/tty/serial/mxs-auart.c index 6db23b0..537e0af 100644
> --- a/drivers/tty/serial/mxs-auart.c
> +++ b/drivers/tty/serial/mxs-auart.c
> @@ -253,7 +253,7 @@ static void mxs_auart_tx_chars(struct mxs_auart_port
> *s) struct circ_buf *xmit = &s->port.state->xmit;
> 
>  	if (auart_dma_enabled(s)) {
> -		int i = 0;
> +		u32 i = 0;
>  		int size;
>  		void *buffer = s->tx_dma_buf;

Best regards,
Marek Vasut
