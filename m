From: Hector Palacios <hector.palacios@digi.com>
Subject: Re: mxs auart timeout waiting for transmission with hw flow control
Date: Mon, 30 Sep 2013 18:41:25 +0200
Message-ID: <5249A9B5.2080903@digi.com>
References: <5249A1B7.4000404@digi.com> <20130930162044.GG2548@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail1.bemta7.messagelabs.com ([216.82.254.105]:8681 "EHLO
	mail1.bemta7.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755362Ab3I3Qs3 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 30 Sep 2013 12:48:29 -0400
In-Reply-To: <20130930162044.GG2548@pengutronix.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: =?ISO-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Huang Shijie <b32955@freescale.com>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>, "fabio.estevam@freescale.com" <fabio.estevam@freescale.com>, Marek Vasut <marex@denx.de>

Hi Uwe,

On 09/30/2013 06:20 PM, Uwe Kleine-K=F6nig wrote:
> Hi Hector,
>
> On Mon, Sep 30, 2013 at 06:07:19PM +0200, Hector Palacios wrote:
>> I saw your patch at
>> http://www.spinics.net/lists/stable/msg12952.html and I believe I'm
>> having a similar issue when not using the port as console.
>>
>> With hardware flow control enabled transmission fails at low
>> baudrates (9600,38400). Apparently the transmitter closes the port
> Which kernel are you using? I think there were some other fixes
> concering flow control some time ago.

v3.10. The driver is pretty close to current status.

>> before the data has been really shifted out (or even transferred by
>> the DMA). While the console functions check the status of
>> AUART_STAT_BUSY, the standard functions don't, and the AUART is busy
>> when shutdown is called at low baudrates.
>>
>> I also see the function uart_wait_until_sent() of serial_core.c
>> getting out with timeout expired. At 9600 baud, this function waits
>> 2 or 4 jiffies. Increasing (a lot) the timeout of this function
>> solves the problem. I monitored the time it takes for TX to be empty
>> and it resulted in sometimes around 200 jiffies (@9600).
> Again with flow control and another imx28 on the opposite side? Does =
it
> work without flow control? Is CTS busy for some time? In that case a
> simple timeout isn't appropriate. Using console and flow control on t=
he
> same port might be hairy, not sure though.

Yes, two imx28 devices with hw flow control enabled. Without flow contr=
ol it works.
CTS is not busy. At these low baudrates the CPU is fast enough to proce=
ss the received=20
data in time.
I'm not using the AUART as console but as a standard port.

>> The issue can be reproduced using two iMX28 devices (transmitting
>> between two ports on the same platform usually works fine),
>> configuring a low baudrate (9600) and hardware flow enabled, and
>> sending a file of 40K, for example. The last ~200 bytes or so are
>> typically not sent over the line.
> I currently don't have the time and machines to test, but maybe the
> freescale guys (added Fabio to Cc, too) might want to test it.
>
> Best regards from Freiburg

I wish I could drop by Freiburg one of these days! Love the city (and t=
he beer).

Best regards,
--
Hector Palacios
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
