From: Greg KH <greg@kroah.com>
Subject: Re: [patch 1/3] serial: add sc16is7x2 driver
Date: Wed, 6 Oct 2010 13:19:32 -0700
Message-ID: <20101006201932.GB26397@kroah.com>
References: <201010012118.o91LI3dx021213@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:46406 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755931Ab0JFUrp (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 6 Oct 2010 16:47:45 -0400
Content-Disposition: inline
In-Reply-To: <201010012118.o91LI3dx021213@imap1.linux-foundation.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-serial@vger.kernel.org, manuel.stahl@iis.fraunhofer.de, grant.likely@secretlab.ca

On Fri, Oct 01, 2010 at 02:18:03PM -0700, akpm@linux-foundation.org wrote:
> From: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
> 
> Add support for the sc16is7x2 chips.

I still can't apply this due to the problem at the end:

> --- a/include/linux/serial_core.h~serial-add-sc16is7x2-driver
> +++ a/include/linux/serial_core.h
> @@ -47,6 +47,9 @@
>  #define PORT_U6_16550A	19	/* ST-Ericsson U6xxx internal UART */
>  #define PORT_MAX_8250	19	/* max port ID */
>  
> +/* SC16IS7x2 SPI UART */
> +#define PORT_SC16IS7X2	19
> +

You can't duplicate stuff here, you need to pick a higher number, and
then bump up PORT_MAX_8250 as well.

thanks,

greg k-h
