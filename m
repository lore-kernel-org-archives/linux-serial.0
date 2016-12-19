From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH] serial: 8250: Avoid "too much work" from bogus rx timeout interrupt
Date: Mon, 19 Dec 2016 09:54:10 -0800
Message-ID: <CAD=FV=VbaNSsAoL8=FW-nEJS=538hRNND3JHaA=QjF9kg75e=A@mail.gmail.com>
References: <1482110067-5591-1-git-send-email-dianders@chromium.org>
 <1482152376.9552.96.camel@linux.intel.com> <CAD=FV=Uzjb9Hcmw462Rr2QG6kpPkuF0ZA1=qoKwxTP4_FdFzrQ@mail.gmail.com>
 <1482168788.9552.100.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1482168788.9552.100.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Peter Hurley <peter@hurleysoftware.com>, california.l.sullivan@intel.com, "Liakhovetski, Guennadi" <guennadi.liakhovetski@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, jslaby@suse.com, Brian Norris <briannorris@chromium.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, =?UTF-8?B?6ZmI5riQ6aOe?= <jeffy.chen@rock-chips.com>, =?UTF-8?B?6auY576O5omN?= <eric.gao@rock-chips.com>, phillip.raffeck@fau.de, anton.wuerfel@fau.de, yegorslists@googlemail.com, matwey@sai.msu.ru, tthayer@opensource.altera.com, linux-serial@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi,

On Mon, Dec 19, 2016 at 9:33 AM, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Mon, 2016-12-19 at 09:12 -0800, Doug Anderson wrote:
>> Hi,
>>
>> On Mon, Dec 19, 2016 at 4:59 AM, Andy Shevchenko
>> <andriy.shevchenko@linux.intel.com> wrote:
>> > On Sun, 2016-12-18 at 17:14 -0800, Douglas Anderson wrote:
>> > > On a Rockchip rk3399-based board during suspend/resume testing, we
>> > > found that we could get the console UART into a state where it
>> > > would
>> > > print this to the console a lot:
>> > >   serial8250: too much work for irq42
>> >
>> > Have you read the following discussion
>> > https://www.spinics.net/lists/kernel/msg2059543.html
>>
>> No, I wasn't aware of that discussion.  Yup, basically the exact same
>> thing is happening here.  Good to know I'm not alone.  Any idea if the
>> Baytrail UART is also based on DesignWare IP?
>
> Yes. Almost all Intel HW is using DesignWare IP for HS UARTs.

OK, so possibly we could add this workaround in just the DesignWare
code and then we could be more sure we're not breaking other UARTs?
That would work for me.  It seems like it would be easier to validate
that there are no unintended side effects if we put this just in the
DesignWare driver.


>> In that thread, Peter said:
>>
>> > I think there is every likelihood of spurious RX timeout interrupts
>> > tripping this patch, sorry.
>> >
>> > Unfortunately, I think UART_BUG_ is the only viable possibility.
>> > Or perhaps fixing the port type as PORT_8250 (thus disabling the
>> > fifos).
>>
>> My change is slightly different than California's in that I'm actually
>> throwing away the bogus byte and his patch was treating it as a valid
>> byte.  I don't know if that makes the patch more or less palatable.
>
> We need to test, especially in DMA case.

Yes, I could believe that in the DMA case that my patch might not be
the right thing to do.  I can easily just add a check for "!up->dma"
if it makes the patch better.


>> I would hate to lose access to the FIFOs just due to this weird corner
>> case.
>>
>> Do we really think there's a case where there's an RX Timeout
>> interrupt w/ no "data ready" but that later the data ready will show
>> up?  Can you quantify how much later you think it will show up?  If we
>> can quantify how much longer the data will show up in then we should
>> probably just do a timeout loop right where I added my patch.
>>
>> Specifically, here's what's happening today with RX Timeout interrupt
>> without "data ready":
>>
>> 1. We'll get the interrupt
>> 2. We won't do _anything_ to service the interrupt.
>> 3. We'll return back to serial8250_interrupt(), where we'll keep
>> looping until we get "too much work"
>> 4. We'll break out, but the interrupt will still be active.
>> 5. Go back to #1
>>
>> ...and since this interrupt will keep firing and firing and firing
>> with no delay in-between, we'll effectively lock the CPU up.
>
> And the root cause of that is... ?

I don't understand your question.  Basically what I'm saying is that
we got an interrupt and did absolutely nothing to handle it or clear
it.  Then we returned "handled".  Is it a mystery that the interrupt
will fire again and again and again?

Specifically:
* reading the LSR doesn't clear the interrupt
* The DR / BI bits aren't set.
* serial8250_modem_status() won't clear the interrupt (reads the MSR)
* nothing to transmit
* we'll return "handled" since the only time serial8250_handle_irq()
returns 0 is if we have UART_IIR_NO_INT.


>> If there are some UARTs that eventually get themselves out of this
>> state by asserting "data ready" then the above won't be an "infinite"
>> loop but it will effectively be a tight loop where we won't let
>> userspace run and won't service other interrupts until we actually get
>> the data ready.  Since we're already blocking everything else, it
>> seems like it might be better to directly loop in
>> serial8250_handle_irq() with a timeout of some sort (how long?  100
>> us?  1 ms?).  Then we if we get the timeout then we can do the read
>> and safely work ourselves free.
>
> What I think is that the root cause of this is still unknown and either
> above looks like a hack.

I postulated a root cause of receiving a partial character, but I'd
need to figure out how to twiddle bits in just the right way to
somehow try to do this in a programmatic way.  I can certainly
reproduce this in a black-box sort of way by just doing suspend/resume
testing long enough.

Even if the root cause isn't know, though, it seems like the current
behavior of locking up a CPU is non-ideal.  It seems like there ought
to be some sort of way to detect and handle this case.

-Doug
