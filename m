From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v3 1/1] Serial: imx: add dev_pm_ops to support suspend to
 ram/disk
Date: Wed, 29 Jul 2015 18:21:08 -0300
Message-ID: <CAOMZO5Aj5PASPKRq47vmenDBSPMPHdLgSbJZXkhZu3MNYprqXA@mail.gmail.com>
References: <1438203535-38028-1-git-send-email-shenwei.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1438203535-38028-1-git-send-email-shenwei.wang@freescale.com>
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
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

On Wed, Jul 29, 2015 at 5:58 PM, Shenwei Wang
<shenwei.wang@freescale.com> wrote:

> +static int imx_serial_port_suspend_noirq(struct device *dev)
> +{
> +       struct platform_device *pdev = to_platform_device(dev);
> +       struct imx_port *sport = platform_get_drvdata(pdev);
> +
> +       /* Save necessary regs */
> +       clk_enable(sport->clk_ipg);

clk_enable() may fail, so you should check its return value.

> +       sport->saved_reg[0] = readl(sport->port.membase + UCR1);
> +       sport->saved_reg[1] = readl(sport->port.membase + UCR2);
> +       sport->saved_reg[2] = readl(sport->port.membase + UCR3);
> +       sport->saved_reg[3] = readl(sport->port.membase + UCR4);
> +       sport->saved_reg[4] = readl(sport->port.membase + UFCR);
> +       sport->saved_reg[5] = readl(sport->port.membase + UESC);
> +       sport->saved_reg[6] = readl(sport->port.membase + UTIM);
> +       sport->saved_reg[7] = readl(sport->port.membase + UBIR);
> +       sport->saved_reg[8] = readl(sport->port.membase + UBMR);
> +       sport->saved_reg[9] = readl(sport->port.membase + IMX21_UTS);
> +       clk_disable(sport->clk_ipg);
> +
> +       dev_dbg(dev, "0x%p (%d)\r\n", sport->port.membase, sport->port.line);
> +
> +       return 0;
> +}
> +
> +static int imx_serial_port_resume_noirq(struct device *dev)
> +{
> +       struct platform_device *pdev = to_platform_device(dev);
> +       struct imx_port *sport = platform_get_drvdata(pdev);
> +
> +       clk_enable(sport->clk_ipg);

Same here.

> +       writel(sport->saved_reg[4], sport->port.membase + UFCR);
> +       writel(sport->saved_reg[5], sport->port.membase + UESC);
> +       writel(sport->saved_reg[6], sport->port.membase + UTIM);
> +       writel(sport->saved_reg[7], sport->port.membase + UBIR);
> +       writel(sport->saved_reg[8], sport->port.membase + UBMR);
> +       writel(sport->saved_reg[9], sport->port.membase + IMX21_UTS);
> +       writel(sport->saved_reg[0], sport->port.membase + UCR1);
> +       writel(sport->saved_reg[1] | 0x1, sport->port.membase + UCR2);

Why this magic '| 0x1'? Can't you use a define instead?
