From: Stefan Agner <stefan@agner.ch>
Subject: Re: [PATCH 4/6] tty: serial: lpuart: add imx7ulp support
Date: Tue, 09 May 2017 21:10:18 -0700
Message-ID: <697fae59cb4e5ff921bb83614325b3f1@agner.ch>
References: <1494316248-24052-1-git-send-email-aisheng.dong@nxp.com>
 <1494316248-24052-5-git-send-email-aisheng.dong@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1494316248-24052-5-git-send-email-aisheng.dong@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dong Aisheng <aisheng.dong@nxp.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org, jslaby@suse.com, fugang.duan@nxp.com, Mingkai.Hu@nxp.com, yangbo.lu@nxp.com
List-Id: linux-serial@vger.kernel.org

On 2017-05-09 00:50, Dong Aisheng wrote:
> The lpuart of imx7ulp is basically the same as ls1021a. It's also
> 32 bit width register, but unlike ls1021a, it's little endian.
> Besides that, imx7ulp lpuart has a minor different register layout
> from ls1021a that it has four extra registers (verid, param, global,
> pincfg) located at the beginning of register map, which are currently
> not used by the driver and less to be used later.
> 
> To ease the register difference handling, we add a reg_off member
> in lpuart_soc_data structure to represent if the normal
> lpuart32_{read|write} requires plus a offset to hide the issue.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jslaby@suse.com>
> Cc: Fugang Duan <fugang.duan@nxp.com>
> Cc: Stefan Agner <stefan@agner.ch>
> Cc: Mingkai Hu <Mingkai.Hu@nxp.com>
> Cc: Yangbo Lu <yangbo.lu@nxp.com>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
>  drivers/tty/serial/fsl_lpuart.c | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
> index bddd041..1cdb3f9 100644
> --- a/drivers/tty/serial/fsl_lpuart.c
> +++ b/drivers/tty/serial/fsl_lpuart.c
> @@ -231,7 +231,11 @@
>  #define DEV_NAME	"ttyLP"
>  #define UART_NR		6
>  
> +/* IMX lpuart has four extra unused regs located at the beginning */
> +#define IMX_REG_OFF	0x10
> +
>  static bool lpuart_is_be;
> +static u8 lpuart_reg_off;

Global variables? That hardly works once you have two UARTs...

Instead of adding a fixed offset to any write you could just add the
offset to sport->port.membase...

--
Stefan

>  
>  struct lpuart_port {
>  	struct uart_port	port;
> @@ -263,6 +267,7 @@ struct lpuart_port {
>  struct lpuart_soc_data {
>  	bool	is_32;
>  	bool	is_be;
> +	u8	reg_off;
>  };
>  
>  static struct lpuart_soc_data vf_data = {
> @@ -272,11 +277,19 @@ static struct lpuart_soc_data vf_data = {
>  static struct lpuart_soc_data ls_data = {
>  	.is_32 = true,
>  	.is_be = true,
> +	.reg_off = 0x0,
> +};
> +
> +static struct lpuart_soc_data imx_data = {
> +	.is_32 = true,
> +	.is_be = false,
> +	.reg_off = IMX_REG_OFF,
>  };
>  
>  static const struct of_device_id lpuart_dt_ids[] = {
>  	{ .compatible = "fsl,vf610-lpuart", .data = &vf_data, },
>  	{ .compatible = "fsl,ls1021a-lpuart", .data = &ls_data, },
> +	{ .compatible = "fsl,imx7ulp-lpuart", .data = &imx_data, },
>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, lpuart_dt_ids);
> @@ -286,15 +299,16 @@ static void lpuart_dma_tx_complete(void *arg);
>  
>  static u32 lpuart32_read(void __iomem *addr)
>  {
> -	return lpuart_is_be ? ioread32be(addr) : readl(addr);
> +	return lpuart_is_be ? ioread32be(addr + lpuart_reg_off) :
> +			      readl(addr + lpuart_reg_off);
>  }
>  
>  static void lpuart32_write(u32 val, void __iomem *addr)
>  {
>  	if (lpuart_is_be)
> -		iowrite32be(val, addr);
> +		iowrite32be(val, addr + lpuart_reg_off);
>  	else
> -		writel(val, addr);
> +		writel(val, addr + lpuart_reg_off);
>  }
>  
>  static void lpuart_stop_tx(struct uart_port *port)
> @@ -2008,6 +2022,7 @@ static int lpuart_probe(struct platform_device *pdev)
>  	sport->port.line = ret;
>  	sport->lpuart32 = sdata->is_32;
>  	lpuart_is_be = sdata->is_be;
> +	lpuart_reg_off = sdata->reg_off;
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	sport->port.membase = devm_ioremap_resource(&pdev->dev, res);
