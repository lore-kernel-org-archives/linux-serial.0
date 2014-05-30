From: Huang Shijie <b32955@freescale.com>
Subject: Re: [PATCH 2/2] serial: imx: disable the receiver ready interrupt
 for imx_stop_rx
Date: Fri, 30 May 2014 12:53:46 +0800
Message-ID: <20140530045344.GA13338@shlinux1.ap.freescale.net>
References: <1400819575-20435-1-git-send-email-b32955@freescale.com>
 <1400819575-20435-2-git-send-email-b32955@freescale.com>
 <53881C99.1090207@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <53881C99.1090207@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dirk Behme <dirk.behme@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Fri, May 30, 2014 at 07:52:25AM +0200, Dirk Behme wrote:
> On 23.05.2014 06:32, Huang Shijie wrote:
> >This patch disables the receiver ready interrupt for imx_stop_rx.
> >It reduces the interrupt numbers when the uart is going to close
> >or suspend.
> >
> >Signed-off-by: Huang Shijie <b32955@freescale.com>
> >---
> >  drivers/tty/serial/imx.c |    4 ++++
> >  1 files changed, 4 insertions(+), 0 deletions(-)
> >
> >diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> >index ed6cdf7..6026101 100644
> >--- a/drivers/tty/serial/imx.c
> >+++ b/drivers/tty/serial/imx.c
> >@@ -440,6 +440,10 @@ static void imx_stop_rx(struct uart_port *port)
> >
> >  	temp = readl(sport->port.membase + UCR2);
> >  	writel(temp & ~UCR2_RXEN, sport->port.membase + UCR2);
> >+
> >+	/* disable the `Receiver Ready Interrrupt` */
> >+	temp = readl(sport->port.membase + UCR1);
> >+	writel(temp & ~UCR1_RRDYEN, sport->port.membase + UCR1);
> 
> Will this change cause a loss or a processing delay of RX characters
> pending in the RX FIFO ?
> 
> It is not clear whether disabling the receiver will clear the RX
> FIFO. My guess is that the contents of the RX FIFO will remain
> intact when the receiver is disabled. The RX interrupt has an
> opportunity to mop up these pending characters in the RX FIFO but
> disabling the RX interrupt has potential to leave those characters
> in the RX FIFO. Does it matter ?
When the @stop_rx() is called, the system(or the application) is closing
or suspending, and it has decided to abandon the RX data. 

So i think it do not matter the RX FIFO has some left data.
We will reset the RX FIFO when the UART port is re-started again.

thanks
Huang Shijie
