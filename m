From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] serial: imx: Fix suspend / resume.
Date: Mon, 4 Jan 2016 19:10:14 +0000
Message-ID: <20160104191014.GN19062@n2100.arm.linux.org.uk>
References: <20160104182206.10852.47155.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20160104182206.10852.47155.stgit@localhost>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Martin Fuzzey <mfuzzey@parkeon.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Mon, Jan 04, 2016 at 07:22:06PM +0100, Martin Fuzzey wrote:
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 016e4be..16a551b 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -2071,13 +2071,13 @@ static int imx_serial_port_suspend_noirq(struct device *dev)
>  	struct imx_port *sport = platform_get_drvdata(pdev);
>  	int ret;
>  
> -	ret = clk_enable(sport->clk_ipg);
> +	ret = clk_prepare_enable(sport->clk_ipg);
>  	if (ret)
>  		return ret;
>  
>  	serial_imx_save_context(sport);
>  
> -	clk_disable(sport->clk_ipg);
> +	clk_disable_unprepare(sport->clk_ipg);

NAK.  If this is _noirq, then it's a context which can't sleep.  Therefore,
calling functions that do sleep is not permitted.

> @@ -2088,13 +2088,13 @@ static int imx_serial_port_resume_noirq(struct device *dev)
>  	struct imx_port *sport = platform_get_drvdata(pdev);
>  	int ret;
>  
> -	ret = clk_enable(sport->clk_ipg);
> +	ret = clk_prepare_enable(sport->clk_ipg);
>  	if (ret)
>  		return ret;
>  
>  	serial_imx_restore_context(sport);
>  
> -	clk_disable(sport->clk_ipg);
> +	clk_disable_unprepare(sport->clk_ipg);

Ditto.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
