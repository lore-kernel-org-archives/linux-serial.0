From: Huang Shijie <shijie.huang@arm.com>
Subject: Re: [PATCH 1/2] tty: amba-pl011: fix earlycon register offsets
Date: Fri, 25 Dec 2015 01:56:41 +0000
Message-ID: <20151225015640.GB26561@robwan01-pc.asiapac.arm.com>
References: <1450972189-22639-1-git-send-email-timur@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1450972189-22639-1-git-send-email-timur@codeaurora.org>
Content-Disposition: inline
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
Cc: peter@hurleysoftware.com, Greg Kroah-Hartman <greg@kroah.com>, Linus Walleij <linus.walleij@linaro.org>, andrew.jackson@arm.com, andre.przywara@arm.com, linux-serial@vger.kernel.org, jslaby@suse.com, Russell King <rmk+kernel@arm.linux.org.uk>, jun.nie@linaro.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Thu, Dec 24, 2015 at 09:49:48AM -0600, Timur Tabi wrote:
> The REG_x macros are indices into a table, not register offsets.  Since
> earlycon does not have access to the vendor data, we can currently only
> support standard ARM PL011 devices.
>
> Signed-off-by: Timur Tabi <timur@codeaurora.org>
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
> -     while (readl(port->membase + REG_FR) & UART01x_FR_TXFF)
> +     while (readl(port->membase + UART01x_FR) & UART01x_FR_TXFF)
>               ;
> -     writeb(c, port->membase + REG_DR);
> -     while (readl(port->membase + REG_FR) & UART01x_FR_BUSY)
> +     writeb(c, port->membase + UART01x_DR);
> +     while (readl(port->membase + UART01x_FR) & UART011_FR_BUSY)
I changed the UART011_FR_BUSY with UART01x_FR_BUSY, the console is okay
now.

So after you change the UART011_FR_BUSY to UART01x_FR_BUSY in the next
version, please add my test-by :
      Tested-by: Huang Shijie <shijie.huang@arm.com>

thanks
Huang Shijie
IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.
