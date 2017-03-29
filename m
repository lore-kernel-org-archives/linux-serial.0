From: Olliver Schinagl <oliver@schinagl.nl>
Subject: Re: [PATCH v2] serial: 8250_dw: Avoid "too much work" from bogus rx
 timeout interrupt
Date: Wed, 29 Mar 2017 09:58:46 +0200
Message-ID: <obfpfg$h6e$1@blaine.gmane.org>
References: <20170206233000.3021-1-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170206233000.3021-1-dianders@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-rockchip@lists.infradead.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hey Douglas,

On 07-02-17 00:30, Douglas Anderson wrote:
> On a Rockchip rk3399-based board during suspend/resume testing, we
> found that we could get the console UART into a state where it would
> print this to the console a lot:
>   serial8250: too much work for irq42
>
> Followed eventually by:
>   NMI watchdog: BUG: soft lockup - CPU#0 stuck for 11s!
>
> Upon debugging I found that we're in this state:
>   iir = 0x000000cc
>   lsr = 0x00000060
>
> It appears that somehow we have a RX Timeout interrupt but there is no
> actual data present to receive.  When we're in this state the UART
> driver claims that it handled the interrupt but it actually doesn't
> really do anything.  This means that we keep getting the interrupt
> over and over again.

I may be running into the same thing on an A20 SoC, but still in the 
stage of figuring out what is going on, as we get this error very 
occasionally. Do you have a way to externally induce this behavior other 
then suspend/resume? As we get it during uart-use and do not have (or I 
have never tried) suspend/resume on our platform.

>
> Normally we don't actually need to do anything special to handle a RX
> Timeout interrupt.  We'll notice that there is some data ready and
> we'll read it, which will end up clearing the RX Timeout.  In this
> case we have a problem specifically because we got the RX TImeout
> without any data.  Reading a bogus byte is confirmed to get us out of
> this state.
>
> It's unclear how exactly the UART got into this state, but it is known
> that the UART lines are essentially undriven and unpowered during
> suspend, so possibly during resume some garbage / half transmitted
> bits are seen on the line and put the UART into this state.
>
> The UART on the rk3399 is a DesignWare based 8250 UART.  From mailing
> list posts, it appears that other people have run into similar
> problems with DesignWare based IP.  Presumably this problem is unique
> to that IP, so I have placed the workaround there to avoid possibly of
> accidentally triggering bad behavior on other IP.  Also note the RX
> Timeout behaves very differently in the DMA case, for for now the
> workaround is only applied to the non-DMA case.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> Testing and development done on a kernel-4.4 based tree, then picked
> to ToT, where the code applied cleanly.
>
> Changes in v2:
> - Only apply to 8250_dw, not all 8250
> - Only apply to the non-DMA case
>
>  drivers/tty/serial/8250/8250_dw.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
> index c89ae4581378..6ee55a2d47bb 100644
> --- a/drivers/tty/serial/8250/8250_dw.c
> +++ b/drivers/tty/serial/8250/8250_dw.c
> @@ -201,8 +201,31 @@ static unsigned int dw8250_serial_in32be(struct uart_port *p, int offset)
>
>  static int dw8250_handle_irq(struct uart_port *p)
>  {
> +	struct uart_8250_port *up = up_to_u8250p(p);
>  	struct dw8250_data *d = p->private_data;
>  	unsigned int iir = p->serial_in(p, UART_IIR);
> +	unsigned int status;
> +	unsigned long flags;
> +
> +	/*
> +	 * There are ways to get Designware-based UARTs into a state where
> +	 * they are asserting UART_IIR_RX_TIMEOUT but there is no actual
> +	 * data available.  If we see such a case then we'll do a bogus
> +	 * read.  If we don't do this then the "RX TIMEOUT" interrupt will
> +	 * fire forever.
I think what you are saying is 'do a bogus read as that is the only way 
to clear the interrupt, otherwise it will keep firing forever.'?
> +	 *
> +	 * This problem has only been observed so far when not in DMA mode
> +	 * so we limit the workaround only to non-DMA mode.
> +	 */
> +	if (!up->dma && ((iir & 0x3f) == UART_IIR_RX_TIMEOUT)) {
why not
if (!up->dma && ((iir & UART_IIR_RX_TIMEOUT) == UART_IIR_RX_TIMEOUT)) {

it follows the flow as other conditionals in the 8250 source and you 
really only need to mask the specific interrupt anyway.

> +		spin_lock_irqsave(&p->lock, flags);
this is a bit above my knowledge of driver etc, but I don't any 
spinlocks in the 8250 handle_irq glue drivers, except in the OMAP's case 
where they are handeling a DMA IRQ. So I ask, because I don't know, why 
is it needed here?
> +		status = p->serial_in(p, UART_LSR);
> +
> +		if (!(status & (UART_LSR_DR | UART_LSR_BI)))
> +			(void) p->serial_in(p, UART_RX);
I think there should be no space between (void) and p->serial_in
> +
> +		spin_unlock_irqrestore(&p->lock, flags);
> +	}
>
>  	if (serial8250_handle_irq(p, iir))
>  		return 1;
>

Once I found a way to reproduce the problem (without suspend) I will 
test this to see if it fixes it for us too.

Olliver
