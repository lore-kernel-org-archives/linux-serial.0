From: Richard Genoud <richard.genoud@gmail.com>
Subject: Re: Fractional divider on the Atmel USART controller
Date: Mon, 6 Feb 2017 14:47:12 +0100
Message-ID: <d3562d2c-3402-4dfa-bb84-f4cce684df34@gmail.com>
References: <CAGkQfmNshOGWT8Vs_J-49qq2UHoCMJ8cYb9jbjaDqM2YNy05rg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAGkQfmNshOGWT8Vs_J-49qq2UHoCMJ8cYb9jbjaDqM2YNy05rg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Romain Izard <romain.izard.pro@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Ludovic Desroches <ludovic.desroches@atmel.com>, Nicolas Ferre <nicolas.ferre@microchip.com>
List-Id: linux-serial@vger.kernel.org

Hi Romain,
On 06/02/2017 12:56, Romain Izard wrote:
> Hello,
> 
> On Atmel SAMA5D2, when trying to configure a serial port for 3 Mbauds
> operation, I do not always get the requested baud rate. If the hardware
> flow control is disabled by software, the line works correctly. But if I
> set the crtscts option, the line does not work, and after checking the
> line I can observe that the signal is sent at 2.6 Mbauds.
> 
> This is due to the code used to manage fractional baud rate divisor: the
> existing code prevents the fractional bits from being used if the line
> is not configured in normal mode. This case occurs when the hardware
> flow control or the RS485 mode is set.
> 
> If I apply the following patch to drivers/tty/serial/atmel_serial.c,
> I get the required baudrate.
> 
> 8<----------------------------------------------------------------
> 
> @@ -2204,14 +2204,13
>       * baudrate = selected clock / (8 * (2 - OVER) * (CD + FP / 8))
>       * Currently, OVER is always set to 0 so we get
>       * baudrate = selected clock / (16 * (CD + FP / 8))
>       * then
>       * 8 CD + FP = selected clock / (2 * baudrate)
>       */
> -    if (atmel_port->has_frac_baudrate &&
> -        (mode & ATMEL_US_USMODE) == ATMEL_US_USMODE_NORMAL) {
> +    if (atmel_port->has_frac_baudrate) {
>          div = DIV_ROUND_CLOSEST(port->uartclk, baud * 2);
>          cd = div >> 3;
>          fp = div & ATMEL_US_FP_MASK;
>      } else {
>          cd = uart_get_divisor(port, baud);
>      }
> 
> 8<----------------------------------------------------------------
> 
> Unfortunately, I know that this will work on SAMA5D2, but this driver is
> used for many other Atmel chips. I do not know if the existing code is
> meant to respect a known limitation on other devices that use the same
> controller, or if it is just a bug.
> 
> Ludovic, Nicolas,  what is your opinion on that matter? Should I just
> propose this as a patch, or is it necessary to add a limitation for
> supported devices only ?
> 
> Best regards,
> 
Looking at the SAMA5D3 datasheet §44.7.1.2 Fractional Baud Rate in
Asynchronous Mode :
[...] This feature is only available when using USART
normal mode.
Same for SAM9G20 (§31.6.1.3 Fractional Baud Rate in Asynchronous Mode)

But this restriction doesn't seem to apply for SAMA5D2.
I guess it's a new feature in the FLEXCOM.

So, yes, your patch will break existing platforms, but something should
definitely be done to make that work on SAMA5D2.

One way to do that would be to modify the has_frac_baudrate into an enum
(no_support, partial_support and full_support) and then fill the value
according to the ATMEL_US_NAME/ATMEL_US_VERSION.
But I'm not sure if we have enough information to sort this.
I'll have a look on the different name/version we have on sama5D2 / D3 /
g20.

Richard.
