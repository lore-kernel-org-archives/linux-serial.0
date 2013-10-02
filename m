From: Hector Palacios <hector.palacios@digi.com>
Subject: Re: [PATCH] serial: mxs-auart: wait for DMA buffer to flush before
 shutdown
Date: Wed, 2 Oct 2013 10:53:33 +0200
Message-ID: <524BDF0D.4040701@digi.com>
References: <1380644315-31581-1-git-send-email-hector.palacios@digi.com> <20131001194800.GL2548@pengutronix.de> <524BCBC4.5050708@digi.com> <20131002083608.GO2548@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail1.bemta7.messagelabs.com ([216.82.254.112]:59468 "EHLO
	mail1.bemta7.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753069Ab3JBIxn (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 2 Oct 2013 04:53:43 -0400
In-Reply-To: <20131002083608.GO2548@pengutronix.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: =?ISO-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "b32955@freescale.com" <b32955@freescale.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>, "fabio.estevam@freescale.com" <fabio.estevam@freescale.com>, "marex@denx.de" <marex@denx.de>, Jiri Slaby <jslaby@suse.cz>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 10/02/2013 10:36 AM, Uwe Kleine-K=F6nig wrote:
> Hello Hector,
>
> On Wed, Oct 02, 2013 at 09:31:16AM +0200, Hector Palacios wrote:
>> On 10/01/2013 09:48 PM, Uwe Kleine-K=F6nig wrote:
>>> Hello Hector,
>>>
>>> On Tue, Oct 01, 2013 at 06:18:35PM +0200, Hector Palacios wrote:
>>>> The shutdown function was not waiting for the DMA buffer to flush
>>>> before disabling the AUART. This lead to many bytes not being
>>>> transferred (specially at low baudrates), as they were still in th=
e
>>>> DMA buffer when the AUART was shutdown.
>>>> This patch also adds the check for the BUSY flag.
>>>>
>>>> Signed-off-by: Hector Palacios <hector.palacios@digi.com>
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
>> UART_XMIT_SIZE is the number of bytes in the DMA buffer, so I divide
>> the max number of bytes in the FIFO by the FIFO size and multiply by
>> the FIFO timeout.
> Another thought: Does that mean that from the framework's POV the
> fifosize is UART_XMIT_SIZE instead in the DMA case? That would enable
> you to just use u->timeout.

Hum, I think you hit the point.
I just saw they do this in amba_pl011.c driver:

	/* The DMA buffer is now the FIFO the TTY subsystem can use */
	uap->port.fifosize =3D PL011_DMA_BUFFER_SIZE;

I'll rework the patch and try.

Best regards,
--
Hector Palacios
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
