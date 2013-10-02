From: Hector Palacios <hector.palacios@digi.com>
Subject: Re: [PATCH] serial: mxs-auart: wait for DMA buffer to flush before
 shutdown
Date: Wed, 2 Oct 2013 10:46:28 +0200
Message-ID: <524BDD64.70309@digi.com>
References: <1380644315-31581-1-git-send-email-hector.palacios@digi.com> <20131001194800.GL2548@pengutronix.de> <524BCBC4.5050708@digi.com> <20131002074436.GM2548@pengutronix.de> <524BD4A6.5060208@digi.com> <20131002083014.GN2548@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail1.bemta12.messagelabs.com ([216.82.251.10]:18882 "EHLO
	mail1.bemta12.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753041Ab3JBIrZ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 2 Oct 2013 04:47:25 -0400
In-Reply-To: <20131002083014.GN2548@pengutronix.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: =?ISO-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: "fabio.estevam@freescale.com" <fabio.estevam@freescale.com>, "marex@denx.de" <marex@denx.de>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "b32955@freescale.com" <b32955@freescale.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>, Jiri Slaby <jslaby@suse.cz>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Uwe,

On 10/02/2013 10:30 AM, Uwe Kleine-K=F6nig wrote:
> Hello Hector,
>
> On Wed, Oct 02, 2013 at 10:09:10AM +0200, Hector Palacios wrote:
>> On 10/02/2013 09:44 AM, Uwe Kleine-K=F6nig wrote:
>>> On Wed, Oct 02, 2013 at 09:31:16AM +0200, Hector Palacios wrote:
>>>> On 10/01/2013 09:48 PM, Uwe Kleine-K=F6nig wrote:
>>>>> On Tue, Oct 01, 2013 at 06:18:35PM +0200, Hector Palacios wrote:
>>>>>> +		/* Wait enough time to flush DMA buffer completely */
>>>>>> +		to =3D u->timeout * UART_XMIT_SIZE / u->fifosize;
>>>>> u->timeout is the time needed to send one char, right? UART_XMIT_=
SIZE is
>>>>> the size of the circular buffer, fifosize is the size of the fifo=
=2E I
>>>>> don't get what you get by dividing by the fifosize. I would have
>>>>> expected something like:
>>>>>
>>>>> 	u->timeout * min(UART_XMIT_SIZE, u->fifosize)
>>>>>
>>>>> Can you explain, maybe in a comment along the code for the next p=
erson
>>>>> not understanding?
>>>>
>>>> u->timeout is *not* the time needed to send one char but the time
>>>> needed to flush the complete port fifo (see uart_update_timeout() =
in
>>>> serial_core.c where it is set).
>>> Ah, right. (BTW, uart_update_timeout should better round up instead=
 of
>>> round down, i.e.
>>> -	port->timeout =3D (HZ * bits) / baud + HZ/50;
>>> +	port->timeout =3D DIV_ROUND_UP(HZ * bits, baud) + HZ/50;
>>> )
>>>
>>>> UART_XMIT_SIZE is the number of bytes in the DMA buffer, so I divi=
de
>>>> the max number of bytes in the FIFO by the FIFO size and multiply =
by
>>>> the FIFO timeout.
>>> ditto here, better round up. Although I think using a completion co=
uld
>>> shorten the timeout considerably because there are often less than
>>> UART_XMIT_SIZE chars in the buffer?!
>>
>> I'm not really waiting the full timeout. I'm checking for TX fifo
>> empty every 1ms and for a maximum of 'to' ms.
> Correct. Still using DIV_ROUND_UP would be better, right?

I think it is not really needed, after all the code is adding HZ/50 of =
slop which acts=20
like a round up, doesn't it?

	/*
	 * Figure the timeout to send the above number of bits.
	 * Add .02 seconds of slop
	 */
	port->timeout =3D (HZ * bits) / baud + HZ/50;

Best regards,
--
Hector Palacios
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
