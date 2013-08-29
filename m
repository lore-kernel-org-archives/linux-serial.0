From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH] serial: imx: initialize the local variable
Date: Thu, 29 Aug 2013 22:12:30 +0800
Message-ID: <20130829141228.GO18729@S2101-09.ap.freescale.net>
References: <1377764965-2000-1-git-send-email-b32955@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-db8lp0188.outbound.messaging.microsoft.com ([213.199.154.188]:45404
	"EHLO db8outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753778Ab3H2OMY (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 29 Aug 2013 10:12:24 -0400
Content-Disposition: inline
In-Reply-To: <1377764965-2000-1-git-send-email-b32955@freescale.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Huang Shijie <b32955@freescale.com>
Cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, Aug 29, 2013 at 04:29:25PM +0800, Huang Shijie wrote:
> The slave_config is not initialized, so some of its fields may
> be set with random data which may causes the failure in the following
> dmaengine_prep_slave_sg().
> 
> This patch fixes this issue.
> 
> Signed-off-by: Huang Shijie <b32955@freescale.com>

Acked-by: Shawn Guo <shawn.guo@linaro.org>

> ---
>  drivers/tty/serial/imx.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 2c13155..a0ebbc9 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -979,7 +979,7 @@ static void imx_uart_dma_exit(struct imx_port *sport)
>  
>  static int imx_uart_dma_init(struct imx_port *sport)
>  {
> -	struct dma_slave_config slave_config;
> +	struct dma_slave_config slave_config = {};
>  	struct device *dev = sport->port.dev;
>  	int ret;
>  
> -- 
> 1.7.1
> 
> 

