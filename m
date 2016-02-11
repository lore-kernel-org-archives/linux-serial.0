From: John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH 0/4] serial: omap: robustify for high speed transfers
Date: Thu, 11 Feb 2016 13:02:42 +0100
Message-ID: <87wpqbihel.fsf@linutronix.de>
References: <87lh7hrjsg.fsf@linutronix.de>
	<56A66FCB.1000507@hurleysoftware.com> <87y4b85onp.fsf@linutronix.de>
	<56B15603.80807@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: gregkh@linuxfoundation.org, vinod.koul@intel.com, dan.j.williams@intel.com, bigeasy@linutronix.de, tony@atomide.com, nsekhar@ti.com, peter.ujfalusi@ti.com, dmaengine@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 2016-02-03, Peter Hurley <peter@hurleysoftware.com> wrote:
>>>> The DMA-enabled OMAP UART driver in its current form queues 48
>>>> bytes for a DMA-RX transfer. After the transfer is complete, a new
>>>> transfer of 48 bytes is queued. The DMA completion callback runs in
>>>> tasklet context, so a reschedule with context switch is required
>>>> for the completion to be processed and the next 48 bytes to be
>>>> queued.
>>>>
>>>> When running at a high speed such as 3Mbit, the CPU has 128us
>>>> between when the DMA hardware transfer completes and when the DMA
>>>> hardware must be fully prepared for the next transfer. For an
>>>> embedded board running applications, this does not give the CPU
>>>> much time. If the UART is using hardware flow control, this
>>>> situation results in a dramatic decrease in real transfer
>>>> speeds. If flow control is not used, the CPU will almost certainly
>>>> be forced to drop data.
>>>
>>> I'm not convinced by this logic at all.
>>> Tasklets are not affected by the scheduler because they run in
>>> softirq.  Or is this -RT?
>> 
>> Softirq runs as SCHED_OTHER. It is quite easy to create a scenario
>> where DMA completion tasklets for this driver are not being serviced
>> fast enough.
>> 
>>> I'm not seeing this problem on other platforms at this baud rate,
>> 
>> Do you run 3Mbit on other platforms without hardware flow control?
>
> Yes, but only unidirectionally.

It surprises me to hear that you are running UART with DMA on an AM335x
platform and are able to sustain 3Mbit transfers with the driver in its
current form.

>> I mention this because turning on hardware flow control can cover up
>> the driver shortcomings by slowing down the transfers. What good is
>> 3Mbit hardware if the driver never lets it get above 500Kbit on bulk
>> transfers?
>
> That's interesting. I wonder why the 6x hit when using h/w flow
> control.  Any thoughts on that?

The CPU is busy handling interrupts, copying data to the tty layer, and
setting up DMA transfers. No CPU cycles to spare. Without h/w flow
control it is not fast enough to keep up and data is lost. With h/w flow
control the UART controller is slowing the transfer so that the CPU can
keep up.

>>> and on this platform, all I see is lockups with DMA.
>> 
>> I have seen (and fixed) interesting issues with the AM335x eDMA, but
>> I have not experienced lockups in any of my testing. I'd be curious
>> how you trigger that.
>
> I haven't tested it since 4.1. I'll go back and re-enable DMA and
> retest.

You will need to remove the broken-flag that is in mainline. Otherwise
the driver will refuse to use DMA.

>>> What is the test setup to reproduce these results?
>> 
>> Two Beaglebone boards connected via ttyS1. ttyS1's are set to raw
>> mode at 3Mbit.
>> 
>> sender:   cat bigfile > /dev/ttyS1
>> receiver: cat /dev/ttyS1 > bigfile
>
> Ok, I can repro something similar.
>
>> I am working on creating concrete examples that demonstrate not only
>> that this patch series reduces system load (and thus can increase
>> throughput on heavy system loads with hardware flow control), but
>> also that it is able to handle baud rates without data loss well
>> beyond the current implementation when no flow control is used.
>> 
>> I wanted to wait until I had all the results before answering your
>> email. But I'm getting caught up in other tasks right now, so it may
>> take a few more weeks.
>
> Ok. So just to be clear here: this patchset is really all about
> performance improvement and not correct operation?

Correct.

>>>> This patch series modifies the UART driver to use cyclic DMA
>>>> transfers with a growable ring buffer to accommodate baud
>>>> rates. The ring buffer is large enough to hold at least 1s of
>>>> RX-data.  (At 3Mbit that is 367KiB.)
>>>
>>> Math slightly off because the frame is typically 10 bits, not 8.
>> 
>> I was thinking 8 was the minimal frame size. Thanks for pointing that
>> out. A frame can contain 7-12 bits so I will modify the code to
>> create a buffer appropriate for the UART settings. At 3Mbit with 5n1
>> the driver would require a 419KiB ring buffer (8929 DMA periods of 48
>> bytes).
>
> More about this below.
>
>>>> In order to ensure that data in the ring buffer is not overwritten
>>>> before being processed by the tty layer, a hrtimer is used as a
>>>> watchdog.
>>>
>>> How'd it go from "We're just missing 128us window" to "This holds 1s
>>> of data"?
>> 
>> First, you need to recognize that DMA completion tasklets can be
>> delayed significantly due to interrupt loads or rtprio processes
>> (even on non-RT systems). And at 3Mbit we are talking about >12000
>> interrupts per second!
>
> Not sure I see 12000 ints/sec. unless you're talking about full-duplex
> at max rate in both directions?  3Mbit/sec / 10-bit frame / 48
> bytes/dma = 6250 ints/sec.

At these speeds, nearly every DMA interrupt is accompanied by a spurious
UART interrupt. So, sadly, the interrupts are doubled.

It is on my TODO list to verify if the spurious UART interrupts exactly
match the recently added [0] spurious interrupt detection in omap-intc.

> But again, interrupt load is not going to result in 100ms service
> intervals.  So I think we're really talking about a (misbehaved)
> rtprio process that's starving i/o.

I am running my tests with busybox-init, busybox-sh, and
busybox-cat. That is it!

>> When using cyclic transfers, the only real concern is that the DMA
>> overwrites data in the ring buffer before the CPU has processed it
>> due to tasklet delays. That is what the hrtimer watchdog is for.
>> 
>> Assuming the DMA is zooming along at full speed, the watchdog must be
>> able to trigger before the ring buffer can fill up. If the watchdog
>> sees the ring buffer is getting full, it pauses the DMA engine. But
>> with cyclic DMA we never know if the DMA is zooming or sitting
>> idle. So even on an idle system, the watchdog must assume DMA zooming
>> and continually fire to check the status.
>> 
>> I chose 1 second buffer sizes and set the watchdog to fire at half
>> that. On an idle system you will see at most 2 new interrupts per
>> second due to this patch series. I thought that would be an
>> acceptable trade off. Whether the watchdog should fire at 50% buffer
>> full or say 90% buffer full is something that could be debated. But
>> to answer your question, the big ring buffer is really to keep the
>> watchdog interrupts low frequency.
>
> Ok, but your fundamental premise is that all of this is an acceptable
> space-time tradeoff for everyone using this platform, when it's not.
>
> So I'm trying to understand the actual use case you're trying to
> address.  I doubt that's 5n1, full-duplex.

The actual use case is playing/recording high quality audio via
bluetooth.

>>> And with a latency hit this bad, you'll never get the data to the
>>> process because the tty buffer kworker will buffer-overflow too and
>>> its much more susceptible to timing latency (although not as bad now
>>> that it's exclusively on the unbounded workqueue).
>> 
>> Yes, you are correct. But I think that is a problem that should be
>> addressed at the tty layer.
>
> I disagree. I think you should fix the source of 500ms latency.

All my experimentation and testing has showed that the latency occurs
because the CPU has too much to handle. So I devised an implementation
based on cyclic transfers and a ring buffer to free up the CPU. With the
new implementation the CPU is not required to setup a DMA transfer every
112-192us. And if the CPU is only able to service a small percentage of
the DMA completion interrupts, there can still exist full speed
transfers with no data loss.

Now if the tty layer is unable to handle 3Mbit because the CPU is so
busy, then it may be necessary to offload more work from the CPU. For
example, giving the tty its own high priority workqueue also eased the
situation. Now the CPU will miss even more of the DMA completion
interrupts, but the watchdog and ring buffer can allow that.

Perhaps instead we should be discussing a new API where UART drivers can
DMA bulk transfers directly to userspace. Until now my efforts have been
focussed on improving performance of the existing framework.

John Ogness

[0] https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1000296.html
