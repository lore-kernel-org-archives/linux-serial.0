From: Martin Hicks <mort@bork.org>
Subject: Re: [PATCH V2] tty: serial: imx: allow breaks to be received when
 using dma
Date: Tue, 20 Feb 2018 13:01:23 -0500
Message-ID: <20180220180123.GB7751@darwin.bork.org>
References: <20180209212240.14095-1-troy.kisky@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20180209212240.14095-1-troy.kisky@boundarydevices.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Troy Kisky <troy.kisky@boundarydevices.com>
Cc: gregkh@linuxfoundation.org, mort@bork.org, linux-serial@vger.kernel.org, u.kleine-koenig@pengutronix.de, fabio.estevam@nxp.com, linux-arm-kernel@lists.infradead.org, l.stach@pengutronix.de
List-Id: linux-serial@vger.kernel.org

On Fri, Feb 09, 2018 at 01:22:40PM -0800, Troy Kisky wrote:
> This allows me to login after sending a break when service
> serial-getty@ttymxc0.service is running
> 
> Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>

Tested-by:  Martin Hicks <mort@bork.org>

Works for me.
mh

> 
> ---
> v2: rebase only
> 
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 1d7ca382bc12..2eb8c4a20d68 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -927,7 +927,6 @@ static void dma_rx_callback(void *data)
>  	status = dmaengine_tx_status(chan, (dma_cookie_t)0, &state);
>  
>  	if (status == DMA_ERROR) {
> -		dev_err(sport->port.dev, "DMA transaction error.\n");
>  		clear_rx_errors(sport);
>  		return;
>  	}
> @@ -1028,6 +1027,7 @@ static int start_rx_dma(struct imx_port *sport)
>  
>  static void clear_rx_errors(struct imx_port *sport)
>  {
> +	struct tty_port *port = &sport->port.state->port;
>  	unsigned int status_usr1, status_usr2;
>  
>  	status_usr1 = readl(sport->port.membase + USR1);
> @@ -1036,12 +1036,18 @@ static void clear_rx_errors(struct imx_port *sport)
>  	if (status_usr2 & USR2_BRCD) {
>  		sport->port.icount.brk++;
>  		writel(USR2_BRCD, sport->port.membase + USR2);
> -	} else if (status_usr1 & USR1_FRAMERR) {
> -		sport->port.icount.frame++;
> -		writel(USR1_FRAMERR, sport->port.membase + USR1);
> -	} else if (status_usr1 & USR1_PARITYERR) {
> -		sport->port.icount.parity++;
> -		writel(USR1_PARITYERR, sport->port.membase + USR1);
> +		if (tty_insert_flip_char(port, 0, TTY_BREAK) == 0)
> +			sport->port.icount.buf_overrun++;
> +		tty_flip_buffer_push(port);
> +	} else {
> +		dev_err(sport->port.dev, "DMA transaction error.\n");
> +		if (status_usr1 & USR1_FRAMERR) {
> +			sport->port.icount.frame++;
> +			writel(USR1_FRAMERR, sport->port.membase + USR1);
> +		} else if (status_usr1 & USR1_PARITYERR) {
> +			sport->port.icount.parity++;
> +			writel(USR1_PARITYERR, sport->port.membase + USR1);
> +		}
>  	}
>  
>  	if (status_usr2 & USR2_ORE) {
> -- 
> 2.14.1
> 

-- 
Martin Hicks P.Eng.    |      mort@bork.org
Bork Consulting Inc.   |  +1 (613) 266-2296
