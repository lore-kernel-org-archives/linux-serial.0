From: Andre Przywara <andre.przywara@arm.com>
Subject: Re: [PATCH v13 4/5] uart: pl011: Improve LCRH register access decision
Date: Fri, 18 Sep 2015 11:58:56 +0100
Message-ID: <55FBEE70.9090004@arm.com>
References: <1438328959-16177-1-git-send-email-jun.nie@linaro.org>
 <1438328959-16177-5-git-send-email-jun.nie@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1438328959-16177-5-git-send-email-jun.nie@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jun Nie <jun.nie@linaro.org>, "peter@hurleysoftware.com" <peter@hurleysoftware.com>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, Andrew Jackson <Andrew.Jackson@arm.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>
Cc: "jason.liu@linaro.org" <jason.liu@linaro.org>, "wan.zhijun@zte.com.cn" <wan.zhijun@zte.com.cn>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

Hi Jun,

On 31/07/15 08:49, Jun Nie wrote:
> Improve LCRH register access decision as ARM PL011 lcrh
> register serve as both TX and RX, while other SOC may
> implement TX and RX function with separated register.
> 
> Signed-off-by: Jun Nie <jun.nie@linaro.org>
> ---
>  drivers/tty/serial/amba-pl011.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
> index e1f3bd5..017443d 100644
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c
> @@ -249,6 +249,11 @@ struct uart_amba_port {
>  #endif
>  };
>  
> +static bool is_implemented(struct uart_amba_port *uap, unsigned int reg)
> +{
> +	return uap->reg_lut[reg] != (u16)~0;
> +}
> +

Just a nit: is_implemented sounds a bit too generic for me, could this
be more specific like reg_is_implemented or the like?

Other than that the patch looks good to me.

Cheers,
Andre.

>  static unsigned int pl011_readw(struct uart_amba_port *uap, int index)
>  {
>  	WARN_ON(index > REG_NR);
> @@ -1649,7 +1654,7 @@ static int pl011_hwinit(struct uart_port *port)
>  static void pl011_write_lcr_h(struct uart_amba_port *uap, unsigned int lcr_h)
>  {
>  	pl011_writew(uap, lcr_h, uap->lcrh_rx);
> -	if (uap->lcrh_rx != uap->lcrh_tx) {
> +	if (is_implemented(uap, REG_ST_LCRH_RX)) {
>  		int i;
>  		/*
>  		 * Wait 10 PCLKs before writing LCRH_TX register,
> @@ -1784,7 +1789,7 @@ static void pl011_disable_uart(struct uart_amba_port *uap)
>  	 * disable break condition and fifos
>  	 */
>  	pl011_shutdown_channel(uap, uap->lcrh_rx);
> -	if (uap->lcrh_rx != uap->lcrh_tx)
> +	if (is_implemented(uap, REG_ST_LCRH_RX))
>  		pl011_shutdown_channel(uap, uap->lcrh_tx);
>  }
>  
> 
