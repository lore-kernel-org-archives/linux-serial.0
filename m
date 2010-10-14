From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH resend] Add sc16is7x2 driver
Date: Thu, 14 Oct 2010 12:01:33 -0700
Message-ID: <20101014190133.GB1009@kroah.com>
References: <4CAD818B.2070603@iis.fraunhofer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4CAD818B.2070603@iis.fraunhofer.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
Cc: linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-serial@vger.kernel.org

On Thu, Oct 07, 2010 at 10:15:07AM +0200, Manuel Stahl wrote:
> --- /dev/null
> +++ b/include/linux/spi/sc16is7x2.h
> @@ -0,0 +1,17 @@
> +#ifndef LINUX_SPI_SC16IS752_H
> +#define LINUX_SPI_SC16IS752_H
> +
> +#define SC16IS7X2_NR_GPIOS 8
> +
> +struct sc16is7x2_platform_data {
> +	unsigned int	uartclk;
> +	/* uart line number of the first channel */
> +	unsigned	uart_base;
> +	/* number assigned to the first GPIO */
> +	unsigned	gpio_base;
> +	char		*label;
> +	/* list of GPIO names (array length = SC16IS7X2_NR_GPIOS) */
> +	const char	*const *names;
> +};
> +
> +#endif

Why is this needed in a .h file?  What other .c file uses this define
and structure?

thanks,

greg k-h
