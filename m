From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/1] Serial: imx: add dev_pm_ops to support suspend to
 ram/disk
Date: Thu, 23 Jul 2015 17:37:22 -0700
Message-ID: <20150724003722.GA14027@kroah.com>
References: <1437165018-56026-1-git-send-email-shenwei.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1437165018-56026-1-git-send-email-shenwei.wang@freescale.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Shenwei Wang <shenwei.wang@freescale.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Fri, Jul 17, 2015 at 03:30:18PM -0500, Shenwei Wang wrote:
> When system goes into low power states like SUSPEND_MEM and
> HIBERNATION, the hardware IP block may be powered off to reduce
> the power consumption. This power down may cause problems on
> some imx platforms, because the hardware settings are reset to
> its power on default values which may differ from the ones when
> it power off. This patch added the dev_pm_ops and implemented
> two callbacks: suspend_noirq and resume_noirq, which will save
> the necessory hardware parameters right before power down and
> recover them before system uses the hardware.
> 
> Signed-off-by: Shenwei Wang <shenwei.wang@freescale.com>
> ---
>  drivers/tty/serial/imx.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 54 insertions(+)
> 
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index c8cfa06..acaaa68 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -216,6 +216,7 @@ struct imx_port {
>  	unsigned int		tx_bytes;
>  	unsigned int		dma_tx_nents;
>  	wait_queue_head_t	dma_wait;
> +	unsigned int            saved_reg[10];
>  };
>  
>  struct imx_port_ucrs {
> @@ -1986,6 +1987,58 @@ static int serial_imx_remove(struct platform_device *pdev)
>  	return uart_remove_one_port(&imx_reg, &sport->port);
>  }
>  
> +static int imx_serial_port_suspend_noirq(struct device *dev)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct imx_port *sport = platform_get_drvdata(pdev);
> +
> +	/* Save necessary regs */
> +	clk_enable(sport->clk_ipg);
> +	sport->saved_reg[0] = readl(sport->port.membase + UCR1);
> +	sport->saved_reg[1] = readl(sport->port.membase + UCR2);
> +	sport->saved_reg[2] = readl(sport->port.membase + UCR3);
> +	sport->saved_reg[3] = readl(sport->port.membase + UCR4);
> +	sport->saved_reg[4] = readl(sport->port.membase + UFCR);
> +	sport->saved_reg[5] = readl(sport->port.membase + UESC);
> +	sport->saved_reg[6] = readl(sport->port.membase + UTIM);
> +	sport->saved_reg[7] = readl(sport->port.membase + UBIR);
> +	sport->saved_reg[8] = readl(sport->port.membase + UBMR);
> +	sport->saved_reg[9] = readl(sport->port.membase + IMX21_UTS);
> +	clk_disable(sport->clk_ipg);
> +
> +	pr_debug("0x%p (%d)\r\n", sport->port.membase, sport->port.line);

You have a struct device, please use dev_dbg() instead.

> +
> +	return 0;
> +}
> +
> +static int imx_serial_port_resume_noirq(struct device *dev)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct imx_port *sport = platform_get_drvdata(pdev);
> +
> +	clk_enable(sport->clk_ipg);
> +	writel(sport->saved_reg[4], sport->port.membase + UFCR);
> +	writel(sport->saved_reg[5], sport->port.membase + UESC);
> +	writel(sport->saved_reg[6], sport->port.membase + UTIM);
> +	writel(sport->saved_reg[7], sport->port.membase + UBIR);
> +	writel(sport->saved_reg[8], sport->port.membase + UBMR);
> +	writel(sport->saved_reg[9], sport->port.membase + IMX21_UTS);
> +	writel(sport->saved_reg[0], sport->port.membase + UCR1);
> +	writel(sport->saved_reg[1] | 0x1, sport->port.membase + UCR2);
> +	writel(sport->saved_reg[2], sport->port.membase + UCR3);
> +	writel(sport->saved_reg[3], sport->port.membase + UCR4);
> +	clk_disable(sport->clk_ipg);
> +
> +	pr_debug("0x%p (%d)\r\n", sport->port.membase, sport->port.line);

Same here, please use dev_dbg()
