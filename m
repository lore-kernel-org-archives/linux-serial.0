From: Hector Palacios <hector.palacios@digi.com>
Subject: Re: [PATCH 0/3] serial: mxs-auart: flush_buffer hook and interrupt
 processing
Date: Fri, 29 Nov 2013 17:46:44 +0100
Message-ID: <5298C4F4.1020507@digi.com>
References: <1385742927-11358-1-git-send-email-hector.palacios@digi.com> <201311291744.06943.marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail1.bemta7.messagelabs.com ([216.82.254.105]:34521 "EHLO
	mail1.bemta7.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756750Ab3K2Qqx (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 29 Nov 2013 11:46:53 -0500
In-Reply-To: <201311291744.06943.marex@denx.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Marek Vasut <marex@denx.de>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "b32955@freescale.com" <b32955@freescale.com>, "fabio.estevam@freescale.com" <fabio.estevam@freescale.com>, "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>

On 11/29/2013 05:44 PM, Marek Vasut wrote:
> Hi Hector,
>
>> Hello,
>>
>> This series implement several fixes to the mxs-auart serial driver.
>>
>> The first patch implements the flush_buffer hook. Currently the driver
>> can be shut down and pending data in the FIFO will be lost.
>>
>> The second patchs adds a check of the BUSY flag in the tx_empty hook
>> to make sure the UART is not about to fill data into the FIFO.
>>
>> The third patch moves the interrupt handling from the ISR out to a
>> tasklet. This was motivated due to different transmission problems
>> with hardware and software flow control at high baudrates whereby
>> transmission was interrupted or data lost.
>> The problem can be reproduced by setting two AUARTs at 576000/N/8
>> with CRTSCTS and sending a large file from one port to the other
>>   with 'cat'.
>
> 57600 is not that high of a baudrate. Or do you really mean 576000 (576
> thousand) ?

I wrote and meant 576000, indeed :-)

Best regards,
--
Hector Palacios
