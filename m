From: Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: Re: Fractional divider on the Atmel USART controller
Date: Mon, 6 Feb 2017 16:37:23 +0100
Message-ID: <20170206153723.om7yen4laybhkm6d@rfolt0960.corp.atmel.com>
References: <CAGkQfmNshOGWT8Vs_J-49qq2UHoCMJ8cYb9jbjaDqM2YNy05rg@mail.gmail.com>
 <20170206134256.tp5rgx6axd532gp3@rfolt0960.corp.atmel.com>
 <b32aeadb-57a3-f327-e387-e4bb720f9297@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <b32aeadb-57a3-f327-e387-e4bb720f9297@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Genoud <richard.genoud@gmail.com>
Cc: Romain Izard <romain.izard.pro@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Ludovic Desroches <ludovic.desroches@atmel.com>, Nicolas Ferre <nicolas.ferre@microchip.com>
List-Id: linux-serial@vger.kernel.org

On Mon, Feb 06, 2017 at 03:58:52PM +0100, Richard Genoud wrote:
> Hi Ludovic,
> 
> On 06/02/2017 14:42, Ludovic Desroches wrote:
> > Hello Romain,
> > 
> > On Mon, Feb 06, 2017 at 12:56:42PM +0100, Romain Izard wrote:
> >> Hello,
> >>
> >> On Atmel SAMA5D2, when trying to configure a serial port for 3 Mbauds
> >> operation, I do not always get the requested baud rate. If the hardware
> >> flow control is disabled by software, the line works correctly. But if I
> >> set the crtscts option, the line does not work, and after checking the
> >> line I can observe that the signal is sent at 2.6 Mbauds.
> >>
> >> This is due to the code used to manage fractional baud rate divisor: the
> >> existing code prevents the fractional bits from being used if the line
> >> is not configured in normal mode. This case occurs when the hardware
> >> flow control or the RS485 mode is set.
> >>
> >> If I apply the following patch to drivers/tty/serial/atmel_serial.c,
> >> I get the required baudrate.
> >>
> >> 8<----------------------------------------------------------------
> >>
> >> @@ -2204,14 +2204,13
> >>       * baudrate = selected clock / (8 * (2 - OVER) * (CD + FP / 8))
> >>       * Currently, OVER is always set to 0 so we get
> >>       * baudrate = selected clock / (16 * (CD + FP / 8))
> >>       * then
> >>       * 8 CD + FP = selected clock / (2 * baudrate)
> >>       */
> >> -    if (atmel_port->has_frac_baudrate &&
> >> -        (mode & ATMEL_US_USMODE) == ATMEL_US_USMODE_NORMAL) {
> >> +    if (atmel_port->has_frac_baudrate) {
> >>          div = DIV_ROUND_CLOSEST(port->uartclk, baud * 2);
> >>          cd = div >> 3;
> >>          fp = div & ATMEL_US_FP_MASK;
> >>      } else {
> >>          cd = uart_get_divisor(port, baud);
> >>      }
> >>
> >> 8<----------------------------------------------------------------
> >>
> >> Unfortunately, I know that this will work on SAMA5D2, but this driver is
> >> used for many other Atmel chips. I do not know if the existing code is
> >> meant to respect a known limitation on other devices that use the same
> >> controller, or if it is just a bug.
> > 
> > It depends on the device used. In the SAMA5D4 datasheet, it is
> > mentionned: "This feature is only available when using USART normal mode".
> 
> It seems you have an old datasheet version, because in table 60.2 (page 1784) of SAMA5D4 datasheet (rev D), there's :
> 

Right, it seems there was an update of all sama5 datasheet to remove
this constraint. I don't know if it concerns also old devices, I'll try
to get more information.

> Section 43.6.1.2 “Fractional Baud Rate in Asynchronous Mode”: added warning “When the value of field FP
> is greater than 0...”; removed sentence “This feature is only available when using USART normal mode.”
> 
> So I guess this should also work on SAMA5D4 ? 
> 
> 
> > In the SAMA5D2 datasheet, this constraint is no longer mentionned you
> > confirm that is works, that is great.
> > 
> >>
> >> Ludovic, Nicolas,  what is your opinion on that matter? Should I just
> >> propose this as a patch, or is it necessary to add a limitation for
> >> supported devices only ?
> > 
> > Yes, only SAMA5D2 supports fractionnal baudrate in other modes than the
> > normal one. A new compatible string may be added, I am not sure you have
> > enough information in atmel_get_ip_name...
> 
> I checked the version numbers on some atmel platforms I have:
> 
> AT91SAM9G35 / SAMA5D3: 0x502
> AT91SAM9G20: 0x10330
> SAMA5D2: 0x814
> 
> Ludovic, could you please check the version number of the SAMA5D4 USART (if you have one lying around) ?
> 

SAMA5D4: 0x701

Regards

Ludovic
