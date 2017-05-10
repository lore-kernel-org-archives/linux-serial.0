From: Stefan Agner <stefan@agner.ch>
Subject: Re: [PATCH 2/6] tty: serial: lpuart: add little endian 32 bit
 register support
Date: Tue, 09 May 2017 20:58:47 -0700
Message-ID: <1899c572abd773e375ea9b550cb5e3f2@agner.ch>
References: <1494316248-24052-1-git-send-email-aisheng.dong@nxp.com>
 <1494316248-24052-3-git-send-email-aisheng.dong@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1494316248-24052-3-git-send-email-aisheng.dong@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dong Aisheng <aisheng.dong@nxp.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org, jslaby@suse.com, fugang.duan@nxp.com, Mingkai.Hu@nxp.com, yangbo.lu@nxp.com
List-Id: linux-serial@vger.kernel.org

On 2017-05-09 00:50, Dong Aisheng wrote:
> It's based on the exist lpuart32 read/write implementation.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jslaby@suse.com> (supporter:TTY LAYER)
> Cc: Fugang Duan <fugang.duan@nxp.com>
> Cc: Stefan Agner <stefan@agner.ch>
> Cc: Mingkai Hu <Mingkai.Hu@nxp.com>
> Cc: Yangbo Lu <yangbo.lu@nxp.com>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
>  drivers/tty/serial/fsl_lpuart.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
> index cd4e905..bddd041 100644
> --- a/drivers/tty/serial/fsl_lpuart.c
> +++ b/drivers/tty/serial/fsl_lpuart.c
> @@ -231,6 +231,8 @@
>  #define DEV_NAME	"ttyLP"
>  #define UART_NR		6
>  
> +static bool lpuart_is_be;
> +

Other LS1021a IP's such as SPI use the big-endian device tree property
along with regmap.

See e.g.
drivers/spi/spi-fsl-dspi.c

(Used in vf610 in little endian mode and ls1021a in big endian)

Not sure if we want to switch to regmap, but you can also get the
property using of_get_property.

The ls1021a lpuart node do not specify big-endian at the moment (would
probably good to add it), so I would leave big-endian the driver default
and check for little-endian for the new device and check whether that is
specified:
of_get_property(dn, "little-endian", NULL)

--
Stefan

>  struct lpuart_port {
>  	struct uart_port	port;
>  	struct clk		*clk;
> @@ -260,6 +262,7 @@ struct lpuart_port {
>  
>  struct lpuart_soc_data {
>  	bool	is_32;
> +	bool	is_be;
>  };
>  
>  static struct lpuart_soc_data vf_data = {
> @@ -268,6 +271,7 @@ static struct lpuart_soc_data vf_data = {
>  
>  static struct lpuart_soc_data ls_data = {
>  	.is_32 = true,
> +	.is_be = true,
>  };
>  
>  static const struct of_device_id lpuart_dt_ids[] = {
> @@ -282,12 +286,15 @@ static void lpuart_dma_tx_complete(void *arg);
>  
>  static u32 lpuart32_read(void __iomem *addr)
>  {
> -	return ioread32be(addr);
> +	return lpuart_is_be ? ioread32be(addr) : readl(addr);
>  }
>  
>  static void lpuart32_write(u32 val, void __iomem *addr)
>  {
> -	iowrite32be(val, addr);
> +	if (lpuart_is_be)
> +		iowrite32be(val, addr);
> +	else
> +		writel(val, addr);
>  }
>  
>  static void lpuart_stop_tx(struct uart_port *port)
> @@ -2000,6 +2007,7 @@ static int lpuart_probe(struct platform_device *pdev)
>  	}
>  	sport->port.line = ret;
>  	sport->lpuart32 = sdata->is_32;
> +	lpuart_is_be = sdata->is_be;
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	sport->port.membase = devm_ioremap_resource(&pdev->dev, res);
