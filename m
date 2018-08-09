From: Mikko Perttunen <cyndis@kapsi.fi>
Subject: Re: [PATCH v3 3/8] mailbox: Add transmit done by blocking option
Date: Thu, 9 Aug 2018 11:49:19 +0300
Message-ID: <b3045f85-eacb-a5ec-1690-b9c63d0f3373@kapsi.fi>
References: <20180702114033.15654-1-mperttunen@nvidia.com>
 <20180702114033.15654-4-mperttunen@nvidia.com>
 <CABb+yY0_dKC_cYFwwb-aeRgrx=sjv=8VLP=C6DJEecFf=v+mkQ@mail.gmail.com>
 <907bac36-0c54-8f38-0f5e-f59196d414c6@kapsi.fi>
 <afc8a305-79ea-2194-0af0-919bbb8f675e@kapsi.fi>
 <CABb+yY2mpNV186=M2anmZANgMOra4JM7ybyUT4yCxhqAG6-AZg@mail.gmail.com>
 <b5a91f9e-c3ff-371c-d355-4a5e8a147796@kapsi.fi>
 <CABb+yY3Ng+rbKRYXTncfHKv6HXBW5hHjMKDpepz31MxpE9bwRQ@mail.gmail.com>
 <a57fccaa-fcfe-6611-45a5-8c224f4ee2b6@kapsi.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a57fccaa-fcfe-6611-45a5-8c224f4ee2b6@kapsi.fi>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: Mikko Perttunen <mperttunen@nvidia.com>, Greg KH <gregkh@linuxfoundation.org>, Thierry Reding <thierry.reding@gmail.com>, Jon Hunter <jonathanh@nvidia.com>, Devicetree List <devicetree@vger.kernel.org>, linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org, ", linux-arm-kernel"@lists.infradead.org, srv_heupstream <linux-mediatek@lists.infradead.org>, srv_heupstream <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Here's my current code:

https://github.com/cyndis/linux/commits/wip/t194-tcu-4

"fixup! mailbox: tegra-hsp: Add support for shared mailboxes" splits up 
the controller into two. "tegra-hsp: use polling" changes it to use polling.

There are two lines in the top patch with comments:

- at the end of tegra_hsp_mailbox_send_data, I left a "while 
(!tegra_hsp_mailbox_last_tx_done(chan));". Without it I wasn't able to 
see even a few garbled characters in the output.

- as mentioned, if I enable tx_block on the client side, I get a BUG: 
scheduling while atomic. I assume this gets printed through the earlycon 
as it's printing out correctly.

Thanks,
Mikko

On 08.08.2018 17:46, Mikko Perttunen wrote:
> On 08/08/2018 05:39 PM, Jassi Brar wrote:
>> On Wed, Aug 8, 2018 at 8:04 PM, Mikko Perttunen <cyndis@kapsi.fi> wrote:
>>>
>>>
>>> On 08/08/2018 05:10 PM, Jassi Brar wrote:
>>>>
>>>> On Wed, Aug 8, 2018 at 5:08 PM, Mikko Perttunen <cyndis@kapsi.fi> 
>>>> wrote:
>>>>>
>>>>>
>>>>>
>>>>> On 04.08.2018 13:45, Mikko Perttunen wrote:
>>>>>>
>>>>>>
>>>>>> On 08/03/2018 03:54 PM, Jassi Brar wrote:
>>>>>>>
>>>>>>>
>>>>>>> On Mon, Jul 2, 2018 at 5:10 PM, Mikko Perttunen 
>>>>>>> <mperttunen@nvidia.com>
>>>>>>> wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> Add a new TXDONE option, TXDONE_BY_BLOCK. With this option, the
>>>>>>>> send_data function of the mailbox driver is expected to block until
>>>>>>>> the message has been sent. The new option is used with the Tegra
>>>>>>>> Combined UART driver to minimize unnecessary overhead when
>>>>>>>> transmitting
>>>>>>>> data.
>>>>>>>>
>>>>>>> 1) TXDONE_BY_BLOCK flag :-
>>>>>>>            Have you tried setting the flag
>>>>>>> mbox_chan->mbox_client->tx_block
>>>>>>> ?
>>>>>>
>>>>>>
>>>>>>
>>>>>> No - I suppose I should have done that. I'm a bit concerned about
>>>>>> overhead
>>>>>> as send_data may be called thousands of times per second, so I 
>>>>>> tried to
>>>>>> make
>>>>>> it as close as possible to the downstream driver that just pokes the
>>>>>> mailbox
>>>>>> register directly.
>>>>>
>>>>>
>>>>>
>>>>> I tried using polling in the mailbox framework. Some printing is done
>>>>> from
>>>>> atomic context so it seems tx_block cannot be used -
>>>>> wait_for_completion_timeout understandably does not work in atomic
>>>>> context.
>>>>> I also tried without tx_block, in which case I got some horribly 
>>>>> garbled
>>>>> output, but "Try increasing MBOX_TX_QUEUE_LEN" was readable there.
>>>>>
>>>>> Any opinions?
>>>>>
>>>> The problems arise because your hardware (SM) supports TXDONE_BY_POLL,
>>>> but your client drives it by TXDONE_BY_ACK because the older DB
>>>> channels are so.
>>>>
>>>> Please populate SM channels as a separate controller than DB.
>>>> The DB controller, as is, run by ACK method.
>>>> The SM controller should be run by polling, i.e, set txdone_poll =
>>>> true and the poll period small enough. The virtual tty client driver
>>>> should be able to safely set tx_block from appropriate context.
>>>>
>>>
>>> Sorry, I should have clarified that I already split up the 
>>> controllers. The
>>> SM controller has txdone_poll = true. I didn't adjust txpoll_period so I
>>> guess it's zero.
>>>
>> Can you please share your code (controller and client) ? Maybe offline
>> if you wish.
>>
> 
> I'll upload a git branch tomorrow -- I'm not at the machine with the 
> code now.
> 
> Mikko
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-tegra" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
