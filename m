From: John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH 0/4] serial: omap: robustify for high speed transfers
Date: Fri, 29 Jan 2016 17:35:54 +0100
Message-ID: <87y4b85onp.fsf@linutronix.de>
References: <87lh7hrjsg.fsf@linutronix.de>
	<56A66FCB.1000507@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56A66FCB.1000507@hurleysoftware.com> (Peter Hurley's message of
	"Mon, 25 Jan 2016 10:56:11 -0800")
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: gregkh@linuxfoundation.org, vinod.koul@intel.com, dan.j.williams@intel.com, bigeasy@linutronix.de, tony@atomide.com, nsekhar@ti.com, peter.ujfalusi@ti.com, dmaengine@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Peter,

On 2016-01-25, Peter Hurley <peter@hurleysoftware.com> wrote:
>> The DMA-enabled OMAP UART driver in its current form queues 48 bytes
>> for a DMA-RX transfer. After the transfer is complete, a new transfer
>> of 48 bytes is queued. The DMA completion callback runs in tasklet
>> context, so a reschedule with context switch is required for the
>> completion to be processed and the next 48 bytes to be queued.
>> 
>> When running at a high speed such as 3Mbit, the CPU has 128us between
>> when the DMA hardware transfer completes and when the DMA hardware
>> must be fully prepared for the next transfer. For an embedded board
>> running applications, this does not give the CPU much time. If the
>> UART is using hardware flow control, this situation results in a
>> dramatic decrease in real transfer speeds. If flow control is not
>> used, the CPU will almost certainly be forced to drop data.
>
> I'm not convinced by this logic at all.
> Tasklets are not affected by the scheduler because they run in softirq.
> Or is this -RT?

Softirq runs as SCHED_OTHER. It is quite easy to create a scenario where
DMA completion tasklets for this driver are not being serviced fast
enough.

> I'm not seeing this problem on other platforms at this baud rate,

Do you run 3Mbit on other platforms without hardware flow control? I
mention this because turning on hardware flow control can cover up the
driver shortcomings by slowing down the transfers. What good is 3Mbit
hardware if the driver never lets it get above 500Kbit on bulk
transfers?

> and on this platform, all I see is lockups with DMA.

I have seen (and fixed) interesting issues with the AM335x eDMA, but I
have not experienced lockups in any of my testing. I'd be curious how
you trigger that.

> What is the test setup to reproduce these results?

Two Beaglebone boards connected via ttyS1. ttyS1's are set to raw mode
at 3Mbit.

sender:   cat bigfile > /dev/ttyS1
receiver: cat /dev/ttyS1 > bigfile

I am working on creating concrete examples that demonstrate not only
that this patch series reduces system load (and thus can increase
throughput on heavy system loads with hardware flow control), but also
that it is able to handle baud rates without data loss well beyond the
current implementation when no flow control is used.

I wanted to wait until I had all the results before answering your
email. But I'm getting caught up in other tasks right now, so it may
take a few more weeks.

>> This patch series modifies the UART driver to use cyclic DMA transfers
>> with a growable ring buffer to accommodate baud rates. The ring buffer is
>> large enough to hold at least 1s of RX-data. 
>> (At 3Mbit that is 367KiB.)
>
> Math slightly off because the frame is typically 10 bits, not 8.

I was thinking 8 was the minimal frame size. Thanks for pointing that
out. A frame can contain 7-12 bits so I will modify the code to create a
buffer appropriate for the UART settings. At 3Mbit with 5n1 the driver
would require a 419KiB ring buffer (8929 DMA periods of 48 bytes).

>> In order to ensure that data in the ring buffer is not overwritten before
>> being processed by the tty layer, a hrtimer is used as a watchdog.
>
> How'd it go from "We're just missing 128us window" to "This holds 1s
> of data"?

First, you need to recognize that DMA completion tasklets can be delayed
significantly due to interrupt loads or rtprio processes (even on non-RT
systems). And at 3Mbit we are talking about >12000 interrupts per
second!

When using cyclic transfers, the only real concern is that the DMA
overwrites data in the ring buffer before the CPU has processed it due
to tasklet delays. That is what the hrtimer watchdog is for.

Assuming the DMA is zooming along at full speed, the watchdog must be
able to trigger before the ring buffer can fill up. If the watchdog sees
the ring buffer is getting full, it pauses the DMA engine. But with
cyclic DMA we never know if the DMA is zooming or sitting idle. So even
on an idle system, the watchdog must assume DMA zooming and continually
fire to check the status.

I chose 1 second buffer sizes and set the watchdog to fire at half
that. On an idle system you will see at most 2 new interrupts per second
due to this patch series. I thought that would be an acceptable trade
off. Whether the watchdog should fire at 50% buffer full or say 90%
buffer full is something that could be debated. But to answer your
question, the big ring buffer is really to keep the watchdog interrupts
low frequency.

> And with a latency hit this bad, you'll never get the data to the
> process because the tty buffer kworker will buffer-overflow too and
> its much more susceptible to timing latency (although not as bad now
> that it's exclusively on the unbounded workqueue).

Yes, you are correct. But I think that is a problem that should be
addressed at the tty layer.

John Ogness
