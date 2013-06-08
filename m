From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH V2] serial: imx: enable the clocks only when the uart is
 used
Date: Sat, 8 Jun 2013 14:01:19 +0800
Message-ID: <20130608060116.GB20780@S2101-09.ap.freescale.net>
References: <1370311173-15019-1-git-send-email-b32955@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1370311173-15019-1-git-send-email-b32955@freescale.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Huang Shijie <b32955@freescale.com>
Cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Tue, Jun 04, 2013 at 09:59:33AM +0800, Huang Shijie wrote:
> Current code opens the clocks when the uart driver is probed.
> This will wastes some power if several uarts are enabled, but not really
> used.
> 
> So close these clocks for uart, and enable the clocks only when
> the uart is used.
> 
> Signed-off-by: Huang Shijie <b32955@freescale.com>

Running linux-next 20130607, I just found that the serial console stops
working due to this patch.  I think the clocks need to be enabled for
console as well.

Shawn

> ---
> v1 --> v2:
> 	check the return value of clk_prepare_enable().
> ---
>  drivers/tty/serial/imx.c |   17 ++++++++++++++---
>  1 files changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 72bc1db..7cc4810 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -699,6 +699,14 @@ static int imx_startup(struct uart_port *port)
>  	int retval;
>  	unsigned long flags, temp;
>  
> +	retval = clk_prepare_enable(sport->clk_per);
> +	if (retval)
> +		goto error_out1;
> +
> +	retval = clk_prepare_enable(sport->clk_ipg);
> +	if (retval)
> +		goto error_out1;
> +
>  	imx_setup_ufcr(sport, 0);
>  
>  	/* disable the DREN bit (Data Ready interrupt enable) before
> @@ -884,6 +892,9 @@ static void imx_shutdown(struct uart_port *port)
>  
>  	writel(temp, sport->port.membase + UCR1);
>  	spin_unlock_irqrestore(&sport->port.lock, flags);
> +
> +	clk_disable_unprepare(sport->clk_per);
> +	clk_disable_unprepare(sport->clk_ipg);
>  }
>  
>  static void
> @@ -1557,6 +1568,9 @@ static int serial_imx_probe(struct platform_device *pdev)
>  		goto deinit;
>  	platform_set_drvdata(pdev, sport);
>  
> +	clk_disable_unprepare(sport->clk_per);
> +	clk_disable_unprepare(sport->clk_ipg);
> +
>  	return 0;
>  deinit:
>  	if (pdata && pdata->exit)
> @@ -1578,9 +1592,6 @@ static int serial_imx_remove(struct platform_device *pdev)
>  
>  	uart_remove_one_port(&imx_reg, &sport->port);
>  
> -	clk_disable_unprepare(sport->clk_per);
> -	clk_disable_unprepare(sport->clk_ipg);
> -
>  	if (pdata && pdata->exit)
>  		pdata->exit(pdev);
>  
> -- 
> 1.7.1
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
