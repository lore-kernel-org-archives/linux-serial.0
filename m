From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: Mainline commit "serial: Test for no tx data on tx restart" not
 correct for i.MX6?
Date: Thu, 24 Jul 2014 07:58:52 -0400
Message-ID: <53D0F4FC.1000302@hurleysoftware.com>
References: <53CF3599.6040509@gmail.com> <53CFE38E.6070302@hurleysoftware.com> <53D0BFF1.30204@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout32.mail01.mtsvc.net ([216.70.64.70]:39253 "EHLO
	n23.mail01.mtsvc.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750817AbaGXL64 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 24 Jul 2014 07:58:56 -0400
In-Reply-To: <53D0BFF1.30204@mentor.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: jiwang <jiada_wang@mentor.com>, Dirk Behme <dirk.behme@gmail.com>, linux-serial@vger.kernel.org, Huang Shijie <b32955@freescale.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dirk Behme <dirk.behme@de.bosch.com>

Hi Jiada,

On 07/24/2014 04:12 AM, jiwang wrote:
> Hi Peter
> 
> On 07/24/2014 01:32 AM, Peter Hurley wrote:
>> Hi Dirk,
>>
>> On 07/23/2014 12:10 AM, Dirk Behme wrote:
>>> Hi,
>>>
>>> this is a question regarding the i.MX6 part (drivers/tty/serial/imx.c) of the commit
>>>
>>> serial: Test for no tx data on tx restart
>>>
>>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=c557d392fbf5badd693ea1946a4317c87a26a716
>>>
>>> Talking with some i.MX6 experts about this, I've got the comment
>>>
>>> -- cut --
>>> The imx serial driver part of this commit isn't correct
>>> as imx.c sends x_char in irq handler, not in imx_start_tx(),
>>> -- cut --
>>>
>>> What do you think?
>> Thanks for the comment.
>>
>> Yeah, I missed that the imx driver handled x_char _at all_,
>> because how the imx driver is handling x_char looks broken.
>>
>> For example, if data is already in the tx ring buffer,
>> imx_start_tx() will send that data before the x_char, and if
>> all the tx ring buffer data is sent successfully, the tx
>> interrupt is switched back off, so the x_char won't be sent.
>
> imx_start_tx() doesn't do any actual data transfer

???

   565	static void imx_start_tx(struct uart_port *port)
   566	{
   ...
   610	
   611		if (readl(sport->port.membase + uts_reg(sport)) & UTS_TXEMPTY)
   612			imx_transmit_buffer(sport);
   613	}


   463	static inline void imx_transmit_buffer(struct imx_port *sport)
   464	{
   465		struct circ_buf *xmit = &sport->port.state->xmit;
   466	
   467		while (!uart_circ_empty(xmit) &&
   468				!(readl(sport->port.membase + uts_reg(sport))
   469					& UTS_TXFULL)) {
   470			/* send xmit->buf[xmit->tail]
   471			 * out the port here */
   472			writel(xmit->buf[xmit->tail], sport->port.membase + URTX0);
   473			xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
   474			sport->port.icount.tx++;
   475		}
   476	
   477		if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
   478			uart_write_wakeup(&sport->port);
   479	
   480		if (uart_circ_empty(xmit))
   481			imx_stop_tx(&sport->port);
   482	}

Regards,
Peter Hurley
