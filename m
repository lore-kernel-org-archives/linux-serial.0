From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH 1/1] serial: imx: convert to clk_prepare/clk_unprepare
Date: Thu, 10 Nov 2011 09:06:41 +0100
Message-ID: <20111110080641.GT16886@pengutronix.de>
References: <1320901158-13103-1-git-send-email-richard.zhao@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1320901158-13103-1-git-send-email-richard.zhao@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Richard Zhao <richard.zhao@linaro.org>
Cc: kernel@pengutronix.de, eric.miao@linaro.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, alan@linux.intel.com
List-Id: linux-serial@vger.kernel.org

On Thu, Nov 10, 2011 at 12:59:18PM +0800, Richard Zhao wrote:
> Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
> ---
>  drivers/tty/serial/imx.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 163fc90..22fd9c8 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -1390,6 +1390,7 @@ static int serial_imx_probe(struct platform_device *pdev)
>  		ret = PTR_ERR(sport->clk);
>  		goto unmap;
>  	}
> +	clk_prepare(sport->clk);
>  	clk_enable(sport->clk);
>  
>  	sport->port.uartclk = clk_get_rate(sport->clk);
> @@ -1415,6 +1416,7 @@ deinit:
>  clkput:
>  	clk_put(sport->clk);
>  	clk_disable(sport->clk);
> +	clk_unprepare(sport->clk);

Ouch, clk_put before clk_disable? This is is bug. Care to fix it?

>  unmap:
>  	iounmap(sport->port.membase);
>  free:
> @@ -1438,6 +1440,7 @@ static int serial_imx_remove(struct platform_device *pdev)
>  	}
>  
>  	clk_disable(sport->clk);
> +	clk_unprepare(sport->clk);
>  

Here clk_put is missing, another bug.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
