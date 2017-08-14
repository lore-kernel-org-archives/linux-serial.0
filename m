From: Ian Jamison <ian@arkver.com>
Subject: Re: [PATCH] serial: imx: Improve PIO prevention if TX DMA has been
 started
Date: Mon, 14 Aug 2017 21:42:24 +0100
Message-ID: <27c039b9-7b47-37dc-efdd-b1b46854c00d@arkver.com>
References: <20170812151210.10420-1-clemens.gruber@pqgruber.com>
 <20170812195451.2g65wifawouz4t7d@pengutronix.de>
 <20170812220755.GA22225@archie.localdomain>
 <20170814065149.cwgw5echcjhvqxjb@pengutronix.de>
 <20170814183804.GA28695@archie.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170814183804.GA28695@archie.localdomain>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Clemens Gruber <clemens.gruber@pqgruber.com>, =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Fabio Estevam <fabio.estevam@nxp.com>, linux-kernel@vger.kernel.org, Ian Jamison <ian.dev@arkver.com>
List-Id: linux-serial@vger.kernel.org

Hi,

On 14/08/17 19:38, Clemens Gruber wrote:
> Hello Uwe,
>
> On Mon, Aug 14, 2017 at 08:51:49AM +0200, Uwe Kleine-König wrote:
>> Hello Clemens,
>>
>> On Sun, Aug 13, 2017 at 12:07:56AM +0200, Clemens Gruber wrote:
>>> On Sat, Aug 12, 2017 at 09:54:51PM +0200, Uwe Kleine-König wrote:
>>>> On Sat, Aug 12, 2017 at 05:12:10PM +0200, Clemens Gruber wrote:
>>>>> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
>>>>> index 80934e7bd67f..fce538eb8c77 100644
>>>>> --- a/drivers/tty/serial/imx.c
>>>>> +++ b/drivers/tty/serial/imx.c
>>>>> @@ -452,13 +452,14 @@ static inline void imx_transmit_buffer(struct imx_port *sport)
>>>>>   		if (sport->dma_is_txing) {
>>>>>   			temp |= UCR1_TDMAEN;
>>>>>   			writel(temp, sport->port.membase + UCR1);
>>>>> +			return;
>>>>>   		} else {
>>>>>   			writel(temp, sport->port.membase + UCR1);
>>>>>   			imx_dma_tx(sport);
>>>>>   		}
>>>> Shouldn't the return go here?
>>> Yes, it can also go here (and probably should). The problem of
>>> xmit->tail jumping over xmit->head occurs only if we are already DMA
>>> txing and then go into the PIO loop, but not the first time after
>>> calling imx_dma_tx. That's why the v1 passed the tests too.
>>> I'll have to conduct a few more tests and if they succeed I'll send a
>>> v2 where we return in both cases (already txing and starting to).
>>>
>>>> Did you understand the problem? Can you say why this only hurts in RS485
>>>> half-duplex but not (as it seems) in regular rs232 mode?
>>> I am not sure anyone understands (yet) why it a) only hurts RS-485 and
>>> b) only occurs on SMP systems.
>>> If you have more insight, please share it. :)
>> I asked because I thought you might have understood it before patching
>> it ...
> Yeah, this patch went out way too early, sorry for that! :/
>
> @gregkh: Please ignore this patch!
>
> About the underlying problem (b) why it only occurs on SMP systems:
> I think Ian's theory is correct:
> DMA is started, then the PIO is done until the xmit buffer is empty and
> immediately after that, DMA is stopped.
> On SMP systems, where the DMA TX thread can run on another core, it is
> already too late.
>
> Regarding problem (a) why it only hurts RS-485: One possibility could be
> the timing difference / additional delay due to for example toggling the
> transmit-enable GPIO via mctrl_gpio_set.
> Meaning that with RS-232 on SMP systems DMA is also stopped just early
> enough to not bork the circular xmit buffer.
>
> If this is true then the imx driver did not really use TX DMA in
> practice before.
>
> Thoughts?
>
> I'll try to trace this next week to verify these hypotheses.
>
This sounds plausible to me. I guess you could try adding a GPIO wiggle
in non-RS485 mode (or even a usleep) to see if it makes the problem
more noticeable.

I had broken my build for a while there, but am now testing 4.13-rc5
with RS485 mode and DMA enabled and it seems OK since my v1 patch
is included now. I also tried removing my change to the while loop and
adding a return before it (if dma_is_txing), as Uwe suggested, and that
also seems to work fine. My tests are not very exhaustive though. I
can post that as a patch if you like, or I can test your v2 if you prefer.

Regards,
Ian Jamison,
Arkver.
