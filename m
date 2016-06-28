From: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
Subject: Re: [PATCH 1/8] tty: serial: fsl_lpuart: consider TX FIFO too in
 tx_empty
Date: Tue, 28 Jun 2016 09:24:00 +0530
Message-ID: <c8a587d0-814a-e71e-0312-d0b5f71022c4@toradex.com>
References: <20160609151039.20817-1-bhuvanchandra.dv@toradex.com>
 <20160609151039.20817-2-bhuvanchandra.dv@toradex.com>
 <20160625212600.GA28726@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <20160625212600.GA28726@kroah.com>
Sender: linux-clk-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stefan@agner.ch, shawnguo@kernel.org, kernel@pengutronix.de, mturquette@baylibre.com, sboyd@codeaurora.org, jslaby@suse.com, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 06/26/16 02:56, Greg KH wrote:

> On Thu, Jun 09, 2016 at 08:40:32PM +0530, Bhuvanchandra DV wrote:
>> From: Stefan Agner <stefan@agner.ch>
>>
>> Currently the tx_empty callback only considers the Transmit Complete
>> Flag (TC). The reference manual is not quite clear if the TC flag
>> covers the TX FIFO too. Debug prints on real hardware have shown that
>> from time to time the TC flag is asserted (indicating Transmitter
>> idle) while there are still data in the TX FIFO. Hence, in this case
>> the serial core will call the shutdown callback even though there are
>> data remaining in the TX FIFO buffers.
>>
>> Avoid early shutdowns by considering the TX FIFO empty flag too. Also
>> avoid theoretical race conditions between DMA and the driver by
>> checking whether the TX DMA is in progress too.
>>
>> Signed-off-by: Stefan Agner <stefan@agner.ch>
>> ---
>>   drivers/tty/serial/fsl_lpuart.c | 14 ++++++++++++--
>>   1 file changed, 12 insertions(+), 2 deletions(-)
> Why are you not signing off on patches that are flowing through you?
> Please fix this up and resend the series, after breaking up the clock
> change as asked.

Okay

>
> thanks,
>
> greg k-h

