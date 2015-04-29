From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [RFC/RFT 3/6] serial: msm: convert driver to use runtime PM apis
Date: Tue, 28 Apr 2015 17:16:39 -0700
Message-ID: <554022E7.90407@codeaurora.org>
References: <1429778744-13352-1-git-send-email-rnayak@codeaurora.org> <1429778744-13352-4-git-send-email-rnayak@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <1429778744-13352-4-git-send-email-rnayak@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
To: Rajendra Nayak <rnayak@codeaurora.org>, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc: linux-serial@vger.kernel.org, Pramod Gurav <gpramod@codeaurora.org>
List-Id: linux-serial@vger.kernel.org

On 04/23/15 01:45, Rajendra Nayak wrote:
> With platform support now in place to manage clocks from within runtime PM
> callbacks, get rid of all clock handling from the driver and convert the
> driver to use runtime PM apis.
>
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> Cc: <linux-serial@vger.kernel.org>

Pramod is changing the same file in the same area. Please work together
if necessary.

-Stephen

> ---
>  drivers/tty/serial/msm_serial.c | 33 ++++++++++++++++-----------------
>  1 file changed, 16 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
> index b73889c..eb66502 100644
> --- a/drivers/tty/serial/msm_serial.c
> +++ b/drivers/tty/serial/msm_serial.c
> @@ -33,6 +33,7 @@
>  #include <linux/serial.h>
>  #include <linux/clk.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/delay.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
> @@ -50,11 +51,11 @@ struct msm_port {
>  	struct uart_port	uart;
>  	char			name[16];
>  	struct clk		*clk;
> -	struct clk		*pclk;
>  	unsigned int		imr;
>  	int			is_uartdm;
>  	unsigned int		old_snap_state;
>  	bool			break_detected;
> +	struct device		*dev;
>  };
>  
>  static inline void wait_for_xmitr(struct uart_port *port)
> @@ -464,12 +465,11 @@ static int msm_set_baud_rate(struct uart_port *port, unsigned int baud)
>  	return baud;
>  }
>  
> -static void msm_init_clock(struct uart_port *port)
> +static void msm_init(struct uart_port *port)
>  {
>  	struct msm_port *msm_port = UART_TO_MSM(port);
>  
> -	clk_prepare_enable(msm_port->clk);
> -	clk_prepare_enable(msm_port->pclk);
> +	pm_runtime_get_sync(msm_port->dev);
>  	msm_serial_set_mnd_regs(port);
>  }
>  
> @@ -487,7 +487,7 @@ static int msm_startup(struct uart_port *port)
>  	if (unlikely(ret))
>  		return ret;
>  
> -	msm_init_clock(port);
> +	msm_init(port);
>  
>  	if (likely(port->fifosize > 12))
>  		rfr_level = port->fifosize - 12;
> @@ -511,7 +511,7 @@ static void msm_shutdown(struct uart_port *port)
>  	msm_port->imr = 0;
>  	msm_write(port, 0, UART_IMR); /* disable interrupts */
>  
> -	clk_disable_unprepare(msm_port->clk);
> +	pm_runtime_put_sync(msm_port->dev);
>  
>  	free_irq(port->irq, port);
>  }
> @@ -669,12 +669,10 @@ static void msm_power(struct uart_port *port, unsigned int state,
>  
>  	switch (state) {
>  	case 0:
> -		clk_prepare_enable(msm_port->clk);
> -		clk_prepare_enable(msm_port->pclk);
> +		pm_runtime_get_sync(msm_port->dev);
>  		break;
>  	case 3:
> -		clk_disable_unprepare(msm_port->clk);
> -		clk_disable_unprepare(msm_port->pclk);
> +		pm_runtime_put_sync(msm_port->dev);
>  		break;
>  	default:
>  		pr_err("msm_serial: Unknown PM state %d\n", state);
> @@ -933,7 +931,7 @@ static int __init msm_console_setup(struct console *co, char *options)
>  	if (unlikely(!port->membase))
>  		return -ENXIO;
>  
> -	msm_init_clock(port);
> +	msm_init(port);
>  
>  	if (options)
>  		uart_parse_options(options, &baud, &parity, &bits, &flow);
> @@ -1057,13 +1055,10 @@ static int msm_serial_probe(struct platform_device *pdev)
>  	if (IS_ERR(msm_port->clk))
>  		return PTR_ERR(msm_port->clk);
>  
> -	if (msm_port->is_uartdm) {
> -		msm_port->pclk = devm_clk_get(&pdev->dev, "iface");
> -		if (IS_ERR(msm_port->pclk))
> -			return PTR_ERR(msm_port->pclk);
> -
> +	if (msm_port->is_uartdm)
>  		clk_set_rate(msm_port->clk, 1843200);
> -	}
> +
> +	msm_port->dev = &pdev->dev;
>  
>  	port->uartclk = clk_get_rate(msm_port->clk);
>  	dev_info(&pdev->dev, "uartclk = %d\n", port->uartclk);
> @@ -1080,13 +1075,17 @@ static int msm_serial_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, port);
>  
> +	pm_runtime_enable(&pdev->dev);
> +
>  	return uart_add_one_port(&msm_uart_driver, port);
>  }
>  
>  static int msm_serial_remove(struct platform_device *pdev)
>  {
>  	struct uart_port *port = platform_get_drvdata(pdev);
> +	struct msm_port *msm_port = UART_TO_MSM(port);
>  
> +	pm_runtime_disable(msm_port->dev);
>  	uart_remove_one_port(&msm_uart_driver, port);
>  
>  	return 0;


-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

