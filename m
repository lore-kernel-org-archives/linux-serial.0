From: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] serial: tegra: handle rx race
Date: Fri, 9 Oct 2015 14:35:09 +0100
Message-ID: <5617C28D.1040209@nvidia.com>
References: <1443051326-1979-1-git-send-email-cfreeman@nvidia.com>
 <5603C158.4000002@nvidia.com> <20150925065840.GA13750@cfreeman-dt>
 <56059B27.2060902@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <56059B27.2060902-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Christopher Freeman <cfreeman-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Alexandre Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org


On 25/09/15 20:06, Jon Hunter wrote:
> On 25/09/15 07:58, Christopher Freeman wrote:
>> On 09-24 10:24 AM, Jon Hunter wrote:

[snip]

>>>> diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
>>>> index cf0133a..f9bd378 100644
>>>> --- a/drivers/tty/serial/serial-tegra.c
>>>> +++ b/drivers/tty/serial/serial-tegra.c
>>>> @@ -606,12 +606,6 @@ static void tegra_uart_rx_dma_complete(void *args)
>>>>  	tegra_uart_copy_rx_to_tty(tup, port, count);
>>>>  
>>>>  	tegra_uart_handle_rx_pio(tup, port);
>>>> -	if (tty) {
>>>> -		spin_unlock_irqrestore(&u->lock, flags);
>>>> -		tty_flip_buffer_push(port);
>>>> -		spin_lock_irqsave(&u->lock, flags);
>>>> -		tty_kref_put(tty);
>>>> -	}
>>>>  	tegra_uart_start_rx_dma(tup);
>>>
>>> With this change, tegra_uart_start_rx_dma() is called within the context
>>> of the spinlock (I am sure this is intentional). However,
>>> tegra_uart_start_rx_dma() calls dmaengine_prep_slave_single() and this
>>> calls tegra_dma_prep_slave_sg(). The problem is that
>>> tegra_dma_prep_slave_sg() *may* call kzalloc() to allocate memory. The
>>> allocation only happens if there is not a free dma descriptor available
>>> and if tegra_dma_prep_slave_sg() has been called once, you may get lucky.
>>>
>> This has been the case before this change so we've been getting lucky a lot.
>> Noted though.
> 
> Ah, yes you are right. Hmmm ... does not seem good.

Sorry, I am completely wrong here. Although tegra_dma_prep_slave_sg()
may call kzalloc() it does so with GFP_ATOMIC set. So we are ok.

Anyway, per our off-line discussions I will send out the alternative fix
that we have discussed.

Cheers
Jon
