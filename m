From: Michael Turquette <mturquette@baylibre.com>
Subject: Re: [PATCH v2 2/9] clk: imx: vf610: Disable automatic clock gating for
 lpuart in LPSTOP mode
Date: Fri, 08 Jul 2016 11:40:03 -0700
Message-ID: <146800320338.73491.1283261070387404973@resonance>
References: <20160628053235.5114-1-bhuvanchandra.dv@toradex.com>
 <20160628053235.5114-3-bhuvanchandra.dv@toradex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <20160628053235.5114-3-bhuvanchandra.dv@toradex.com>
Sender: linux-clk-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: stefan@agner.ch, shawnguo@kernel.org, kernel@pengutronix.de, sboyd@codeaurora.org, jslaby@suse.com, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
List-Id: linux-serial@vger.kernel.org

Quoting Bhuvanchandra DV (2016-06-27 22:32:28)
> From: Stefan Agner <stefan@agner.ch>
> 
> In order to allow wake support in STOP sleep mode, clocks are needed. Use
> imx_clk_gate2_cgr to disable automatic clock gating in low power mode STOP.
> This allows to enable wake by UART using:
> echo enabled > /sys/class/tty/ttyLP0/power/wakeup
> 
> However, if wake is not enabled, the driver should disable the clocks explicitly
> to save power.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> Signed-off-by: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>

Applied.

Regards,
Mike

> ---
>  drivers/clk/imx/clk-vf610.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/clk/imx/clk-vf610.c b/drivers/clk/imx/clk-vf610.c
> index 3a1f244..0476353 100644
> --- a/drivers/clk/imx/clk-vf610.c
> +++ b/drivers/clk/imx/clk-vf610.c
> @@ -315,12 +315,12 @@ static void __init vf610_clocks_init(struct device_node *ccm_node)
>  
>         clk[VF610_CLK_PIT] = imx_clk_gate2("pit", "ipg_bus", CCM_CCGR1, CCM_CCGRx_CGn(7));
>  
> -       clk[VF610_CLK_UART0] = imx_clk_gate2("uart0", "ipg_bus", CCM_CCGR0, CCM_CCGRx_CGn(7));
> -       clk[VF610_CLK_UART1] = imx_clk_gate2("uart1", "ipg_bus", CCM_CCGR0, CCM_CCGRx_CGn(8));
> -       clk[VF610_CLK_UART2] = imx_clk_gate2("uart2", "ipg_bus", CCM_CCGR0, CCM_CCGRx_CGn(9));
> -       clk[VF610_CLK_UART3] = imx_clk_gate2("uart3", "ipg_bus", CCM_CCGR0, CCM_CCGRx_CGn(10));
> -       clk[VF610_CLK_UART4] = imx_clk_gate2("uart4", "ipg_bus", CCM_CCGR6, CCM_CCGRx_CGn(9));
> -       clk[VF610_CLK_UART5] = imx_clk_gate2("uart5", "ipg_bus", CCM_CCGR6, CCM_CCGRx_CGn(10));
> +       clk[VF610_CLK_UART0] = imx_clk_gate2_cgr("uart0", "ipg_bus", CCM_CCGR0, CCM_CCGRx_CGn(7), 0x2);
> +       clk[VF610_CLK_UART1] = imx_clk_gate2_cgr("uart1", "ipg_bus", CCM_CCGR0, CCM_CCGRx_CGn(8), 0x2);
> +       clk[VF610_CLK_UART2] = imx_clk_gate2_cgr("uart2", "ipg_bus", CCM_CCGR0, CCM_CCGRx_CGn(9), 0x2);
> +       clk[VF610_CLK_UART3] = imx_clk_gate2_cgr("uart3", "ipg_bus", CCM_CCGR0, CCM_CCGRx_CGn(10), 0x2);
> +       clk[VF610_CLK_UART4] = imx_clk_gate2_cgr("uart4", "ipg_bus", CCM_CCGR6, CCM_CCGRx_CGn(9), 0x2);
> +       clk[VF610_CLK_UART5] = imx_clk_gate2_cgr("uart5", "ipg_bus", CCM_CCGR6, CCM_CCGRx_CGn(10), 0x2);
>  
>         clk[VF610_CLK_I2C0] = imx_clk_gate2("i2c0", "ipg_bus", CCM_CCGR4, CCM_CCGRx_CGn(6));
>         clk[VF610_CLK_I2C1] = imx_clk_gate2("i2c1", "ipg_bus", CCM_CCGR4, CCM_CCGRx_CGn(7));
> -- 
> 2.9.0
> 
