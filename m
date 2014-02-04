From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 1/2] serial: sh-sci: Fix cast warning
Date: Tue, 04 Feb 2014 23:09:14 +0100
Message-ID: <1770030.4nuhDBK3mM@avalon>
References: <000501cf2176$1e733d00$5b59b700$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:53952 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935640AbaBDWIU (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 4 Feb 2014 17:08:20 -0500
In-Reply-To: <000501cf2176$1e733d00$5b59b700$%han@samsung.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jingoo Han <jg1.han@samsung.com>
Cc: 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, 'Laurent Pinchart' <laurent.pinchart+renesas@ideasonboard.com>, 'Simon Horman' <horms+renesas@verge.net.au>

Hi Jingoo,

Thank you for the patch.

On Tuesday 04 February 2014 15:55:41 Jingoo Han wrote:
> Fix the following compile warning about cast to pointer from
> integer of different size.
> 
> drivers/tty/serial/sh-sci.c:2021:19: warning: cast to pointer from integer
> of different size [-Wint-to-pointer-cast]
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---
>  drivers/tty/serial/sh-sci.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
> index be33d2b..61729d4 100644
> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
> @@ -2018,7 +2018,7 @@ static int sci_remap_port(struct uart_port *port)
>  		 * need to do any remapping, just cast the cookie
>  		 * directly.
>  		 */
> -		port->membase = (void __iomem *)port->mapbase;
> +		port->membase = (void __iomem *)(unsigned long)port->mapbase;

What about casting to uintptr_t instead of unsigned long ?

>  	}
> 
>  	return 0;

-- 
Regards,

Laurent Pinchart

