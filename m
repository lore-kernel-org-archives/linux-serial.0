From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] Add sc16is7x2 driver
Date: Tue, 21 Sep 2010 13:42:38 -0700
Message-ID: <20100921204238.GE25112@kroah.com>
References: <4C80F419.5070601@iis.fraunhofer.de>
 <20100913172544.a81e8422.akpm@linux-foundation.org>
 <4C8F7381.50300@iis.fraunhofer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:39884 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754407Ab0IUUrq (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 21 Sep 2010 16:47:46 -0400
Content-Disposition: inline
In-Reply-To: <4C8F7381.50300@iis.fraunhofer.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

On Tue, Sep 14, 2010 at 03:07:13PM +0200, Manuel Stahl wrote:
> --- a/include/linux/serial_core.h
> +++ b/include/linux/serial_core.h
> @@ -47,6 +47,9 @@
>  #define PORT_U6_16550A	19	/* ST-Ericsson U6xxx internal UART */
>  #define PORT_MAX_8250	19	/* max port ID */
>  
> +/* SC16IS7x2 SPI UART */
> +#define PORT_SC16IS7X2	19

Hm, didn't you just duplicate the number here?  Shouldn't that be "20"
and you bump the max up?

In the end, we need to just drop those, I don't think we need defines
anymore, but I need to look at it some more to find out.

thanks,

greg k-h
