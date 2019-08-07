From: Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH 2/5] serial: lantiq: Use proper DT compatible string
Date: Wed, 7 Aug 2019 16:20:56 +0300
Message-ID: <20190807132056.GX30120@smile.fi.intel.com>
References: <cover.1565160764.git.rahul.tanwar@linux.intel.com>
 <12c3029f406ca1fedf14154154f7082e358f0473.1565160764.git.rahul.tanwar@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <12c3029f406ca1fedf14154154f7082e358f0473.1565160764.git.rahul.tanwar@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rahul Tanwar <rahul.tanwar@linux.intel.com>
Cc: linux-serial@vger.kernel.org, devicetree@vger.kernel.org, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, jslaby@suse.com, robh+dt@kernel.org, mark.rutland@arm.com, qi-ming.wu@intel.com, cheol.yong.kim@intel.com, rahul.tanwar@intel.com
List-Id: linux-serial@vger.kernel.org

On Wed, Aug 07, 2019 at 05:21:32PM +0800, Rahul Tanwar wrote:
> The patch adds change to use explicit string instead of a macro for
> DT compatible string.

For consistency you may need to convert OF_EARLYCON_DECLARE() as well.

Perhaps commit message should explain the rationale, i.e. the following patches
will add another compatible string and thus it makes sense to have them
explicitly mentioned.

> Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
> ---
>  drivers/tty/serial/lantiq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/lantiq.c b/drivers/tty/serial/lantiq.c
> index 42e27b48e9cc..1116261c973e 100644
> --- a/drivers/tty/serial/lantiq.c
> +++ b/drivers/tty/serial/lantiq.c
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
