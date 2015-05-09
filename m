From: Mason <slash.tmp@free.fr>
Subject: Re: Hardware spec prevents optimal performance in device driver
Date: Sat, 09 May 2015 22:48:57 +0200
Message-ID: <554E72B9.8010809@free.fr>
References: <554DDFF3.5060906@free.fr> <20150509183254.18b786f9@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150509183254.18b786f9@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Peter Hurley <peter@hurleysoftware.com>, Mans Rullgard <mans@mansr.com>
List-Id: linux-serial@vger.kernel.org

One Thousand Gnomes wrote:

> Mason wrote:
> 
>> I'm writing a device driver for a serial-ish kind of device.
>> I'm interested in the TX side of the problem. (I'm working on
>> an ARM Cortex A9 system by the way.)
>>
>> There's a 16-byte TX FIFO. Data is queued to the FIFO by writing
>> {1,2,4} bytes to a TX{8,16,32} memory-mapped register.
>> Reading the TX_DEPTH register returns the current queue depth.
>>
>> The TX_READY IRQ is asserted when (and only when) TX_DEPTH
>> transitions from 1 to 0.
> 
> If the last statement is correct then your performance is probably always
> going to suck unless there is additional invisible queueing beyond the
> visible FIFO.

Do you agree with my assessment that the current semantics for
TX_READY lead to a race condition, unless we limit ourselves
to a single (atomic) write between interrupts?

> FIFOs on sane serial ports either have an adjustable threshold or fire
> when its some way off empty. That way our normal flow is that you take
> the TX interrupt before the port empties so you can fill it back up.

This is where I must be missing something obvious.

As far as I can see, the race condition still exists, even if
the hardware provides a TX threshold.

Suppose we set the threshold to 4, then write 4-byte words to the queue.
TX_READY may fire between two writes if the CPU is very slow
(unlikely) or is required to do something else (more likely).

Thus in the ISR, I can't tell exactly what happened, and I cannot
signal something clear to the other thread.

What am I missing?

BTW, I checked the HW spec. There's a RX thresh, but no TX thresh.
 
> On that kind of port I'd expect optimal to probably be something like
> writing 4 bytes until < 4 is left, and repeating that until your own
> transmit queue is < 4 bytes and the write the dribble.

To keep the data flowing between FIFO and device. I agree.

> You don't normally want to perfectly fill the FIFO, you just want to ram
> stuff into it efficiently with sufficient hardware queue and latency of
> response that the queue never empties. Beyond that it doesn't matter.

Well there's another dimension to optimize: minimizing IRQs to
the CPU. And completely filling the FIFO achieves that.

Interrupting once for every 12 bytes sounds better than interrupting
once for every 4 or 8 bytes, don't you agree? What am I missing?

Regards.
