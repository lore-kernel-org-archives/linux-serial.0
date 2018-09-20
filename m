From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v1] tty: serial: imx: enable IDDMAEN for the last tail
 data
Date: Thu, 20 Sep 2018 09:55:13 +0200
Message-ID: <20180920075513.6jqfbrrjax3sp4cn@pengutronix.de>
References: <1537457160-10792-1-git-send-email-yibin.gong@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1537457160-10792-1-git-send-email-yibin.gong@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Gong <yibin.gong@nxp.com>
Cc: jslaby@suse.com, fugang.duan@nxp.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-imx@nxp.com, kernel@pengutronix.de
List-Id: linux-serial@vger.kernel.org

Hello,

On Thu, Sep 20, 2018 at 11:26:00PM +0800, Robin Gong wrote:
> enable IDDMAEN in UCR4 to let sdma script has the chance to detect
> the idle status and transfer the last tail data with the interrupt
> notifying uart driver.Otherwise, the last dma done interrupt of the
> tail data in rxfifo whose size is less than watermark may never be
> received by uart driver.

Is this a theoretic issue? Or does it fix a real problem?

If the former I'd say UCR1_ATDMAEN being set should prevent this stall.

Also I'd say the SDMA scripts I know don't properly handle the IDDMA
request.

Best regards
Uwe

> Signed-off-by: Robin Gong <yibin.gong@nxp.com>
> ---
>  drivers/tty/serial/imx.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 239c0fa..bbb1693 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -1278,7 +1278,7 @@ static int imx_uart_dma_init(struct imx_port *sport)
>  
>  static void imx_uart_enable_dma(struct imx_port *sport)
>  {
> -	u32 ucr1;
> +	u32 ucr1, ucr4;
>  
>  	imx_uart_setup_ufcr(sport, TXTL_DMA, RXTL_DMA);
>  
> @@ -1287,18 +1287,26 @@ static void imx_uart_enable_dma(struct imx_port *sport)
>  	ucr1 |= UCR1_RXDMAEN | UCR1_TXDMAEN | UCR1_ATDMAEN;
>  	imx_uart_writel(sport, ucr1, UCR1);
>  
> +	ucr4 = imx_uart_readl(sport, UCR4);
> +	ucr4 |= UCR4_IDDMAEN;
> +	imx_uart_writel(sport, ucr4, UCR4);
> +
>  	sport->dma_is_enabled = 1;
>  }
>  
>  static void imx_uart_disable_dma(struct imx_port *sport)
>  {
> -	u32 ucr1;
> +	u32 ucr1, ucr4;
>  
>  	/* clear UCR1 */
>  	ucr1 = imx_uart_readl(sport, UCR1);
>  	ucr1 &= ~(UCR1_RXDMAEN | UCR1_TXDMAEN | UCR1_ATDMAEN);
>  	imx_uart_writel(sport, ucr1, UCR1);
>  
> +	ucr4 = imx_uart_readl(sport, UCR4);
> +	ucr4 &= ~UCR4_IDDMAEN;
> +	imx_uart_writel(sport, ucr4, UCR4);
> +
>  	imx_uart_setup_ufcr(sport, TXTL_DEFAULT, RXTL_DEFAULT);
>  
>  	sport->dma_is_enabled = 0;
> -- 
> 2.7.4
> 
> 

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
