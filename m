From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH V2 1/2] serial: sh-sci: Fix cast warning
Date: Mon, 10 Feb 2014 14:15:23 +0100
Message-ID: <2819790.IHlWH9aZoh@avalon>
References: <000001cf220d$1fd2ed70$5f78c850$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:39308 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752206AbaBJNOW (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 10 Feb 2014 08:14:22 -0500
In-Reply-To: <000001cf220d$1fd2ed70$5f78c850$%han@samsung.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jingoo Han <jg1.han@samsung.com>, 'Simon Horman' <horms+renesas@verge.net.au>
Cc: 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org

Hi Jingoo,

Thank you for the patch.

On Wednesday 05 February 2014 09:56:37 Jingoo Han wrote:
> Fix the following compile warning about cast to pointer from
> integer of different size.
> 
> drivers/tty/serial/sh-sci.c:2021:19: warning: cast to pointer from integer
> of different size [-Wint-to-pointer-cast]
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Simon, Greg, how do you plan to handle sh-sci patches for v3.15 ?

> ---
> Changes since V1:
> - Use uintptr_t instead of unsigned long per Laurent Pinchart
> 
>  drivers/tty/serial/sh-sci.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
> index be33d2b..1668523 100644
> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
> @@ -2018,7 +2018,7 @@ static int sci_remap_port(struct uart_port *port)
>  		 * need to do any remapping, just cast the cookie
>  		 * directly.
>  		 */
> -		port->membase = (void __iomem *)port->mapbase;
> +		port->membase = (void __iomem *)(uintptr_t)port->mapbase;
>  	}
> 
>  	return 0;

-- 
Regards,

Laurent Pinchart

