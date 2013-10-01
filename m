From: Hector Palacios <hector.palacios@digi.com>
Subject: Re: mxs auart timeout waiting for transmission with hw flow control
Date: Tue, 1 Oct 2013 17:37:26 +0200
Message-ID: <524AEC36.3030409@digi.com>
References: <5249A1B7.4000404@digi.com> <20130930162044.GG2548@pengutronix.de> <5249A9B5.2080903@digi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail1.bemta7.messagelabs.com ([216.82.254.113]:34098 "EHLO
	mail1.bemta7.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752092Ab3JAPhu (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 1 Oct 2013 11:37:50 -0400
In-Reply-To: <5249A9B5.2080903@digi.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: =?ISO-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Huang Shijie <b32955@freescale.com>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>, "fabio.estevam@freescale.com" <fabio.estevam@freescale.com>, Marek Vasut <marex@denx.de>

Hello,

On 09/30/2013 06:41 PM, Hector Palacios wrote:
> Hi Uwe,
>
> On 09/30/2013 06:20 PM, Uwe Kleine-K=F6nig wrote:
>> Hi Hector,
>>
>> On Mon, Sep 30, 2013 at 06:07:19PM +0200, Hector Palacios wrote:
>>> I saw your patch at
>>> http://www.spinics.net/lists/stable/msg12952.html and I believe I'm
>>> having a similar issue when not using the port as console.
>>>
>>> With hardware flow control enabled transmission fails at low
>>> baudrates (9600,38400). Apparently the transmitter closes the port
>> Which kernel are you using? I think there were some other fixes
>> concering flow control some time ago.
>
> v3.10. The driver is pretty close to current status.
>
>>> before the data has been really shifted out (or even transferred by
>>> the DMA). While the console functions check the status of
>>> AUART_STAT_BUSY, the standard functions don't, and the AUART is bus=
y
>>> when shutdown is called at low baudrates.
>>>
>>> I also see the function uart_wait_until_sent() of serial_core.c
>>> getting out with timeout expired. At 9600 baud, this function waits
>>> 2 or 4 jiffies. Increasing (a lot) the timeout of this function
>>> solves the problem. I monitored the time it takes for TX to be empt=
y
>>> and it resulted in sometimes around 200 jiffies (@9600).

The problem is that the shutdown callback does not wait for the DMA buf=
fer to flush.
I will submit a patch that fixes it.

>> Again with flow control and another imx28 on the opposite side? Does=
 it
>> work without flow control? Is CTS busy for some time? In that case a
>> simple timeout isn't appropriate. Using console and flow control on =
the
>> same port might be hairy, not sure though.
>
> Yes, two imx28 devices with hw flow control enabled. Without flow con=
trol it works.

The reason why it works without hardware flow control is that in this d=
river the DMA=20
is only activated when hardware flow control is enabled.

By the way, where did the spinlocks go in this driver?
Ocasionally I saw unhandled NULL pointer exception in uart_write_wakeup=
(). Maybe my=20
patch will make it even hardware to hit, but still...

Best regards,
--
Hector Palacios
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
