From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH] serial: 8250: Avoid "too much work" from bogus rx timeout interrupt
Date: Mon, 19 Dec 2016 13:13:02 -0800
Message-ID: <CAD=FV=Ux4japAbiu+nzhZcATD2Rm8pAKt9JMi9qVNU7dKtFUqA@mail.gmail.com>
References: <1482110067-5591-1-git-send-email-dianders@chromium.org>
 <1482152376.9552.96.camel@linux.intel.com> <CAD=FV=Uzjb9Hcmw462Rr2QG6kpPkuF0ZA1=qoKwxTP4_FdFzrQ@mail.gmail.com>
 <1482168788.9552.100.camel@linux.intel.com> <CAD=FV=VbaNSsAoL8=FW-nEJS=538hRNND3JHaA=QjF9kg75e=A@mail.gmail.com>
 <1482178688.9552.104.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1482178688.9552.104.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Peter Hurley <peter@hurleysoftware.com>, california.l.sullivan@intel.com, "Liakhovetski, Guennadi" <guennadi.liakhovetski@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, jslaby@suse.com, Brian Norris <briannorris@chromium.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, =?UTF-8?B?6ZmI5riQ6aOe?= <jeffy.chen@rock-chips.com>, =?UTF-8?B?6auY576O5omN?= <eric.gao@rock-chips.com>, phillip.raffeck@fau.de, anton.wuerfel@fau.de, yegorslists@googlemail.com, matwey@sai.msu.ru, linux-serial@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi,

On Mon, Dec 19, 2016 at 12:18 PM, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Mon, 2016-12-19 at 09:54 -0800, Doug Anderson wrote:
>> Hi,
>>
>> Yes. Almost all Intel HW is using DesignWare IP for HS UARTs.
>>
>> OK, so possibly we could add this workaround in just the DesignWare
>> code and then we could be more sure we're not breaking other UARTs?
>> That would work for me.  It seems like it would be easier to validate
>> that there are no unintended side effects if we put this just in the
>> DesignWare driver.
>
> Yes, don't need to touch others.

OK, I will spin the patch with this.


>> Yes, I could believe that in the DMA case that my patch might not be
>> the right thing to do.  I can easily just add a check for "!up->dma"
>> if it makes the patch better.
>
> At least, yes.

OK, I'll include this.


>> > > 1. We'll get the interrupt
>> > > 2. We won't do _anything_ to service the interrupt.
>> > > 3. We'll return back to serial8250_interrupt(), where we'll keep
>> > > looping until we get "too much work"
>> > > 4. We'll break out, but the interrupt will still be active.
>> > > 5. Go back to #1
>> > >
>> > > ...and since this interrupt will keep firing and firing and firing
>> > > with no delay in-between, we'll effectively lock the CPU up.
>> >
>> > And the root cause of that is... ?
>>
>> I don't understand your question.  Basically what I'm saying is that
>> we got an interrupt and did absolutely nothing to handle it or clear
>> it.  Then we returned "handled".  Is it a mystery that the interrupt
>> will fire again and again and again?
>
>> Specifically:
>> * reading the LSR doesn't clear the interrupt
>> * The DR / BI bits aren't set.
>> * serial8250_modem_status() won't clear the interrupt (reads the MSR)
>> * nothing to transmit
>> * we'll return "handled" since the only time serial8250_handle_irq()
>> returns 0 is if we have UART_IIR_NO_INT.
>
> My question here a bit rhetorical, we better understand root cause,
> better fix would be.
>
>> > What I think is that the root cause of this is still unknown and
>> > either
>> > above looks like a hack.
>>
>> I postulated a root cause of receiving a partial character, but I'd
>> need to figure out how to twiddle bits in just the right way to
>> somehow try to do this in a programmatic way.  I can certainly
>> reproduce this in a black-box sort of way by just doing suspend/resume
>> testing long enough.
>
> Have you tried to disable C-states or set PM QoS?

C-states?  I think that is an Intel concept, isn't it?  I'm on a
Rockchip SoC and there is no official C-states.  I suppose I can check
to see if Linux Runtime PM is somehow involved, but it would be a bit
surprising.  As I said earlier in this thread I reproduce the problem
during suspend/resume testing when I'm entering into "suspend to ram"
(S3 in Intel speak, I believe) and then existing.

I've never dealt with PM QoS specifically.  Again, I would be
surprised if something like this was involved.


> Do you have same issue with and without DMA?

I have never tried with DMA, so probably the right thing to do is to
limit my patch to just the "no DMA" case and if/when someone finds
problems with DMA then they can adjust the patch accordingly.

Right now I don't believe DMA is enabled for the UART ports for any
Rockchip SoCs.  It should be theoretically possible to enable it, but
I'm not exactly in a rush to do so given that In my case I'm not using
the UARTs for any high performance activities and that enabling DMA
often causes some weird quirks to come up.


>> Even if the root cause isn't know, though, it seems like the current
>> behavior of locking up a CPU is non-ideal.  It seems like there ought
>> to be some sort of way to detect and handle this case.
>
> Have you read links I sent? In one mail I mentioned Intel's
> documentation that suggests not to use RDI interrupt when DMA. Which
> sounds weird.

I think I addressed the first link
(https://www.spinics.net/lists/kernel/msg2059543.html), which was a
proposed patch and a single response, right?

The 2nd link(http://www.spinics.net/lists/linux-serial/msg22316.html)
was all about DMA and right now I'm not using DMA (as per above).  I
will change my next patch to only run in the "no DMA" case.


-Doug
