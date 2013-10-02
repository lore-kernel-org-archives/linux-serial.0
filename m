From: Hector Palacios <hector.palacios@digi.com>
Subject: Re: [PATCH] serial: mxs-auart: wait for DMA buffer to flush before
 shutdown
Date: Wed, 2 Oct 2013 10:09:10 +0200
Message-ID: <524BD4A6.5060208@digi.com>
References: <1380644315-31581-1-git-send-email-hector.palacios@digi.com> <20131001194800.GL2548@pengutronix.de> <524BCBC4.5050708@digi.com> <20131002074436.GM2548@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail1.bemta12.messagelabs.com ([216.82.251.1]:40355 "EHLO
	mail1.bemta12.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752923Ab3JBIJi (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 2 Oct 2013 04:09:38 -0400
In-Reply-To: <20131002074436.GM2548@pengutronix.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: =?ISO-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "b32955@freescale.com" <b32955@freescale.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>, "fabio.estevam@freescale.com" <fabio.estevam@freescale.com>, "marex@denx.de" <marex@denx.de>, Jiri Slaby <jslaby@suse.cz>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hello Uwe,

On 10/02/2013 09:44 AM, Uwe Kleine-K=F6nig wrote:
> Hello,
>
> On Wed, Oct 02, 2013 at 09:31:16AM +0200, Hector Palacios wrote:
>> On 10/01/2013 09:48 PM, Uwe Kleine-K=F6nig wrote:
>>> On Tue, Oct 01, 2013 at 06:18:35PM +0200, Hector Palacios wrote:
>>>> The shutdown function was not waiting for the DMA buffer to flush
>>>> before disabling the AUART. This lead to many bytes not being
>>>> transferred (specially at low baudrates), as they were still in th=
e
>>>> DMA buffer when the AUART was shutdown.
>>>> This patch also adds the check for the BUSY flag.
>>>>
>>>> Signed-off-by: Hector Palacios <hector.palacios@digi.com>
>>>>
>>>> [...]
>>>> ---
>>>>   drivers/tty/serial/mxs-auart.c | 16 +++++++++++++++-
>>>>   1 file changed, 15 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/m=
xs-auart.c
>>>> index f85b8e6..0d8b2ca 100644
>>>> --- a/drivers/tty/serial/mxs-auart.c
>>>> +++ b/drivers/tty/serial/mxs-auart.c
>>>> @@ -750,12 +750,26 @@ static int mxs_auart_startup(struct uart_por=
t *u)
>>>>   	return 0;
>>>>   }
>>>>
>>>> +static unsigned int mxs_auart_tx_empty(struct uart_port *u);
>>>> +
>>>>   static void mxs_auart_shutdown(struct uart_port *u)
>>>>   {
>>>>   	struct mxs_auart_port *s =3D to_auart_port(u);
>>>> +	unsigned int to;
>>>> +
>>>> +	if (auart_dma_enabled(s)) {
>>>> +		/* Wait enough time to flush DMA buffer completely */
>>>> +		to =3D u->timeout * UART_XMIT_SIZE / u->fifosize;
>>> u->timeout is the time needed to send one char, right? UART_XMIT_SI=
ZE is
>>> the size of the circular buffer, fifosize is the size of the fifo. =
I
>>> don't get what you get by dividing by the fifosize. I would have
>>> expected something like:
>>>
>>> 	u->timeout * min(UART_XMIT_SIZE, u->fifosize)
>>>
>>> Can you explain, maybe in a comment along the code for the next per=
son
>>> not understanding?
>>
>> u->timeout is *not* the time needed to send one char but the time
>> needed to flush the complete port fifo (see uart_update_timeout() in
>> serial_core.c where it is set).
> Ah, right. (BTW, uart_update_timeout should better round up instead o=
f
> round down, i.e.
> -	port->timeout =3D (HZ * bits) / baud + HZ/50;
> +	port->timeout =3D DIV_ROUND_UP(HZ * bits, baud) + HZ/50;
> )
>
>> UART_XMIT_SIZE is the number of bytes in the DMA buffer, so I divide
>> the max number of bytes in the FIFO by the FIFO size and multiply by
>> the FIFO timeout.
> ditto here, better round up. Although I think using a completion coul=
d
> shorten the timeout considerably because there are often less than
> UART_XMIT_SIZE chars in the buffer?!

I'm not really waiting the full timeout. I'm checking for TX fifo empty=
 every 1ms and=20
for a maximum of 'to' ms.


>>> I wonder if the individual driver is the right place this must be f=
ixed
>>> in or if there should be (or even exists) some help form the serial
>>> framework?!
>>
>> Good question, the issue should exit in other DMA drivers as well.
> Added Jiri and lakml to Cc:. Maybe someone can say something about th=
at
> topic?
>
> Best regards
> Uwe
>


Best regards,
--
Hector Palacios
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
