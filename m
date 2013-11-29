From: Hector Palacios <hector.palacios@digi.com>
Subject: Re: [PATCH 3/3] serial: mxs-auart: move irq handling to a tasklet
Date: Fri, 29 Nov 2013 19:04:49 +0100
Message-ID: <5298D741.1080100@digi.com>
References: <1385742927-11358-1-git-send-email-hector.palacios@digi.com> <1385742927-11358-4-git-send-email-hector.palacios@digi.com> <201311291800.12366.marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail1.bemta7.messagelabs.com ([216.82.254.102]:49335 "EHLO
	mail1.bemta7.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752192Ab3K2SE5 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 29 Nov 2013 13:04:57 -0500
In-Reply-To: <201311291800.12366.marex@denx.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Marek Vasut <marex@denx.de>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "b32955@freescale.com" <b32955@freescale.com>, "fabio.estevam@freescale.com" <fabio.estevam@freescale.com>, "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>

On 11/29/2013 06:00 PM, Marek Vasut wrote:
> Dear Hector Palacios,
>
>> The ISR was handling CTS flag and RX/TX processing.
>> Occasionally interrupts were coming in the middle of the ISR and
>> led to blocking transmission (with hw flow) or loss of data.
>> This patch moves this processing to a tasklet that the ISR schedules.
>>
>> Signed-off-by: Hector Palacios <hector.palacios@digi.com>
>> ---
>>   drivers/tty/serial/mxs-auart.c | 61
>> +++++++++++++++++++++++++++--------------- 1 file changed, 39
>> insertions(+), 22 deletions(-)
>>
>> diff --git a/drivers/tty/serial/mxs-auart.c
>> b/drivers/tty/serial/mxs-auart.c index e5540c89dd48..7021269c70b2 100644
>> --- a/drivers/tty/serial/mxs-auart.c
>> +++ b/drivers/tty/serial/mxs-auart.c
>> @@ -148,6 +148,10 @@ struct mxs_auart_port {
>>   	struct clk *clk;
>>   	struct device *dev;
>>
>> +	struct tasklet_struct tasklet;
>> +	unsigned int irq_status;
>> +	unsigned int status;
>> +
>>   	/* for DMA */
>>   	struct scatterlist tx_sgl;
>>   	struct dma_chan	*tx_dma_chan;
>> @@ -680,38 +684,48 @@ static void mxs_auart_settermios(struct uart_port *u,
>>   	}
>>   }
>>
>> +/*
>> + * tasklet handling tty stuff outside the interrupt handler.
>> + */
>> +static void mxs_auart_tasklet_func(unsigned long data)
>> +{
>> +	struct uart_port *port = (struct uart_port *)data;
>> +	struct mxs_auart_port *s = to_auart_port(port);
>> +
>> +	/* Handle status irq */
>> +	if (s->irq_status & AUART_INTR_CTSMIS) {
>> +		uart_handle_cts_change(&s->port, s->status & AUART_STAT_CTS);
>> +		writel(AUART_INTR_CTSMIS,
>> +		       s->port.membase + AUART_INTR_CLR);
>> +	}
>> +	/* Handle receive irq */
>> +	if (s->irq_status & (AUART_INTR_RTIS | AUART_INTR_RXIS)) {
>> +		if (!auart_dma_enabled(s))
>> +			mxs_auart_rx_chars(s);
>> +	}
>> +	/* Handle transmit irq */
>> +	if (s->irq_status & AUART_INTR_TXIS)
>> +		mxs_auart_tx_chars(s);
>> +}
>> +
>>   static irqreturn_t mxs_auart_irq_handle(int irq, void *context)
>>   {
>> -	u32 istat;
>>   	struct mxs_auart_port *s = context;
>> -	u32 stat = readl(s->port.membase + AUART_STAT);
>>
>> -	istat = readl(s->port.membase + AUART_INTR);
>> +	s->status = readl(s->port.membase + AUART_STAT);
>> +	s->irq_status = readl(s->port.membase + AUART_INTR);
>
> Aren't you up for a nice race condition here if you get interrupt while checking
> the s->irq_status bits in the tasklet ?

Sad, but true. :-(
But if I need to wait on the ISR for the tasklet to process then this patch loses its 
original meaning. Argh... it works so nicely!

Best regards,
--
Hector Palacios
