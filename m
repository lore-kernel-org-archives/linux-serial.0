From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH] tty: serial: msm: Fix module autoload
Date: Tue, 3 Jan 2017 10:53:36 -0800
Message-ID: <20170103185335.GK10531@minitux>
References: <1483369040-21442-1-git-send-email-javier@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1483369040-21442-1-git-send-email-javier@osg.samsung.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, linux-arm-msm@vger.kernel.org, Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-soc@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Mon 02 Jan 06:57 PST 2017, Javier Martinez Canillas wrote:

> If the driver is built as a module, autoload won't work because the module
> alias information is not filled. So user-space can't match the registered
> device with the corresponding module.
> 
> Export the module alias information using the MODULE_DEVICE_TABLE() macro.
> 
> Before this patch:
> 
> $ modinfo drivers/tty/serial/msm_serial.ko | grep alias
> $
> 
> After this patch:
> 
> $ modinfo drivers/tty/serial/msm_serial.ko | grep alias
> alias:          of:N*T*Cqcom,msm-uartdmC*
> alias:          of:N*T*Cqcom,msm-uartdm
> alias:          of:N*T*Cqcom,msm-uartC*
> alias:          of:N*T*Cqcom,msm-uart
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
> 
>  drivers/tty/serial/msm_serial.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
> index 7312e7e01b7e..6788e7532dff 100644
> --- a/drivers/tty/serial/msm_serial.c
> +++ b/drivers/tty/serial/msm_serial.c
> @@ -1809,6 +1809,7 @@ static const struct of_device_id msm_match_table[] = {
>  	{ .compatible = "qcom,msm-uartdm" },
>  	{}
>  };
> +MODULE_DEVICE_TABLE(of, msm_match_table);
>  
>  static struct platform_driver msm_platform_driver = {
>  	.remove = msm_serial_remove,
> -- 
> 2.7.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
