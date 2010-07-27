From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [RESEND PATCH] max3107: Fix gpiolib support
Date: Tue, 27 Jul 2010 11:49:02 -0700
Message-ID: <4C4F2A1E.7010600@oracle.com>
References: <20100727071551.25761.146.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from rcsinet10.oracle.com ([148.87.113.121]:53263 "EHLO
	rcsinet10.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750795Ab0G0StZ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 27 Jul 2010 14:49:25 -0400
In-Reply-To: <20100727071551.25761.146.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, greg@kroah.com

Alan Cox wrote:
> Because of the way gpiolib works we actually need to ifdef this in our
> header file
> 
> Signed-off-by: Alan Cox <alan@linux.intel.com>

Acked-by: Randy Dunlap <randy.dunlap@oracle.com>

Thanks.

> ---
> 
>  drivers/serial/max3107.h |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> 
> diff --git a/drivers/serial/max3107.h b/drivers/serial/max3107.h
> index 72b3041..7ab6323 100644
> --- a/drivers/serial/max3107.h
> +++ b/drivers/serial/max3107.h
> @@ -368,8 +368,10 @@ struct max3107_port {
>  	/* SPI device structure */
>  	struct spi_device *spi;
>  
> +#if defined(CONFIG_GPIOLIB)
>  	/* GPIO chip stucture */
>  	struct gpio_chip chip;
> +#endif
>  
>  	/* Workqueue that does all the magic */
>  	struct workqueue_struct *workqueue;
> 
> --

