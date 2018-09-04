From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 1/2] tty: serial: imx: add lock for registers save/restore
Date: Tue, 4 Sep 2018 22:32:05 +0200
Message-ID: <20180904203205.yboqvzkkrm6g7go5@pengutronix.de>
References: <1533809169-24133-1-git-send-email-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1533809169-24133-1-git-send-email-Anson.Huang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Anson Huang <Anson.Huang@nxp.com>
Cc: gregkh@linuxfoundation.org, jslaby@suse.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Linux-imx@nxp.com
List-Id: linux-serial@vger.kernel.org

Hello,

On Thu, Aug 09, 2018 at 06:06:08PM +0800, Anson Huang wrote:
> In noirq suspend/resume stage with no_console_suspend enabled,
> .imx_console_write() may be called to print out log_buf
> message by .printk(), so there will be race condition between
> .imx_console_write() and .serial_imx_save/restore_context(),
> need to add lock to protect the registers save/restore operations.

The function names changes some time ago. Also I'd drop the leading dots
in the names which I would understand as members in a struct.

Is this a theoretical issue, or did you see actual breakage?

> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  drivers/tty/serial/imx.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 239c0fa..a09ccef 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -2376,9 +2376,12 @@ static int imx_uart_remove(struct platform_device *pdev)
>  
>  static void imx_uart_restore_context(struct imx_port *sport)
>  {
> +	unsigned long flags;
> +
>  	if (!sport->context_saved)
>  		return;

Is it safe to check .context_saved without holding the lock?

> +	spin_lock_irqsave(&sport->port.lock, flags);
>  	imx_uart_writel(sport, sport->saved_reg[4], UFCR);
>  	imx_uart_writel(sport, sport->saved_reg[5], UESC);
>  	imx_uart_writel(sport, sport->saved_reg[6], UTIM);
> @@ -2390,11 +2393,15 @@ static void imx_uart_restore_context(struct imx_port *sport)
>  	imx_uart_writel(sport, sport->saved_reg[2], UCR3);
>  	imx_uart_writel(sport, sport->saved_reg[3], UCR4);
>  	sport->context_saved = false;
> +	spin_unlock_irqrestore(&sport->port.lock, flags);
>  }
>  
>  static void imx_uart_save_context(struct imx_port *sport)
>  {
> +	unsigned long flags;
> +
>  	/* Save necessary regs */
> +	spin_lock_irqsave(&sport->port.lock, flags);
>  	sport->saved_reg[0] = imx_uart_readl(sport, UCR1);
>  	sport->saved_reg[1] = imx_uart_readl(sport, UCR2);
>  	sport->saved_reg[2] = imx_uart_readl(sport, UCR3);
> @@ -2406,6 +2413,7 @@ static void imx_uart_save_context(struct imx_port *sport)
>  	sport->saved_reg[8] = imx_uart_readl(sport, UBMR);
>  	sport->saved_reg[9] = imx_uart_readl(sport, IMX21_UTS);
>  	sport->context_saved = true;
> +	spin_unlock_irqrestore(&sport->port.lock, flags);
>  }
>  
>  static void imx_uart_enable_wakeup(struct imx_port *sport, bool on)

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
