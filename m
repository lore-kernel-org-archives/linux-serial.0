From: Richard Genoud <richard.genoud@gmail.com>
Subject: Re: [PATCH] tty/serial: at91: fix hardware handshake on Atmel
 platforms
Date: Wed, 26 Oct 2016 08:52:09 +0200
Message-ID: <7fd48101-2948-6a83-5a0c-5669f3cbbe43@gmail.com>
References: <20161025161135.7316-1-richard.genoud@gmail.com>
 <20161025162247.phhevbtd6dsmknbr@piout.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161025162247.phhevbtd6dsmknbr@piout.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>, Nicolas Ferre <nicolas.ferre@atmel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Cyrille Pitchen <cyrille.pitchen@atmel.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On 25/10/2016 18:22, Alexandre Belloni wrote:
> Hi,
> 
> On 25/10/2016 at 18:11:35 +0200, Richard Genoud wrote :
>> commit 1cf6e8fc8341 ("tty/serial: at91: fix RTS line management when
>> hardware handshake is enabled"), despite its title, broke hardware
>> handshake on *every* Atmel platforms.
>>
>> The only one partially working is the SAMA5D2.
>>
> 
> [...]
> 
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
> 
> The changelog has to go after the --- marker.

You're right.
thanks !
>> * the list may not be exhaustive
>>
>> Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
> 
> Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> 
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
