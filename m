From: Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v2 1/3] serial: lantiq: Use proper DT compatible string
Date: Thu, 8 Aug 2019 14:20:56 +0300
Message-ID: <20190808112056.GK30120@smile.fi.intel.com>
References: <cover.1565257887.git.rahul.tanwar@linux.intel.com>
 <57e2b69e9fbd93328a477b4c7dd2dcc78784ecb1.1565257887.git.rahul.tanwar@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <57e2b69e9fbd93328a477b4c7dd2dcc78784ecb1.1565257887.git.rahul.tanwar@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rahul Tanwar <rahul.tanwar@linux.intel.com>
Cc: linux-serial@vger.kernel.org, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, jslaby@suse.com, qi-ming.wu@intel.com, cheol.yong.kim@intel.com, rahul.tanwar@intel.com
List-Id: linux-serial@vger.kernel.org

On Thu, Aug 08, 2019 at 06:02:06PM +0800, Rahul Tanwar wrote:
> Use explicit string instead of a macro for devicetree compatible string.
> 
> This series of patches is to add support for multiple SoCs which reuse the same
> serial controller IP. The following patches will add another compatible string
> to support new Lightning Mountain(LGM) SoC. So it makes sense to have the
> compatible strings explicitly mentioned instead of a fixed macro.
> 

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

> Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
> ---
>  drivers/tty/serial/lantiq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/lantiq.c b/drivers/tty/serial/lantiq.c
> index 42e27b48e9cc..660d21db57dc 100644
> --- a/drivers/tty/serial/lantiq.c
> +++ b/drivers/tty/serial/lantiq.c
> @@ -693,7 +693,7 @@ lqasc_serial_early_console_setup(struct earlycon_device *device,
>  	device->con->write = lqasc_serial_early_console_write;
>  	return 0;
>  }
> -OF_EARLYCON_DECLARE(lantiq, DRVNAME, lqasc_serial_early_console_setup);
> +OF_EARLYCON_DECLARE(lantiq, "lantiq,asc", lqasc_serial_early_console_setup);
>  
>  static struct uart_driver lqasc_reg = {
>  	.owner =	THIS_MODULE,
> @@ -792,7 +792,7 @@ lqasc_probe(struct platform_device *pdev)
>  }
>  
>  static const struct of_device_id ltq_asc_match[] = {
> -	{ .compatible = DRVNAME },
> +	{ .compatible = "lantiq,asc" },
>  	{},
>  };
>  
> -- 
> 2.11.0
> 

-- 
With Best Regards,
Andy Shevchenko
