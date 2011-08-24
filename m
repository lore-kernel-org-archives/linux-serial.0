From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH] serial/imx: support to handle break character
Date: Wed, 24 Aug 2011 17:49:05 +0200
Message-ID: <20110824154905.GE31404@pengutronix.de>
References: <1314178907-20074-1-git-send-email-jason77.wang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38463 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751655Ab1HXPtH (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 24 Aug 2011 11:49:07 -0400
Content-Disposition: inline
In-Reply-To: <1314178907-20074-1-git-send-email-jason77.wang@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Hui Wang <jason77.wang@gmail.com>
Cc: gregkh@suse.de, alan@linux.intel.com, linux-serial@vger.kernel.org

On Wed, Aug 24, 2011 at 05:41:47PM +0800, Hui Wang wrote:
> The imx UART hardware controller can identify BREAK character and the
> imx_set_termios() can accept BRKINT set by users, but current existing
> imx_rxint() can't pass BREAK character and TTY_BREAK to the tty layer
> as other serial drivers do (8250.c omap_serial.c).
> 
> Here add code to handle BREAK character and pass it to tty layer.
> 
> To detect error occurrence, i use URXD_ERR to replace (URXD_OVRRUN |
> URXD_FRMERR | ...) because any kind of error occurs, URXD_ERR will
> always be set to 1.
> 
> I put the URXD_BRK to the first place to check since when BREAK error
> occurs, not only URXD_BRK is set to 1, but also URXD_PRERR and
> URXD_FRMERR are all set to 1. This arrangement can filter out fake
> parity and frame errors when BREAK error occurs.
> 
> Signed-off-by: Hui Wang <jason77.wang@gmail.com>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Alan Cox <alan@linux.intel.com>
> Cc: Greg Kroah-Hartman <gregkh@suse.de>

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

> ---
>  drivers/tty/serial/imx.c |   10 +++++++---
>  1 files changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 7e91b3d..54ffdc6 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -508,8 +508,10 @@ static irqreturn_t imx_rxint(int irq, void *dev_id)
>  		if (uart_handle_sysrq_char(&sport->port, (unsigned char)rx))
>  			continue;
>  
> -		if (rx & (URXD_PRERR | URXD_OVRRUN | URXD_FRMERR) ) {
> -			if (rx & URXD_PRERR)
> +		if (unlikely(rx & URXD_ERR)) {
> +			if (rx & URXD_BRK)
> +				sport->port.icount.brk++;
> +			else if (rx & URXD_PRERR)
>  				sport->port.icount.parity++;
>  			else if (rx & URXD_FRMERR)
>  				sport->port.icount.frame++;
> @@ -524,7 +526,9 @@ static irqreturn_t imx_rxint(int irq, void *dev_id)
>  
>  			rx &= sport->port.read_status_mask;
>  
> -			if (rx & URXD_PRERR)
> +			if (rx & URXD_BRK)
> +				flg = TTY_BREAK;
> +			else if (rx & URXD_PRERR)
>  				flg = TTY_PARITY;
>  			else if (rx & URXD_FRMERR)
>  				flg = TTY_FRAME;
> -- 
> 1.7.6
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
