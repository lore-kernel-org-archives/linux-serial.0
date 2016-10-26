From: Richard Genoud <richard.genoud@gmail.com>
Subject: Re: [PATCH] tty/serial: at91: fix hardware handshake on Atmel
 platforms
Date: Wed, 26 Oct 2016 16:55:02 +0200
Message-ID: <f89c29e4-b68f-a8ea-cefb-e70dda6739a0@gmail.com>
References: <20161025161135.7316-1-richard.genoud@gmail.com>
 <20161025171754.a4lult2ld3gv5a2q@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161025171754.a4lult2ld3gv5a2q@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Cyrille Pitchen <cyrille.pitchen@atmel.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On 25/10/2016 19:17, Uwe Kleine-König wrote:
> Hello,
> 
> On Tue, Oct 25, 2016 at 06:11:35PM +0200, Richard Genoud wrote:
>> commit 1cf6e8fc8341 ("tty/serial: at91: fix RTS line management when
>> hardware handshake is enabled"), despite its title, broke hardware
>> handshake on *every* Atmel platforms.
> 
> s/platforms/platform/
fixed.
>> The only one partially working is the SAMA5D2.
>>
>> To understand why, one has to understand the flag ATMEL_US_USMODE_HWHS
>> first:
>> Before commit 1cf6e8fc8341 ("tty/serial: at91: fix RTS line management
>> when hardware handshake is enabled"), this flag was never set.
>> Thus, the CTS/RTS where only handled by serial_core (and everything
>> worked just fine).
>>
>> This commit introduced the use of the ATMEL_US_USMODE_HWHS flag,
>> enabling it for all boards when the user space enables flow control.
>>
>> When the ATMEL_US_USMODE_HWHS is set, the Atmel USART controller
>> handles a part of the flow control job:
>> - disable the transmitter when the CTS pin gets high.
>> - drive the RTS pin high when the DMA buffer transfer is completed or
>>   PDC RX buffer full or RX FIFO is beyond threshold. (depending on the
>>   controller version).
> 
> I don't understand the DMA buffer part.
see below.

> 
>> NB: This feature is *not* mandatory for the flow control to work.
>>
>> Now, the specifics of the ATMEL_US_USMODE_HWHS flag:
>>
>> - For platforms with DMAC and no FIFOs (sam9x25, sam9x35, sama5D3,
>> sama5D4, sam9g15, sam9g25, sam9g35)* this feature simply doesn't work.
>> ( source: https://lkml.org/lkml/2016/9/7/598 )
> 
> What does "doesn't work" mean? Is ATMEL_US_USMODE_HWHS a noop, or does
> it break something?
Here is what the datasheet says:
"The RTS pin is driven high if the receiver is disabled or if the DMA
status flag indicates that the buffer transfer is completed.[...]
As soon as the receiver is enabled, the RTS falls, indicating to the
remote device that it can start transmitting. Defining a new transfer
descriptor in the DMA clears the status flag and, as a result, asserts
the pin RTS low."

And what's really happening:
RTS pin is stuck at high level.
Even if the receiver is enabled, or if there's a new descriptor is
the DMA, RTS is always high.

And if RTS is high, nothing can be received.
(RTS==1 means NOT ready to receive).

So it's definitely not a noop, since RX is blocked.

> 
>> Tested it on sam9g35, the RTS pins always stays up, even when RXEN=1
>> or a new DMA transfer descriptor is set.
>> => ATMEL_US_USMODE_HWHS should not be used for those platforms
> 
> Depending on the answer to the above question it might not matter if it
> is set or not.
> 
>> - For platforms with a PDC (sam926{0,1,3}, sam9g10, sam9g20, sam9g45,
>> sam9g46)*, there's another kind of problem. Once the flag
>> ATMEL_US_USMODE_HWHS is set, the RTS pin can't be driven anymore via
>> RTSEN/RTSDIS in USART Control Register. The RTS pin can only be driven
>> by enabling/disabling the receiver or setting RCR=RNCR=0 in the PDC
>> (Receive (Next) Counter Register).
>> => Doing this is beyond the scope of this patch and could add other
>> bugs, so the original (and working) behaviour should be set for those
>> platforms (meaning ATMEL_US_USMODE_HWHS flag should be unset).
> 
> Then maybe just revert the faulty patch for now and do it better later
> on top of this?

Well, we can't just revert 1cf6e8fc8341 without breaking sama5d2 platform.
And at the end, reverting 1cf6e8fc8341 without breaking sama5d2 will result
in a patch exactly like (or at least *very* similar to) this one.

>> - For platforms with a FIFO (sama5d2)*, the RTS pin is driven according
>> to the RX FIFO thresholds, and can be also driven by RTSEN/RTSDIS in
>> USART Control Register. No problem here.
>> (This was the use case of commit 1cf6e8fc8341 ("tty/serial: at91: fix
>> RTS line management when hardware handshake is enabled"))
>> NB: If the CTS pin declared as a GPIO in the DTS, (for instance
>> cts-gpios = <&pioA PIN_PB31 GPIO_ACTIVE_LOW>), the transmitter will be
>> disabled.
>> => ATMEL_US_USMODE_HWHS flag can be set for this platform ONLY IF the
>> CTS pin is not a GPIO.
> 
> How did you test this? What I consider interesting here is if the
> hardware CTS function was muxed on a pin and in which state this pin (if
> any) is. If it is not muxed anywhere and disables the transmitter
> because of an internal pull up that is IMHO a hw bug and should be
> mentioned more explicitly in the comment.

I see your point, and I did some more tests.
NB: The CTS pin is PD29 (on flx2 on sama5D2).
- If I use PD24 as CTS-gpio for flx2 and PD29 is not muxed (so, as an input):
The transmitter is disabled no matter what value PD24 or PD29 are.
In the same use case, if PD29 is exported as GPIO (output), the transmitter stay disabled for every value.
- If I use PD24 as CTS-gpio for flx2 and PD39 is muxed as another function (I tried TWD0), the transmitter is also disabled.
- If I use PD24 as CTS-gpio for flx2 and PD29 is muxed as CTS function, I can activate the transmitter by setting PD29 to 0V.
- If I use PD29 as CTS-gpio, the transmitter is still disabled.

In all this tests, if I do:
devmem2 0xFC010204 w 0xC00008C0
i.e. remove the ATMEL_US_USMODE_HWHS flag in flx2 usart, the transmitter starts transmitting.

So, I guess, like you said, that there's an internal pull-up on the CTS input.
I can add some comment about that.

>> So, the only case when ATMEL_US_USMODE_HWHS can be enabled is when
>> (atmel_use_fifo(port) &&
>>  !mctrl_gpio_to_gpiod(atmel_port->gpios, UART_GPIO_CTS))
>>
>> Tested on all Atmel USART controller flavours:
>>  AT91SAM9G35-CM, AT91SAM9G20-EK and SAMA5D2xplained
>>       ^^^^           ^^^^               ^^^^
>>   (DMAC flavour), (PDC flavour) and (FIFO flavour)
> 
> I'd write that as: Tested on all Atmel USART controller flavours:
> AT91SAM9G35-CM (DMAC flavour), AT91SAM9G20-EK (PDC flavour),
> SAMA5D2xplained (FIFO flavour).

alright.

>> Changes since v4:
>>  - the mctrl_gpio_use_rtscts() is gone since it was atmel_serial
>>  specific. (so patch 1 is gone)
>>  - patches 2 and 3 have been merged together since it didn't make
>>  a lot of sense to correct the GPIO case in one separate patch.
>>  - ATMEL_US_USMODE_HWHS is now unset for platform with PDC
>>
>> Changes since v3:
>>  - remove superfluous #include <linux/err.h> (thanks to Uwe)
>>  - rebase on next-20160930
>>
>> Changes since v2:
>>  - remove IS_ERR_OR_NULL() test in patch 1/3 as Uwe suggested.
>>  - fix typos in patch 2/3
>>  - rebase on next-20160927
>>  - simplify the logic in patch 3/3.
>>
>> Changes since v1:
>>  - Correct patch 1 with the error found by kbuild.
>>  - Add Alexandre's Acked-by on patch 2
>>  - Rewrite patch 3 logic in the light of the on-going discussion
>>    with Cyrille and Alexandre.
>>
>> * the list may not be exhaustive
> 
> Add a Fixes: line please.

ok.
>> Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
>> ---
>>  drivers/tty/serial/atmel_serial.c | 25 +++++++++++++++++++++----
>>  1 file changed, 21 insertions(+), 4 deletions(-)
>>
>>  I think this should go in the stable tree since it fixes the flow
>>  control broken since v4.0.
>>  But It won't compile on versions before 4.9rc1 because:
>>  function atmel_use_fifo was introduced in 4.4.12 / 4.7
>>  variable atmel_port was introduced in 4.9rc1
>>
>>  That's why I didn't add the Cc stable in the email body.
>>
>>
>> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
>> index fd8aa1f4ba78..2c7c45904ba7 100644
>> --- a/drivers/tty/serial/atmel_serial.c
>> +++ b/drivers/tty/serial/atmel_serial.c
>> @@ -2132,11 +2132,28 @@ static void atmel_set_termios(struct uart_port *port, struct ktermios *termios,
>>  		mode |= ATMEL_US_USMODE_RS485;
>>  	} else if (termios->c_cflag & CRTSCTS) {
>>  		/* RS232 with hardware handshake (RTS/CTS) */
>> -		if (atmel_use_dma_rx(port) && !atmel_use_fifo(port)) {
>> -			dev_info(port->dev, "not enabling hardware flow control because DMA is used");
>> -			termios->c_cflag &= ~CRTSCTS;
> 
> This if was not introduced in commit 1cf6e8fc8341. Is it still right to
> remove this here?

This was introduced by commit 5be605ac9af9 that tried to fix
commit 1cf6e8fc8341 but based on a false assumption.

Quote from the commit message:
"   Commit 1cf6e8fc8341 ("tty/serial: at91: fix RTS line management when
    hardware handshake is enabled") actually allowed to enable hardware
    handshaking.
    Before, the CRTSCTS flags was silently ignored.
"
This wasn't true.
This was a misunderstanding of the ATMEL_US_USMODE_HWHS flag:
Commit 1cf6e8fc8341 didn't allowed to enable hardware handshaking, but
introduced the ATMEL_US_USMODE_HWHS flag.
And before 1cf6e8fc8341, the CRTSCTS flags wasn't silently ignored, it
was perfectly respected.

So, yes, I'm quite comfortable removing those lines here.
(maybe I should add a Fixes: 5be605ac9af9 ?)

Otherwise, we can do it the hard way, and:
- revert 5be605ac9af9 ("tty/serial: atmel: fix hardware handshake selection)"
- then apply something like:
 		mode |= ATMEL_US_USMODE_RS485;
 	} else if (termios->c_cflag & CRTSCTS) {
 		/* RS232 with hardware handshake (RTS/CTS) */
-		mode |= ATMEL_US_USMODE_HWHS;
+		if (atmel_use_fifo(port) &&
+		    !mctrl_gpio_to_gpiod(atmel_port->gpios, UART_GPIO_CTS)) {
+			mode |= ATMEL_US_USMODE_HWHS;
+		} else {
+			mode |= ATMEL_US_USMODE_NORMAL;
+		}
 	} else {
 		/* RS232 without hadware handshake */
 		mode |= ATMEL_US_USMODE_NORMAL;

Or even harder:
- revert 5be605ac9af9 ("tty/serial: atmel: fix hardware handshake selection)"
- then apply something like:
 	if (port->rs485.flags & SER_RS485_ENABLED) {
 		atmel_uart_writel(port, ATMEL_US_TTGR,
 				  port->rs485.delay_rts_after_send);
 		mode |= ATMEL_US_USMODE_RS485;
-	} else if (termios->c_cflag & CRTSCTS) {
-		/* RS232 with hardware handshake (RTS/CTS) */
-		mode |= ATMEL_US_USMODE_HWHS;
-	} else {
-		/* RS232 without hadware handshake */
+	} else {
 		mode |= ATMEL_US_USMODE_NORMAL;
	}
(at this point, every platform will work with flow control without problem)
- and finally introduce the ATMEL_US_USMODE_HWHS flag for platforms with FIFO:
 	if (port->rs485.flags & SER_RS485_ENABLED) {
 		atmel_uart_writel(port, ATMEL_US_TTGR,
 				  port->rs485.delay_rts_after_send);
 		mode |= ATMEL_US_USMODE_RS485;
 	} else {
-		mode |= ATMEL_US_USMODE_NORMAL;
+		if (termios->c_cflag & CRTSCTS) &&
+		    atmel_use_fifo(port) &&
+		    !mctrl_gpio_to_gpiod(atmel_port->gpios, UART_GPIO_CTS)) {
+			mode |= ATMEL_US_USMODE_HWHS;
+		} else {
+			mode |= ATMEL_US_USMODE_NORMAL;
+		}
	}


> 
>> -		} else {
>> +		if (atmel_use_fifo(port) &&
>> +		    !mctrl_gpio_to_gpiod(atmel_port->gpios, UART_GPIO_CTS)) {
>> +			/*
>> +			 * with ATMEL_US_USMODE_HWHS set, the controller will
>> +			 * be able to drive the RTS pin high/low when the RX
>> +			 * FIFO is above RXFTHRES/below RXFTHRES2.
>> +			 * It will also disable the transmitter when the CTS
>> +			 * pin is high.
>> +			 * This mode is not activated if CTS pin is a GPIO
>> +			 * because in this case, the transmitter is always
>> +			 * disabled.
>> +			 * If the RTS pin is a GPIO, the controller won't be
>> +			 * able to drive it according to the FIFO thresholds,
>> +			 * but it will be handled by the driver.
>> +			 */
>>  			mode |= ATMEL_US_USMODE_HWHS;
>> +		} else {
>> +			/*
>> +			 * For platforms without FIFO, the flow control is
>> +			 * handled by the driver.
>> +			 */
>> +			mode |= ATMEL_US_USMODE_NORMAL;
>>  		}
>>  	} else {
>>  		/* RS232 without hadware handshake */
> 
> (unrelated to this patch) s/hadware/hardware/
> 
I plan to to some janitor work on this driver, I'll add it then.

Thanks.
Richard.
