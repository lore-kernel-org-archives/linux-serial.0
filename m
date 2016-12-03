From: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
Subject: Re: [PATCH] tty: serial: fsl_lpuart: fix del_timer_sync() vs timer
 routine deadlock
Date: Sat, 3 Dec 2016 12:36:31 +0530
Message-ID: <9ee78fcd-7aca-e2d3-4df1-fe65a512a0f5@toradex.com>
References: <1480674490-24718-1-git-send-email-nikita.yoush@cogentembedded.com>
 <77e2726b8b84c55f9109ff18dfcfbbdf@agner.ch>
 <d858c7d2-c96c-f0dd-c5eb-bedd9187f8d8@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d858c7d2-c96c-f0dd-c5eb-bedd9187f8d8@cogentembedded.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nikita Yushchenko <nikita.yoush@cogentembedded.com>, Stefan Agner <stefan@agner.ch>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Wei Yongjun <weiyongjun1@huawei.com>, Aaron Brice <aaron.brice@datasoft.com>, Nicolae Rosia <nicolae_rosia@mentor.com>, linux-serial@vger.kernel.org, Chris Healy <cphealy@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 12/03/2016 02:58 AM, Nikita Yushchenko wrote:

>>> Problem found via lockdep:
>>>
>>> - lpuart_set_termios() calls del_timer_sync(&sport->lpuart_timer) while
>>>    holding sport->port.lock
>>>
>>> - sport->lpuart_timer routine is lpuart_timer_func() that calls
>>>    lpuart_copy_rx_to_tty() that acquires same lock.
>>>
>>> To fix, move Rx DMA stopping out of lock, as it already is in other places
>>> in the same file.
>>>
>>> While at it, also make Rx DMA start/stop code to look the same is in
>>> other places in the same file.
>> Yeah I saw that too, never really came around to look closer into it.
>>
>> Thanks for looking into it.
>>
>> You removed the check whether there was an old configuration, I think
>> the idea of that was that we only resize DMA if it was configured
>> differently before...
> Per my code reading, checking for sport->lpuart_dma_rx_use should be
> enough, this flag will be set only if DMA was previously enabled,

The check is to make sure the reconfiguration of DMA is done only when
the baudrate is altered.

--
Bhuvan

>
>>> +	if (sport->lpuart_dma_rx_use) {
>>> +		if (!lpuart_start_rx_dma(sport)) {
>>>   			sport->lpuart_dma_rx_use = true;
>> No need to set to true here, it is guaranteed to be true at this point.
> I've seen this...  However elsewhere in this file (namely in
> lpuart_resume(), in very similar situation, code is exactly the same,
> i.e. it sets sport->lpuart_dma_rx_use in both clauses. I thought it
> could be for a reason (i.e. for readability).
>
> Nikita
