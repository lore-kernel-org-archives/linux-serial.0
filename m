From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH v2 1/6] Revert "drivers/tty/serial: make 8250/8250_mtk.c
 explicitly non-modular"
Date: Thu, 11 Feb 2016 11:00:22 -0500
Message-ID: <20160211160021.GF28452@windriver.com>
References: <1455205297-1021302-1-git-send-email-arnd@arndb.de>
 <1455205297-1021302-2-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1455205297-1021302-2-git-send-email-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Matthias Brugger <matthias.bgg@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, linux-mediatek@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

[[PATCH v2 1/6] Revert "drivers/tty/serial: make 8250/8250_mtk.c explicitly non-modular"] On 11/02/2016 (Thu 16:41) Arnd Bergmann wrote:

> This reverts commit d72d391c126e, which tried to remove dead code but
> left the driver in a useless state when the main 8250 driver is a

Am I misunderstanding something?  The commit didn't cause the driver to
be in a useless state for 8250=m.  But rather isn't that it was a
pre-existing condition, independent of the change to 8250_mtk.c to
remove the dead code in d72d391c126e?

Since the commit did not touch Kconfig or Makefile, I can't see how it
could cause some new useless state that did not already exist, and hence
the "Fixes:" tag is invalid as well.

Paul.
--

> loadable module. This would normally result in a link error, but
> as the entire drivers/tty/serial/8250/ directory is only entered
> when CONFIG_SERIAL_8250 is set, we never notice that the driver does
> not get built in this configuration.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: d72d391c126e ("drivers/tty/serial: make 8250/8250_mtk.c explicitly non-modular")
> ---
>  drivers/tty/serial/8250/8250_mtk.c | 35 ++++++++++++++++++++++++++++-------
>  1 file changed, 28 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
> index 0e590b233f03..78883ca64ddd 100644
> --- a/drivers/tty/serial/8250/8250_mtk.c
> +++ b/drivers/tty/serial/8250/8250_mtk.c
> @@ -16,7 +16,7 @@
>   */
>  #include <linux/clk.h>
>  #include <linux/io.h>
> -#include <linux/init.h>
> +#include <linux/module.h>
>  #include <linux/of_irq.h>
>  #include <linux/of_platform.h>
>  #include <linux/platform_device.h>
> @@ -245,6 +245,23 @@ static int mtk8250_probe(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static int mtk8250_remove(struct platform_device *pdev)
> +{
> +	struct mtk8250_data *data = platform_get_drvdata(pdev);
> +
> +	pm_runtime_get_sync(&pdev->dev);
> +
> +	serial8250_unregister_port(data->line);
> +
> +	pm_runtime_disable(&pdev->dev);
> +	pm_runtime_put_noidle(&pdev->dev);
> +
> +	if (!pm_runtime_status_suspended(&pdev->dev))
> +		mtk8250_runtime_suspend(&pdev->dev);
> +
> +	return 0;
> +}
> +
>  #ifdef CONFIG_PM_SLEEP
>  static int mtk8250_suspend(struct device *dev)
>  {
> @@ -275,18 +292,18 @@ static const struct of_device_id mtk8250_of_match[] = {
>  	{ .compatible = "mediatek,mt6577-uart" },
>  	{ /* Sentinel */ }
>  };
> +MODULE_DEVICE_TABLE(of, mtk8250_of_match);
>  
>  static struct platform_driver mtk8250_platform_driver = {
>  	.driver = {
> -		.name			= "mt6577-uart",
> -		.pm			= &mtk8250_pm_ops,
> -		.of_match_table		= mtk8250_of_match,
> -		.suppress_bind_attrs	= true,
> -
> +		.name		= "mt6577-uart",
> +		.pm		= &mtk8250_pm_ops,
> +		.of_match_table	= mtk8250_of_match,
>  	},
>  	.probe			= mtk8250_probe,
> +	.remove			= mtk8250_remove,
>  };
> -builtin_platform_driver(mtk8250_platform_driver);
> +module_platform_driver(mtk8250_platform_driver);
>  
>  #ifdef CONFIG_SERIAL_8250_CONSOLE
>  static int __init early_mtk8250_setup(struct earlycon_device *device,
> @@ -302,3 +319,7 @@ static int __init early_mtk8250_setup(struct earlycon_device *device,
>  
>  OF_EARLYCON_DECLARE(mtk8250, "mediatek,mt6577-uart", early_mtk8250_setup);
>  #endif
> +
> +MODULE_AUTHOR("Matthias Brugger");
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Mediatek 8250 serial port driver");
> -- 
> 2.7.0
> 
