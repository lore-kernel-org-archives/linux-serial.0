From: Andy Gross <andy.gross@linaro.org>
Subject: Re: [PATCH] tty: serial: msm: Add runtime PM and system sleep support
Date: Wed, 24 Aug 2016 23:35:57 -0500
Message-ID: <CAPBZ5Qf6T1=1+Xc_hea5zbPSs7th7F7pSLg+5dqmiPBnb6m8=g@mail.gmail.com>
References: <1466158618-6702-1-git-send-email-pramod.gurav@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1466158618-6702-1-git-send-email-pramod.gurav@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Pramod Gurav <pramod.gurav@linaro.org>
Cc: linux-arm-msm <linux-arm-msm@vger.kernel.org>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, David Brown <david.brown@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On 17 June 2016 at 05:16, Pramod Gurav <pramod.gurav@linaro.org> wrote:

<snip>

> @@ -1635,6 +1732,7 @@ static int msm_serial_remove(struct platform_device *pdev)
>         struct uart_port *port = platform_get_drvdata(pdev);
>
>         uart_remove_one_port(&msm_uart_driver, port);
> +       pm_runtime_disable(&pdev->dev);
>
>         return 0;
>  }
> @@ -1645,12 +1743,67 @@ static const struct of_device_id msm_match_table[] = {
>         {}
>  };
>
> +#ifdef CONFIG_PM
> +static int msm_serial_runtime_suspend(struct device *dev)
> +{
> +       struct uart_port *port = dev_get_drvdata(dev);
> +       struct msm_port *msm_port = UART_TO_MSM(port);
> +
> +       if (msm_port->is_uartdm)
> +               clk_disable(msm_port->pclk);

You don't need to check, just clk_disable it.

> +
> +       return 0;
> +}
> +
> +static int msm_serial_runtime_resume(struct device *dev)
> +{
> +       struct uart_port *port = dev_get_drvdata(dev);
> +       struct msm_port *msm_port = UART_TO_MSM(port);
> +       int ret;
> +
> +       if (msm_port->is_uartdm) {
> +               ret = clk_enable(msm_port->pclk);

Ditto here.

> +               if (ret)
> +                       return ret;
> +       }
> +
> +       return 0;
> +}
> +#endif
> +


Regards,

Andy
