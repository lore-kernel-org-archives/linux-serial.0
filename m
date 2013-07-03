From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 1/5] serial: imx: distinguish the imx6 uart from the
 others
Date: Wed, 3 Jul 2013 09:52:45 +0800
Message-ID: <20130703015243.GD9145@S2101-09.ap.freescale.net>
References: <1372746628-20092-1-git-send-email-b32955@freescale.com>
 <1372746628-20092-2-git-send-email-b32955@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from co9ehsobe001.messaging.microsoft.com ([207.46.163.24]:38337
	"EHLO co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752198Ab3GCBwV (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 2 Jul 2013 21:52:21 -0400
Content-Disposition: inline
In-Reply-To: <1372746628-20092-2-git-send-email-b32955@freescale.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Huang Shijie <b32955@freescale.com>
Cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, s.hauer@pengutronix.de

On Tue, Jul 02, 2013 at 02:30:24PM +0800, Huang Shijie wrote:
> @@ -801,7 +814,7 @@ static int imx_startup(struct uart_port *port)
>  		}
>  	}
>  
> -	if (is_imx21_uart(sport)) {
> +	if (is_imx21_uart(sport) || is_imx6_uart(sport)) {

Would it be better to use (!is_imx1_uart(sport)) here?  Thus when there
is another derivative of imx21-uart device to be added, we do not need
to touch this line again.

Shawn

>  		temp = readl(sport->port.membase + UCR3);
>  		temp |= IMX21_UCR3_RXDMUXSEL;
>  		writel(temp, sport->port.membase + UCR3);

