From: Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH] Revert "serial: 8250_dma: don't bother DMA with small
 transfers"
Date: Wed, 30 Sep 2015 16:11:55 -0400
Message-ID: <560C420B.4030007@hurleysoftware.com>
References: <1443617191-21013-1-git-send-email-frederic.danis@linux.intel.com>
 <560BE919.9020803@hurleysoftware.com>
 <1443622344.8361.304.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1443622344.8361.304.camel-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Frederic Danis <frederic.danis-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Heikki Krogerus <heikki.krogerus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

[ + Heikko ]

On 09/30/2015 10:12 AM, Andy Shevchenko wrote:
> On Wed, 2015-09-30 at 09:52 -0400, Peter Hurley wrote:
>> [ + Andy Shevchenko ]
>>
>> On 09/30/2015 08:46 AM, Frederic Danis wrote:
>>> This reverts commit 9119fba0cfeda6d415c9f068df66838a104b87cb.
>>
>> Hi Frederic,
>>
>> It's customary to mail the commit author in patches which revert
>> their work.
>>
>>> This commit prevents from sending "big" file using Bluetooth.
>>> When sending a lot of data quickly through the Bluetooth interface, 
>>> and
>>> after a variable amount of data sent, transfer fails with error:
>>>     kernel: [  415.247453] Bluetooth: hci0 hardware error 0x00
>>
>> Hmmm, was there any other information regarding why this happened?
> 
> Frederic informed us privately about this issue.

Ok, except no one else knows that.

Least of all Greg, since the revert wasn't even addressed to him either :/

> I tried to hunt the
> root cause but mostly (there was one observation but apparently seems
> it is not related to this issue) nothing looks wrong.
> 
>> Eg., did the driver mistakenly re-order i/o (DMA occurred after PIO)?
> 
> I have few tracing dumps which Frederic provides to me, but I couldn't
> see such a problem. Maybe I missed it.

Ok.

> My commit 9119fba0cfed introduces interleaved IO (DMA/PIO) which makes
> it like DMA -> PIO -> DMA -> ...

I realize that. However interleaving DMA and PIO _must_ be supported
by the platform to enable DMA for 8250 serial devices anway.

When Heikki added DMA support to the 8250 driver, he left out important
functionality which requires interleaved DMA and PIO.

When I fix that omission, platforms using DMA that shouldn't be are going
to get broken anyway.

Regards,
Peter Hurley

>> Or, might there be some race condition in the dmaengine driver on 
>> this
>> platform?
> 
> There is [1] might be a clue, though I don't think it's directly
> related.
> 
> [1] http://www.spinics.net/lists/linux-spi/msg01151.html
> The change prevents interleaved DMA/PIO IO.
> 
>>
>> Regards,
>> Peter Hurley
>>
>>> Found on T100TA.
>>>
>>> After reverting this commit, send works fine for any file size.
>>>
>>> Signed-off-by: Frederic Danis <frederic.danis-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
>>> ---
>>>  drivers/tty/serial/8250/8250_dma.c | 4 ----
>>>  1 file changed, 4 deletions(-)
>>>
>>> diff --git a/drivers/tty/serial/8250/8250_dma.c 
>>> b/drivers/tty/serial/8250/8250_dma.c
>>> index 21d01a4..e508939 100644
>>> --- a/drivers/tty/serial/8250/8250_dma.c
>>> +++ b/drivers/tty/serial/8250/8250_dma.c
>>> @@ -80,10 +80,6 @@ int serial8250_tx_dma(struct uart_8250_port *p)
>>>  		return 0;
>>>  
>>>  	dma->tx_size = CIRC_CNT_TO_END(xmit->head, xmit->tail, 
>>> UART_XMIT_SIZE);
>>> -	if (dma->tx_size < p->port.fifosize) {
>>> -		ret = -EINVAL;
>>> -		goto err;
>>> -	}
>>>  
>>>  	desc = dmaengine_prep_slave_single(dma->txchan,
>>>  					   dma->tx_addr + xmit
>>> ->tail,
>>>
>>
> 
