From: Stefan Agner <stefan@agner.ch>
Subject: Re: [PATCH 1/6] tty: serial: lpuart: introduce lpuart_soc_data to
 represent SoC property
Date: Tue, 09 May 2017 20:50:44 -0700
Message-ID: <83e341e654f5e8e788ee684bf3de51e6@agner.ch>
References: <1494316248-24052-1-git-send-email-aisheng.dong@nxp.com>
 <1494316248-24052-2-git-send-email-aisheng.dong@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1494316248-24052-2-git-send-email-aisheng.dong@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dong Aisheng <aisheng.dong@nxp.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org, jslaby@suse.com, fugang.duan@nxp.com, Mingkai.Hu@nxp.com, yangbo.lu@nxp.com
List-Id: linux-serial@vger.kernel.org

On 2017-05-09 00:50, Dong Aisheng wrote:
> This is used to dynamically check the SoC specific lpuart properies.
> Currently only the checking of 32 bit register width is added which
> functions the same as before. More will be added later for supporting
> new chips.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jslaby@suse.com>
> Cc: Fugang Duan <fugang.duan@nxp.com>
> Cc: Stefan Agner <stefan@agner.ch>
> Cc: Mingkai Hu <Mingkai.Hu@nxp.com>
> Cc: Yangbo Lu <yangbo.lu@nxp.com>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
>  drivers/tty/serial/fsl_lpuart.c | 25 ++++++++++++++++++-------
>  1 file changed, 18 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
> index 15df1ba7..cd4e905 100644
> --- a/drivers/tty/serial/fsl_lpuart.c
> +++ b/drivers/tty/serial/fsl_lpuart.c
> @@ -258,13 +258,21 @@ struct lpuart_port {
>  	wait_queue_head_t	dma_wait;
>  };
>  
> +struct lpuart_soc_data {
> +	bool	is_32;
> +};
> +
> +static struct lpuart_soc_data vf_data = {
> +	.is_32 = false,
> +};
> +
> +static struct lpuart_soc_data ls_data = {
> +	.is_32 = true,
> +};

This could be const I guess?

--
Stefan

> +
>  static const struct of_device_id lpuart_dt_ids[] = {
> -	{
> -		.compatible = "fsl,vf610-lpuart",
> -	},
> -	{
> -		.compatible = "fsl,ls1021a-lpuart",
> -	},
> +	{ .compatible = "fsl,vf610-lpuart", .data = &vf_data, },
> +	{ .compatible = "fsl,ls1021a-lpuart", .data = &ls_data, },
>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, lpuart_dt_ids);
> @@ -1971,6 +1979,9 @@ static struct uart_driver lpuart_reg = {
>  
>  static int lpuart_probe(struct platform_device *pdev)
>  {
> +	const struct of_device_id *of_id = of_match_device(lpuart_dt_ids,
> +							   &pdev->dev);
> +	const struct lpuart_soc_data *sdata = of_id->data;
>  	struct device_node *np = pdev->dev.of_node;
>  	struct lpuart_port *sport;
>  	struct resource *res;
> @@ -1988,7 +1999,7 @@ static int lpuart_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  	sport->port.line = ret;
> -	sport->lpuart32 = of_device_is_compatible(np, "fsl,ls1021a-lpuart");
> +	sport->lpuart32 = sdata->is_32;
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	sport->port.membase = devm_ioremap_resource(&pdev->dev, res);
