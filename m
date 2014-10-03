From: Joseph Lo <josephl-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] serial: of-serial: add PM suspend/resume support
Date: Fri, 3 Oct 2014 15:45:37 +0800
Message-ID: <542E5421.5070708@nvidia.com>
References: <1411461252-8730-1-git-send-email-jingchang.lu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1411461252-8730-1-git-send-email-jingchang.lu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jingchang Lu <jingchang.lu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org" <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

Hi,

This patch might have a potential issue that cause system hard hung 
immediately when it accesses to registers with no clock. This could 
happen on many chips that mainline kernel supporting with the setting 
"no_console_suspend=1" during suspend time.

On 09/23/2014 04:34 PM, Jingchang Lu wrote:
> This adds PM suspend/resume support for the of-serial driver
> to provide power management support on devices attatched to it.
>
> Signed-off-by: Jingchang Lu <jingchang.lu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> ---
>   drivers/tty/serial/of_serial.c | 27 +++++++++++++++++++++++++++
>   1 file changed, 27 insertions(+)
>
> diff --git a/drivers/tty/serial/of_serial.c b/drivers/tty/serial/of_serial.c
> index 27981e2..8bc2563 100644
> --- a/drivers/tty/serial/of_serial.c
> +++ b/drivers/tty/serial/of_serial.c
> @@ -240,6 +240,32 @@ static int of_platform_serial_remove(struct platform_device *ofdev)
>   	return 0;
>   }
>
> +#ifdef CONFIG_PM_SLEEP
> +static int of_serial_suspend(struct device *dev)
> +{
> +	struct of_serial_info *info = dev_get_drvdata(dev);
> +
> +	serial8250_suspend_port(info->line);
> +	if (info->clk)
The fix would be something like this.
	if (info->clk && console_suspend_enabled)

> +		clk_disable_unprepare(info->clk);
> +
> +	return 0;
> +}
> +
> +static int of_serial_resume(struct device *dev)
> +{
> +	struct of_serial_info *info = dev_get_drvdata(dev);
> +
> +	if (info->clk)
Ditto.

Thanks,
-Joseph
> +		clk_prepare_enable(info->clk);
> +
> +	serial8250_resume_port(info->line);
> +
> +	return 0;
> +}
> +#endif
> +static SIMPLE_DEV_PM_OPS(of_serial_pm_ops, of_serial_suspend, of_serial_resume);
> +
>   /*
>    * A few common types, add more as needed.
>    */
> @@ -271,6 +297,7 @@ static struct platform_driver of_platform_serial_driver = {
>   		.name = "of_serial",
>   		.owner = THIS_MODULE,
>   		.of_match_table = of_platform_serial_table,
> +		.pm = &of_serial_pm_ops,
>   	},
>   	.probe = of_platform_serial_probe,
>   	.remove = of_platform_serial_remove,
>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
