From: Mikko Perttunen <cyndis@kapsi.fi>
Subject: Re: [PATCH v3 3/8] mailbox: Add transmit done by blocking option
Date: Sat, 4 Aug 2018 13:45:49 +0300
Message-ID: <907bac36-0c54-8f38-0f5e-f59196d414c6@kapsi.fi>
References: <20180702114033.15654-1-mperttunen@nvidia.com>
 <20180702114033.15654-4-mperttunen@nvidia.com>
 <CABb+yY0_dKC_cYFwwb-aeRgrx=sjv=8VLP=C6DJEecFf=v+mkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CABb+yY0_dKC_cYFwwb-aeRgrx=sjv=8VLP=C6DJEecFf=v+mkQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jassi Brar <jassisinghbrar@gmail.com>, Mikko Perttunen <mperttunen@nvidia.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, Thierry Reding <thierry.reding@gmail.com>, Jon Hunter <jonathanh@nvidia.com>, Devicetree List <devicetree@vger.kernel.org>, linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org, ", linux-arm-kernel"@lists.infradead.org, linux-mediatek@lists.infradead.org, srv_heupstream <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On 08/03/2018 03:54 PM, Jassi Brar wrote:
> On Mon, Jul 2, 2018 at 5:10 PM, Mikko Perttunen <mperttunen@nvidia.com> wrote:
>> Add a new TXDONE option, TXDONE_BY_BLOCK. With this option, the
>> send_data function of the mailbox driver is expected to block until
>> the message has been sent. The new option is used with the Tegra
>> Combined UART driver to minimize unnecessary overhead when transmitting
>> data.
>>
> 1) TXDONE_BY_BLOCK flag :-
>          Have you tried setting the flag mbox_chan->mbox_client->tx_block ?

No - I suppose I should have done that. I'm a bit concerned about 
overhead as send_data may be called thousands of times per second, so I 
tried to make it as close as possible to the downstream driver that just 
pokes the mailbox register directly.

> 
> 2) Implementing TEGRA_HSP_MBOX_TYPE_SM :-
>         In mailbox framework, a controller is a collection of identical
> channels. That is, instances of the same class.
>         So ideally, in probe you should populate a controller for each
> type of channel, i.e, DB, SM, SS and AS.

Hmm, yes, I guess this would be possible if I change the mailbox core to 
allow registering multiple controllers per device.

Thanks!
Mikko

> --
> To unsubscribe from this list: send the line "unsubscribe linux-tegra" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
