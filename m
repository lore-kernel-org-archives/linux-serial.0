From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCHv2 6/8] serial: imx: add runtime pm support
Date: Wed, 12 Aug 2015 12:32:09 -0700
Message-ID: <7h1tf8pakm.fsf@deeprootsystems.com>
References: <1439256949-626-1-git-send-email-edubezval@gmail.com>
	<1439256949-626-7-git-send-email-edubezval@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1439256949-626-7-git-send-email-edubezval@gmail.com> (Eduardo
	Valentin's message of "Mon, 10 Aug 2015 18:35:47 -0700")
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Fabio Estevam <festevam@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, Linux PM <linux-pm@vger.kernel.org>, linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Eduardo Valentin <edubezval@gmail.com> writes:

> This change introduces the runtime pm support on imx serial
> driver. The objective is to be able to idle the uart
> port whenever it is not in use while still being able
> to wake it up when needed. The key changes in this patch are:
> 1. Move the clock handling to runtime pm. Both, ipg and per,
> are now handled in the suspend and resume callbacks. Only
> enabling and disabling the clocks are handled in runtime
> suspend and resume, so we are able to use runtime pm
> in IRQ context.
> 2. Clocks are prepared in probe and unprepared in remove,
> so we do not need to prepare (may sleep) in runtime pm.
> 3. We mark the device activity based on uart and console
> callbacks. Whenever the device is needed and we want to
> access registers, we runtime_pm_get and then mark its
> last usage when we are done. This is done also across
> IRQs and DMA callbacks.
> 4. We reuse the infrastructure in place for suspend and
> resume, so we do not need to redo wakeup configuration,
> or context save and restore.
>
> After this change, the clocks are still sane, in the sense
> of having balanced clock prepare and enable.
>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jslaby@suse.com>
> Cc: linux-serial@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Eduardo Valentin <edubezval@gmail.com>

[...]

> +static int serial_imx_runtime_suspend(struct device *dev)
> +{
> +	struct imx_port *sport = dev_get_drvdata(dev);
> +
> +	if (!sport)
> +		return -EINVAL;
> +
> +	/*
> +	* When using 'no_console_suspend', the console UART must not be
> +	* suspended. Since driver suspend is managed by runtime suspend,
> +	* preventing runtime suspend (by returning error) will keep device
> +	* active during suspend.
> +	*/
> +	if (sport->is_suspending && !console_suspend_enabled &&
> +	    uart_console(&sport->port))
> +		return -EBUSY;
> +
> +	serial_imx_save_context(sport);
> +	serial_imx_enable_wakeup(sport, true);
> +
> +	sport->latency = PM_QOS_CPU_DMA_LAT_DEFAULT_VALUE;
> +	schedule_work(&sport->qos_work);
> +	clk_disable(sport->clk_per);
> +	clk_disable(sport->clk_ipg);
> +
> +	return 0;
> +}
> +
> +static int serial_imx_runtime_resume(struct device *dev)
> +{
> +	struct imx_port *sport = dev_get_drvdata(dev);
> +
> +	clk_enable(sport->clk_per);
> +	clk_enable(sport->clk_ipg);
> +	serial_imx_enable_wakeup(sport, false);
> +
> +	sport->latency = sport->calc_latency;
> +	schedule_work(&sport->qos_work);
> +	serial_imx_restore_context(sport);
> +
> +	return 0;
> +}

Looking at the clk usage in the_runtime_[suspend|resume] callbacks, did
you consider using the runtime PM generic clock layer (pm_clk_*).  You
can have a look at mach-shmobile for an example modern user of this, or
mach-davinci for a legacy (pre-DT) way of using it.

Kevin
