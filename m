From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH] tty: serial: msm: Add runtime PM and system sleep support
Date: Thu, 25 Aug 2016 15:50:09 -0700
Message-ID: <20160825225009.GV19826@codeaurora.org>
References: <1466158618-6702-1-git-send-email-pramod.gurav@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1466158618-6702-1-git-send-email-pramod.gurav@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Pramod Gurav <pramod.gurav@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org, gregkh@linuxfoundation.org, jslaby@suse.com, andy.gross@linaro.org, david.brown@linaro.org, ulf.hansson@linaro.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 06/17, Pramod Gurav wrote:
> @@ -1220,12 +1293,26 @@ static void msm_power(struct uart_port *port, unsigned int state,
>  
>  	switch (state) {
>  	case 0:
> -		clk_prepare_enable(msm_port->clk);
> -		clk_prepare_enable(msm_port->pclk);
> +		/*
> +		 * UART clk must be kept enabled to
> +		 * avoid losing received character
> +		 */

Don't we have a wakeup irq? Two wire interfaces probably don't
work though (like the debug uart).

> +		if (clk_prepare_enable(msm_port->clk))
> +			return;
> +		if (clk_prepare(msm_port->pclk)) {
> +			clk_disable_unprepare(msm_port->clk);
> +			return;
> +		}
> +		if (pm_runtime_get_sync(port->dev) < 0) {
> +			clk_unprepare(msm_port->pclk);
> +			clk_disable_unprepare(msm_port->clk);

I guess that's why we gate the interface clk and not the core clk
during runtime PM? core clk goes off and then device is basically
suspended unless it can wakeup with an irq.

> +			return;
> +		}
>  		break;
>  	case 3:
> +		pm_runtime_put(port->dev);
> +		clk_unprepare(msm_port->pclk);
>  		clk_disable_unprepare(msm_port->clk);
> -		clk_disable_unprepare(msm_port->pclk);
>  		break;
>  	default:
>  		pr_err("msm_serial: Unknown PM state %d\n", state);
> @@ -1465,7 +1552,11 @@ static void msm_console_write(struct console *co, const char *s,
>  	port = msm_get_port_from_line(co->index);
>  	msm_port = UART_TO_MSM(port);
>  
> +	if (pm_runtime_get_sync(port->dev) < 0)
> +		return;
>  	__msm_console_write(port, s, count, msm_port->is_uartdm);
> +	pm_runtime_mark_last_busy(port->dev);
> +	pm_runtime_put_autosuspend(port->dev);

Hmm ok, perhaps we should differentiate runtime PM for devices
that use the console and ones that are being used for other
things? I would guess that console can only turn off the
interface clk while idle, but the non-console devices could turn
off everything at runtime and rely on some out of band signaling
to wakeup when something comes over the rx wire?

>  }
>  
>  static int __init msm_console_setup(struct console *co, char *options)
> @@ -1484,7 +1575,7 @@ static int __init msm_console_setup(struct console *co, char *options)
>  	if (unlikely(!port->membase))
>  		return -ENXIO;
>  
> -	msm_init_clock(port);
> +	msm_serial_set_mnd_regs(port);
>  
>  	if (options)
>  		uart_parse_options(options, &baud, &parity, &bits, &flow);

Doesn't uart_set_options() go and touch hardware registers during
termios settings? The clks are no longer enabled here though so I
hope this isn't relying on the fact that the clks are enabled in
the bootloader?

> @@ -1627,6 +1718,12 @@ static int msm_serial_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, port);
>  
> +	pm_runtime_use_autosuspend(&pdev->dev);
> +	pm_runtime_set_autosuspend_delay(&pdev->dev, 500);
> +	pm_runtime_irq_safe(&pdev->dev);

So this means irqs are always disabled while runtime PM
callbacks are run....

> +	pm_runtime_enable(&pdev->dev);
> +	pm_runtime_set_suspended(&pdev->dev);
> +
>  	return uart_add_one_port(&msm_uart_driver, port);
>  }
>  
> @@ -1645,12 +1743,67 @@ static const struct of_device_id msm_match_table[] = {
>  	{}
>  };
>  
> +#ifdef CONFIG_PM
> +static int msm_serial_runtime_suspend(struct device *dev)
> +{
> +	struct uart_port *port = dev_get_drvdata(dev);
> +	struct msm_port *msm_port = UART_TO_MSM(port);
> +
> +	if (msm_port->is_uartdm)
> +		clk_disable(msm_port->pclk);

... so we can't unprepare clks here. That's unfortunate because
clks that are ancestors of these clks will be kept prepared and
that could lead to things like PLLs being kept enabled, etc.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
