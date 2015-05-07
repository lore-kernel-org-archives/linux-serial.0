From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] serial: imx: Revert "initialized DMA w/o HW flow enabled"
Date: Thu, 7 May 2015 20:17:19 -0300
Message-ID: <CAOMZO5Dvv2oMujUqtXg0QXZ-VNbwKuRTCOVfcfNYzgWLkHZ1NA@mail.gmail.com>
References: <20150507202439.GA4717@breakpoint.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150507202439.GA4717@breakpoint.cc>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, jiwang <jiada_wang@mentor.com>, Jiri Slaby <jslaby@suse.cz>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, anton_bondarenko@mentor.com, Dirk Behme <dirk.behme@de.bosch.com>, Nicolae Rosia <nicolae.rosia@gmail.com>, Fabio Estevam <fabio.estevam@freescale.com>
List-Id: linux-serial@vger.kernel.org

On Thu, May 7, 2015 at 5:24 PM, Sebastian Andrzej Siewior
<sebastian@breakpoint.cc> wrote:
> From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>
> This basically reverts commit 068500e08dc8 ("serial: imx: initialized
> DMA w/o HW flow enabled") simply because it does not work as expected
> without additional magic which I am not aware of. The DMA mode is only
> used for non-console UARTs so the "standard" boot test won't notice this.
>
> I tested it on various IMX6 (S and Q) boards and the default SDMA firmware
> that is included in ROM does work properly. The SDMA interrupt counter does

Here you say that the ROM SDMA works properly.

> not stop increment (which means the SDMA does not stop working or the ACK
> is working) and I see a lot of 0x00 (sometimes other bytes) which are added
> to the tty buffer which are not part of the data transfer.
> Jiada claimed that there is a firmware which makes it work but failed to
> provide me a link to the firmware. All he said was that it can not be
> shipped as part of the kernel due to license issues. I've found a firmware
> blob in the FSL-tree but this firmware causes only TTY-overflows an *no*
> data is transmitted.
>
> Currently I see no other way out.
>
> Fixes: 068500e08dc8 ("serial: imx: initialized DMA w/o HW flow enabled")
> Cc: Fabio Estevam <fabio.estevam@freescale.com>
> Cc: Jiada Wang <jiada_wang@mentor.com>
> Cc: nicolae.rosia@gmail.com
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  drivers/tty/serial/imx.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 8aff0b4d8ddf..e686c75fa4dc 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -1113,11 +1113,6 @@ static int imx_startup(struct uart_port *port)
>
>         writel(temp & ~UCR4_DREN, sport->port.membase + UCR4);
>
> -       /* Can we enable the DMA support? */
> -       if (is_imx6q_uart(sport) && !uart_console(port) &&
> -           !sport->dma_is_inited)
> -               imx_uart_dma_init(sport);
> -
>         spin_lock_irqsave(&sport->port.lock, flags);
>         /* Reset fifo's and state machines */
>         i = 100;
> @@ -1308,6 +1303,17 @@ imx_set_termios(struct uart_port *port, struct ktermios *termios,
>                         } else {
>                                 ucr2 |= UCR2_CTSC;
>                         }
> +
> +                       /*
> +                        * Can we enable the DMA support? Be aware that
> +                        * at least IMX6 needs to load external SDMA firmware in
> +                        * order work properly. The in-ROM firmware is not
> +                        * wokring properly.

,but here you say the contrary.

With this fixed (and please also Cc stable):

Reviewed-by: Fabio Estevam <fabio.estevam@freescale.com>
Tested-by: Fabio Estevam <fabio.estevam@freescale.com>
