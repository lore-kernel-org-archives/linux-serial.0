From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v2] serial: sh_sci: remove HAVE_CLK build dependecy
Date: Thu, 6 Feb 2014 17:59:07 +0900
Message-ID: <20140206085906.GA18648@verge.net.au>
References: <72da63d627f18c6b5907e7d9ef342242a8f985e6.1391676772.git.baruch@tkos.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <72da63d627f18c6b5907e7d9ef342242a8f985e6.1391676772.git.baruch@tkos.co.il>
Sender: linux-sh-owner@vger.kernel.org
To: Baruch Siach <baruch@tkos.co.il>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, linux-sh@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Thu, Feb 06, 2014 at 10:52:52AM +0200, Baruch Siach wrote:
> Since 93abe8e4 (clk: add non CONFIG_HAVE_CLK routines) code using clk.h
> like this driver needs not depend on HAVE_CLK.
> 
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>

Acked-by: Simon Horman <horms+renesas@verge.net.au>

> ---
> v2: rebase on Laurent's patch
> ---
>  drivers/tty/serial/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index 923d3dea77cb..ec7f3a6d5764 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -708,7 +708,6 @@ config SERIAL_IP22_ZILOG_CONSOLE
>  
>  config SERIAL_SH_SCI
>  	tristate "SuperH SCI(F) serial port support"
> -	depends on HAVE_CLK
>  	depends on SUPERH || ARCH_SHMOBILE || COMPILE_TEST
>  	select SERIAL_CORE
>  
> -- 
> 1.8.5.3
> 
