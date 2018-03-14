From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] serial: samsung: macros with complex values should be
 enclosed in parentheses
Date: Wed, 14 Mar 2018 14:58:04 +0100
Message-ID: <20180314135804.GA21350@kroah.com>
References: <CGME20180314021710epcas1p3766602fe312f87d916cab69af2acf203@epcas1p3.samsung.com>
 <1520993825-8605-1-git-send-email-y.k.oh@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1520993825-8605-1-git-send-email-y.k.oh@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: YOUNGKEUN OH <y.k.oh@samsung.com>
Cc: jslaby@suse.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Wed, Mar 14, 2018 at 11:17:05AM +0900, YOUNGKEUN OH wrote:
> Cleanup checkpatch error:
> ERROR: Macros with complex values should be enclosed in parentheses
> 
> Signed-off-by: YOUNGKEUN OH <y.k.oh@samsung.com>
> ---
>  drivers/tty/serial/samsung.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
> index 3f2f8c1..da9bddb1 100644
> --- a/drivers/tty/serial/samsung.c
> +++ b/drivers/tty/serial/samsung.c
> @@ -1455,7 +1455,7 @@ static int __init s3c24xx_serial_console_init(void)
>  }
>  console_initcall(s3c24xx_serial_console_init);
> 
> -#define S3C24XX_SERIAL_CONSOLE &s3c24xx_serial_console
> +#define S3C24XX_SERIAL_CONSOLE (&s3c24xx_serial_console)

That's not a complex macro!

Please use checkpatch as a hint, not the "truth".

thanks,

greg k-h
