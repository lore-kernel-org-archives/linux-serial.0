From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v4 1/1] Serial: imx: add dev_pm_ops to support suspend to
 ram/disk
Date: Thu, 30 Jul 2015 12:15:50 -0300
Message-ID: <CAOMZO5DN3vARpY0ZQ7nEv+jbf-kcQQF4jrXqddGi81wvaxLPMg@mail.gmail.com>
References: <1438266762-4397-1-git-send-email-shenwei.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1438266762-4397-1-git-send-email-shenwei.wang@freescale.com>
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
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi Shenwei,

On Thu, Jul 30, 2015 at 11:32 AM, Shenwei Wang
<shenwei.wang@freescale.com> wrote:

> +static int imx_serial_port_suspend_noirq(struct device *dev)
> +{
> +       struct platform_device *pdev = to_platform_device(dev);
> +       struct imx_port *sport = platform_get_drvdata(pdev);
> +       int ret;
> +
> +       ret = clk_enable(sport->clk_ipg);
> +       if (ret)
> +               dev_err(dev, "UART%d suspend error!\r\n", sport->port.line);

In case of error you should propagate it:

ret = clk_enable(sport->clk_ipg);
if (ret)
    return ret;

> +
> +       /* Save necessary regs */
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
> +
> +       if (ret == 0)
> +               clk_disable(sport->clk_ipg);

then you don't need to check ret here. Just call clk_disable unconditionally.

> +
> +       return 0;
> +}
> +
> +static int imx_serial_port_resume_noirq(struct device *dev)
> +{
> +       struct platform_device *pdev = to_platform_device(dev);
> +       struct imx_port *sport = platform_get_drvdata(pdev);
> +       int ret;
> +
> +       ret = clk_enable(sport->clk_ipg);
> +       if (ret)
> +               dev_err(dev, "UART%d resume error!\r\n", sport->port.line);

Same here.
