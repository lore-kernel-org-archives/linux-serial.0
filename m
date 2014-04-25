From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/2] serial: sc16is7xx: depend on I2C
Date: Fri, 25 Apr 2014 13:23:15 -0700
Message-ID: <20140425202315.GA8821@kroah.com>
References: <1398455590-4374-1-git-send-email-jon@ringle.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:49756 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752524AbaDYUUU (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 25 Apr 2014 16:20:20 -0400
Content-Disposition: inline
In-Reply-To: <1398455590-4374-1-git-send-email-jon@ringle.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: jon@ringle.org
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, shc_work@mail.ru, Jon Ringle <jringle@gridpoint.com>

On Fri, Apr 25, 2014 at 03:53:09PM -0400, jon@ringle.org wrote:
> From: Jon Ringle <jringle@gridpoint.com>
> 
> Signed-off-by: Jon Ringle <jringle@gridpoint.com>
> ---
>  drivers/tty/serial/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index c3e2b32..64c5659 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -1180,6 +1180,7 @@ config SERIAL_SCCNXP_CONSOLE
>  
>  config SERIAL_SC16IS7XX
>  	tristate "SC16IS7xx serial support"
> +	depends on I2C
>  	select SERIAL_CORE
>  	select REGMAP_I2C if I2C
>  	help
> -- 
> 1.8.5.4

Better, but I still have the build warnings :(
