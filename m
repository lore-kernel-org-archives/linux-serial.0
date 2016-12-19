From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] serial: 8250: Avoid "too much work" from bogus rx
 timeout interrupt
Date: Mon, 19 Dec 2016 14:59:36 +0200
Message-ID: <1482152376.9552.96.camel@linux.intel.com>
References: <1482110067-5591-1-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1482110067-5591-1-git-send-email-dianders@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Douglas Anderson <dianders@chromium.org>, gregkh@linuxfoundation.org, jslaby@suse.com
Cc: briannorris@chromium.org, linux-rockchip@lists.infradead.org, jeffy.chen@rock-chips.com, eric.gao@rock-chips.com, peter@hurleysoftware.com, phillip.raffeck@fau.de, anton.wuerfel@fau.de, yegorslists@googlemail.com, matwey@sai.msu.ru, tthayer@opensource.altera.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Sun, 2016-12-18 at 17:14 -0800, Douglas Anderson wrote:
> On a Rockchip rk3399-based board during suspend/resume testing, we
> found that we could get the console UART into a state where it would
> print this to the console a lot:
>   serial8250: too much work for irq42

Have you read the following discussion
https://www.spinics.net/lists/kernel/msg2059543.html


> 
> Followed eventually by:
>   NMI watchdog: BUG: soft lockup - CPU#0 stuck for 11s!
> 
> Upon debugging I found that we're in this state:
>   iir = 0x000000cc
>   lsr = 0x00000060
> 
> It appears that somehow we have a RX Timeout interrupt but there is no
> actual data present to receive.  When we're in this state the UART
> driver claims that it handled the interrupt but it actually doesn't
> really do anything.  This means that we keep getting the interrupt
> over and over again.
> 
> Normally we don't actually need to do anything special to handle a RX
> Timeout interrupt.  We'll notice that there is some data ready and
> we'll read it, which will end up clearing the RX Timeout.  In this
> case we have a problem specifically because we got the RX TImeout
> without any data.  Reading a bogus byte is confirmed to get us out of
> this state.
> 
> It's unclear how exactly the UART got into this state, but it is known
> that the UART lines are essentially undriven and unpowered during
> suspend, so possibly during resume some garbage / half transmitted
> bits are seen on the line and put the UART into this state.
> 
> The UART on the rk3399 is a DesignWare based 8250 UART but I have
> placed this fix in the general 8250 code because it shouldn't hurt to
> have this detection on all 8250 UARTs and it's plausible some other
> UART could get into the same state.  If these two extra lines of code
> are too much overhead, we can certainly move it into the DesignWare
> driver or even only do it for Rockchip UARTs.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> Testing and development done on a kernel-4.4 based tree, then picked
> to ToT, where the code applied cleanly.
> 
>  drivers/tty/serial/8250/8250_port.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/tty/serial/8250/8250_port.c
> b/drivers/tty/serial/8250/8250_port.c
> index fe4399b41df6..8582c068c3d1 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -1824,6 +1824,12 @@ int serial8250_handle_irq(struct uart_port
> *port, unsigned int iir)
>  	if (status & (UART_LSR_DR | UART_LSR_BI)) {
>  		if (!up->dma || handle_rx_dma(up, iir))
>  			status = serial8250_rx_chars(up, status);
> +	} else if ((iir & 0x3f) == UART_IIR_RX_TIMEOUT) {
> +		/*
> +		 * On some systems we saw the timeout interrupt even
> when
> +		 * there was no data ready.  Do a bogus read to clear
> it.
> +		 */
> +		(void) serial_port_in(port, UART_RX);
>  	}
>  	serial8250_modem_status(up);
>  	if ((!up->dma || up->dma->tx_err) && (status &
> UART_LSR_THRE))

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
