From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] sc16is7xx: fix incorrect register bits macro
Date: Sat, 19 Dec 2015 16:43:03 -0800
Message-ID: <20151220004303.GA18048@kroah.com>
References: <BLU436-SMTP214949663591D40091B8468FFE20@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <BLU436-SMTP214949663591D40091B8468FFE20@phx.gbl>
Sender: linux-kernel-owner@vger.kernel.org
To: Wills Wang <wills.wang@live.com>
Cc: jringle@gridpoint.com, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Sat, Dec 19, 2015 at 07:20:06PM +0800, Wills Wang wrote:
> In datasheet, Modem Status Register MSR[4-5] reflect the modem pins
> CTS/DSR/RI/CD signal state.
> 
> Signed-off-by: Wills Wang <wills.wang@live.com>
> ---
>  drivers/tty/serial/sc16is7xx.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
> index edb5305..9d18c24 100644
> --- a/drivers/tty/serial/sc16is7xx.c
> +++ b/drivers/tty/serial/sc16is7xx.c
> @@ -196,14 +196,14 @@
>  						  * or (IO6)
>  						  * - only on 75x/76x
>  						  */
> -#define SC16IS7XX_MSR_CTS_BIT		(1 << 0) /* CTS */
> -#define SC16IS7XX_MSR_DSR_BIT		(1 << 1) /* DSR (IO4)
> +#define SC16IS7XX_MSR_CTS_BIT		(1 << 4) /* CTS */
> +#define SC16IS7XX_MSR_DSR_BIT		(1 << 5) /* DSR (IO4)

BIT(4)  BIT(5)?

Please do that at the same time...

thanks,

greg k-h
