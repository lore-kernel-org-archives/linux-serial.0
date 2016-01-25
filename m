From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH 0/4] serial: omap: robustify for high speed transfers
Date: Mon, 25 Jan 2016 10:56:11 -0800
Message-ID: <56A66FCB.1000507@hurleysoftware.com>
References: <87lh7hrjsg.fsf@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87lh7hrjsg.fsf@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: John Ogness <john.ogness@linutronix.de>, gregkh@linuxfoundation.org
Cc: vinod.koul@intel.com, dan.j.williams@intel.com, bigeasy@linutronix.de, tony@atomide.com, nsekhar@ti.com, peter.ujfalusi@ti.com, dmaengine@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 01/22/2016 02:27 AM, John Ogness wrote:
> The DMA-enabled OMAP UART driver in its current form queues 48 bytes for a
> DMA-RX transfer. After the transfer is complete, a new transfer of 48 bytes
> is queued. The DMA completion callback runs in tasklet context, so a
> reschedule with context switch is required for the completion to be
> processed and the next 48 bytes to be queued.
> 
> When running at a high speed such as 3Mbit, the CPU has 128us between when
> the DMA hardware transfer completes and when the DMA hardware must be fully
> prepared for the next transfer. For an embedded board running applications,
> this does not give the CPU much time. If the UART is using hardware flow
> control, this situation results in a dramatic decrease in real transfer
> speeds. If flow control is not used, the CPU will almost certainly be
> forced to drop data.

I'm not convinced by this logic at all.
Tasklets are not affected by the scheduler because they run in softirq.
Or is this -RT?

I'm not seeing this problem on other platforms at this baud rate, and
on this platform, all I see is lockups with DMA.

What is the test setup to reproduce these results?


> This patch series modifies the UART driver to use cyclic DMA transfers
> with a growable ring buffer to accommodate baud rates. The ring buffer is
> large enough to hold at least 1s of RX-data. 

> (At 3Mbit that is 367KiB.)

Math slightly off because the frame is typically 10 bits, not 8.

> In order to ensure that data in the ring buffer is not overwritten before
> being processed by the tty layer, a hrtimer is used as a watchdog.

How'd it go from "We're just missing 128us window" to "This holds 1s of data"?

And with a latency hit this bad, you'll never get the data to the process
because the tty buffer kworker will buffer-overflow too and its much more
susceptible to timing latency (although not as bad now that it's exclusively
on the unbounded workqueue).

Regards,
Peter Hurley


> With this patch series, the UART driver is resilent against latencies up
> to 500ms. This means that if no flow control is used, data will not be
> dropped until such latencies occur. If hardware flow control is used,
> real transfer speeds will not be affected until such latencies occur.
> 
> Patch series against next-20160122.
> 
> John Ogness (4):
>   ARM: edma: special case slot limit workaround
>   tty: serial: 8250: add optional spinlock arg to serial8250_rx_chars
>   tty: serial: 8250: omap: convert to using cyclic transfers
>   tty: serial: 8250: omap: consume spurious interrupts
> 
>  drivers/dma/edma.c                  |   25 +-
>  drivers/tty/serial/8250/8250.h      |    2 +
>  drivers/tty/serial/8250/8250_fsl.c  |    2 +-
>  drivers/tty/serial/8250/8250_omap.c |  430 ++++++++++++++++++++++++-----------
>  drivers/tty/serial/8250/8250_port.c |    9 +-
>  include/linux/serial_8250.h         |    3 +-
>  6 files changed, 333 insertions(+), 138 deletions(-)
> 
