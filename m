From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/2] tty: amba-pl011: fix earlycon register offsets
Date: Thu, 24 Dec 2015 16:47:24 +0000
Message-ID: <20151224164723.GK8644@n2100.arm.linux.org.uk>
References: <1450972189-22639-1-git-send-email-timur@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1450972189-22639-1-git-send-email-timur@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Timur Tabi <timur@codeaurora.org>
Cc: peter@hurleysoftware.com, Greg Kroah-Hartman <greg@kroah.com>, Linus Walleij <linus.walleij@linaro.org>, andrew.jackson@arm.com, andre.przywara@arm.com, linux-serial@vger.kernel.org, jslaby@suse.com, shijie.huang@arm.com, jun.nie@linaro.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Thu, Dec 24, 2015 at 09:49:48AM -0600, Timur Tabi wrote:
> The REG_x macros are indices into a table, not register offsets.  Since
> earlycon does not have access to the vendor data, we can currently only
> support standard ARM PL011 devices.
> 
> Signed-off-by: Timur Tabi <timur@codeaurora.org>

Please credit me with the change; this was obviously a change I made
when I posted the updated patches, which Greg had failed to take
instead of the original set.  Thanks.

> ---
>  drivers/tty/serial/amba-pl011.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
> index f6ad383..06f827a 100644
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c
> @@ -2302,10 +2302,10 @@ static struct console amba_console = {
>  
>  static void pl011_putc(struct uart_port *port, int c)
>  {
> -	while (readl(port->membase + REG_FR) & UART01x_FR_TXFF)
> +	while (readl(port->membase + UART01x_FR) & UART01x_FR_TXFF)
>  		;
> -	writeb(c, port->membase + REG_DR);
> -	while (readl(port->membase + REG_FR) & UART01x_FR_BUSY)
> +	writeb(c, port->membase + UART01x_DR);
> +	while (readl(port->membase + UART01x_FR) & UART011_FR_BUSY)
>  		;
>  }
>  
> -- 
> Qualcomm Innovation Center, Inc.
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project.
> 

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
