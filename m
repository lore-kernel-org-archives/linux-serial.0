From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] tty/serial: at91: fix hardware handshake on Atmel
 platforms
Date: Tue, 25 Oct 2016 19:17:54 +0200
Message-ID: <20161025171754.a4lult2ld3gv5a2q@pengutronix.de>
References: <20161025161135.7316-1-richard.genoud@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161025161135.7316-1-richard.genoud@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Genoud <richard.genoud@gmail.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Cyrille Pitchen <cyrille.pitchen@atmel.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Hello,

On Tue, Oct 25, 2016 at 06:11:35PM +0200, Richard Genoud wrote:
> commit 1cf6e8fc8341 ("tty/serial: at91: fix RTS line management when
> hardware handshake is enabled"), despite its title, broke hardware
> handshake on *every* Atmel platforms.

s/platforms/platform/

> The only one partially working is the SAMA5D2.
> 
> To understand why, one has to understand the flag ATMEL_US_USMODE_HWHS
> first:
> Before commit 1cf6e8fc8341 ("tty/serial: at91: fix RTS line management
> when hardware handshake is enabled"), this flag was never set.
> Thus, the CTS/RTS where only handled by serial_core (and everything
> worked just fine).
> 
> This commit introduced the use of the ATMEL_US_USMODE_HWHS flag,
> enabling it for all boards when the user space enables flow control.
> 
> When the ATMEL_US_USMODE_HWHS is set, the Atmel USART controller
> handles a part of the flow control job:
> - disable the transmitter when the CTS pin gets high.
> - drive the RTS pin high when the DMA buffer transfer is completed or
>   PDC RX buffer full or RX FIFO is beyond threshold. (depending on the
>   controller version).

I don't understand the DMA buffer part.

> NB: This feature is *not* mandatory for the flow control to work.
> 
> Now, the specifics of the ATMEL_US_USMODE_HWHS flag:
> 
> - For platforms with DMAC and no FIFOs (sam9x25, sam9x35, sama5D3,
> sama5D4, sam9g15, sam9g25, sam9g35)* this feature simply doesn't work.
> ( source: https://lkml.org/lkml/2016/9/7/598 )

What does "doesn't work" mean? Is ATMEL_US_USMODE_HWHS a noop, or does
it break something?

> Tested it on sam9g35, the RTS pins always stays up, even when RXEN=1
> or a new DMA transfer descriptor is set.
> => ATMEL_US_USMODE_HWHS should not be used for those platforms

Depending on the answer to the above question it might not matter if it
is set or not.

> - For platforms with a PDC (sam926{0,1,3}, sam9g10, sam9g20, sam9g45,
> sam9g46)*, there's another kind of problem. Once the flag
> ATMEL_US_USMODE_HWHS is set, the RTS pin can't be driven anymore via
> RTSEN/RTSDIS in USART Control Register. The RTS pin can only be driven
> by enabling/disabling the receiver or setting RCR=RNCR=0 in the PDC
> (Receive (Next) Counter Register).
> => Doing this is beyond the scope of this patch and could add other
> bugs, so the original (and working) behaviour should be set for those
> platforms (meaning ATMEL_US_USMODE_HWHS flag should be unset).

Then maybe just revert the faulty patch for now and do it better later
on top of this?

> - For platforms with a FIFO (sama5d2)*, the RTS pin is driven according
> to the RX FIFO thresholds, and can be also driven by RTSEN/RTSDIS in
> USART Control Register. No problem here.
> (This was the use case of commit 1cf6e8fc8341 ("tty/serial: at91: fix
> RTS line management when hardware handshake is enabled"))
> NB: If the CTS pin declared as a GPIO in the DTS, (for instance
> cts-gpios = <&pioA PIN_PB31 GPIO_ACTIVE_LOW>), the transmitter will be
> disabled.
> => ATMEL_US_USMODE_HWHS flag can be set for this platform ONLY IF the
> CTS pin is not a GPIO.

How did you test this? What I consider interesting here is if the
hardware CTS function was muxed on a pin and in which state this pin (if
any) is. If it is not muxed anywhere and disables the transmitter
because of an internal pull up that is IMHO a hw bug and should be
mentioned more explicitly in the comment.

> So, the only case when ATMEL_US_USMODE_HWHS can be enabled is when
> (atmel_use_fifo(port) &&
>  !mctrl_gpio_to_gpiod(atmel_port->gpios, UART_GPIO_CTS))
> 
> Tested on all Atmel USART controller flavours:
>  AT91SAM9G35-CM, AT91SAM9G20-EK and SAMA5D2xplained
>       ^^^^           ^^^^               ^^^^
>   (DMAC flavour), (PDC flavour) and (FIFO flavour)

I'd write that as: Tested on all Atmel USART controller flavours:
AT91SAM9G35-CM (DMAC flavour), AT91SAM9G20-EK (PDC flavour),
SAMA5D2xplained (FIFO flavour).

> Changes since v4:
>  - the mctrl_gpio_use_rtscts() is gone since it was atmel_serial
>  specific. (so patch 1 is gone)
>  - patches 2 and 3 have been merged together since it didn't make
>  a lot of sense to correct the GPIO case in one separate patch.
>  - ATMEL_US_USMODE_HWHS is now unset for platform with PDC
> 
> Changes since v3:
>  - remove superfluous #include <linux/err.h> (thanks to Uwe)
>  - rebase on next-20160930
> 
> Changes since v2:
>  - remove IS_ERR_OR_NULL() test in patch 1/3 as Uwe suggested.
>  - fix typos in patch 2/3
>  - rebase on next-20160927
>  - simplify the logic in patch 3/3.
> 
> Changes since v1:
>  - Correct patch 1 with the error found by kbuild.
>  - Add Alexandre's Acked-by on patch 2
>  - Rewrite patch 3 logic in the light of the on-going discussion
>    with Cyrille and Alexandre.
> 
> * the list may not be exhaustive

Add a Fixes: line please.

> Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
> ---
>  drivers/tty/serial/atmel_serial.c | 25 +++++++++++++++++++++----
>  1 file changed, 21 insertions(+), 4 deletions(-)
> 
>  I think this should go in the stable tree since it fixes the flow
>  control broken since v4.0.
>  But It won't compile on versions before 4.9rc1 because:
>  function atmel_use_fifo was introduced in 4.4.12 / 4.7
>  variable atmel_port was introduced in 4.9rc1
> 
>  That's why I didn't add the Cc stable in the email body.
> 
> 
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
> index fd8aa1f4ba78..2c7c45904ba7 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -2132,11 +2132,28 @@ static void atmel_set_termios(struct uart_port *port, struct ktermios *termios,
>  		mode |= ATMEL_US_USMODE_RS485;
>  	} else if (termios->c_cflag & CRTSCTS) {
>  		/* RS232 with hardware handshake (RTS/CTS) */
> -		if (atmel_use_dma_rx(port) && !atmel_use_fifo(port)) {
> -			dev_info(port->dev, "not enabling hardware flow control because DMA is used");
> -			termios->c_cflag &= ~CRTSCTS;

This if was not introduced in commit 1cf6e8fc8341. Is it still right to
remove this here?

> -		} else {
> +		if (atmel_use_fifo(port) &&
> +		    !mctrl_gpio_to_gpiod(atmel_port->gpios, UART_GPIO_CTS)) {
> +			/*
> +			 * with ATMEL_US_USMODE_HWHS set, the controller will
> +			 * be able to drive the RTS pin high/low when the RX
> +			 * FIFO is above RXFTHRES/below RXFTHRES2.
> +			 * It will also disable the transmitter when the CTS
> +			 * pin is high.
> +			 * This mode is not activated if CTS pin is a GPIO
> +			 * because in this case, the transmitter is always
> +			 * disabled.
> +			 * If the RTS pin is a GPIO, the controller won't be
> +			 * able to drive it according to the FIFO thresholds,
> +			 * but it will be handled by the driver.
> +			 */
>  			mode |= ATMEL_US_USMODE_HWHS;
> +		} else {
> +			/*
> +			 * For platforms without FIFO, the flow control is
> +			 * handled by the driver.
> +			 */
> +			mode |= ATMEL_US_USMODE_NORMAL;
>  		}
>  	} else {
>  		/* RS232 without hadware handshake */

(unrelated to this patch) s/hadware/hardware/

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
