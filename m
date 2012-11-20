From: Martin Fuzzey <mfuzzey@parkeon.com>
Subject: Re: [PATCH] TTY: serial 8250: Support MCR CLK_SEL bit.
Date: Tue, 20 Nov 2012 10:55:27 +0100
Message-ID: <50AB538F.6030904@parkeon.com>
References: <20121119085421.315.47347.stgit@localhost> <20121119120043.39f59baf@pyramind.ukuu.org.uk>
Reply-To: mfuzzey@parkeon.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mta1.parkeon.com ([91.121.43.66]:57340 "EHLO mta1.parkeon.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751528Ab2KTJze (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 20 Nov 2012 04:55:34 -0500
In-Reply-To: <20121119120043.39f59baf@pyramind.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org


Thank you for the review.

On 19/11/12 13:00, Alan Cox wrote:

>>      * Allows the CLK_SEL bit to be forced to /1, /4 or left as is.
> This seems to be the wrong place to set such stuff. The kernel knows what
> speed is selected and therefore what clock would be best.
>
> Having a clocksel (and probably an of value indicating which type of
> clock sel) is a good thing, but it also ought to be set based on the
> requested baud rate, so a custom set_termios would be better.
I agree that would be nicer, however I think there is a problem,
at least in the case of the xr16c2850.

This chip is a DUART but the clksel bit, although present for
both channels, (in MCR bit 7) is actually shared (as is the external
CLKSEL pin). Hence if the kernel determines whether to enable
/4 or /1 based on the requested baud rate for one channel it
may break the baud rate for the other channel.

This problem also exists with my approach but only to the extent
that if the device tree writer tries to set one channel to /4 and the
other to /1 the result will not be as intended.

As a general question how should this type of dependency between
ports due to them being part of the same chip be handled?

> That would also handle serial console, and suspend/resume without other
> tweaks as far as I can see.
Yes, there may be problems with suspend/resume - I haven't tried yet.

> It also seems some devices use different clksel algorithms so rather than
> a CAP_CLKSEL flag we probably need to key it off the uart type.
>
True,

I've also looked at the NXP SC16C850 and SC16C852 data sheets
and they, in addition to the /4 controlled by MCR:7, also have an
additional 4 bit prescaler register.

They lack the external clksel pin however (which is the main reason
for all this - the normal 16 bit divisor is enough to allow _low_ baud rates
to be reached without enabling any other prescalers - the only case
that is really a problem is when chips that _do_ have the predivisor enabled
in hardware cause us not to be able to attain high baud rates).

I'm not sure if the clock selects are independant for the DUART case,
they appear to be but  I don't have the hardware to test it.

>>   static void serial8250_set_sleep(struct uart_8250_port *p, int sleep)
>>   {
>>   	if (p->capabilities & UART_CAP_SLEEP) {
>> -		if (p->capabilities & UART_CAP_EFR) {
>> -			serial_out(p, UART_LCR, UART_LCR_CONF_MODE_B);
>> -			serial_out(p, UART_EFR, UART_EFR_ECB);
>> -			serial_out(p, UART_LCR, 0);
>> -		}
>> +		serial8250_enable_extended(p);
>>   		serial_out(p, UART_IER, sleep ? UART_IERX_SLEEP : 0);
> This seems wrong if theere is no EFR
Sorry, I don't understand here.

The same EFR bit needs to be set to enable access to both the SLEEP
and CLKSEL bits.
So I've just refactored the existing code to share setting this bit -
this shouldn't change the existing behaviour.

Maybe I should have done this as a seperate patch to make it clearer.

If UART_CAP_EFR is not set but UART_CAP_SLEEP or UART_CAP_CLKSEL is
set is assumed that it is not necessary to enable access via the EFR 
(whether
that is a valid combination for any existing UART is another question).

Regards,

Martin

