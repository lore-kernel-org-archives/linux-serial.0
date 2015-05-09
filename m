From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: Hardware spec prevents optimal performance in device driver
Date: Sat, 9 May 2015 18:32:54 +0100
Message-ID: <20150509183254.18b786f9@lxorguk.ukuu.org.uk>
References: <554DDFF3.5060906@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <554DDFF3.5060906@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Mason <slash.tmp@free.fr>
Cc: linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Peter Hurley <peter@hurleysoftware.com>, Mans Rullgard <mans@mansr.com>
List-Id: linux-serial@vger.kernel.org

On Sat, 09 May 2015 12:22:43 +0200
Mason <slash.tmp@free.fr> wrote:

> Hello everyone,
> 
> I'm writing a device driver for a serial-ish kind of device.
> I'm interested in the TX side of the problem. (I'm working on
> an ARM Cortex A9 system by the way.)
> 
> There's a 16-byte TX FIFO. Data is queued to the FIFO by writing
> {1,2,4} bytes to a TX{8,16,32} memory-mapped register.
> Reading the TX_DEPTH register returns the current queue depth.
> 
> The TX_READY IRQ is asserted when (and only when) TX_DEPTH
> transitions from 1 to 0.

If the last statement is correct then your performance is probably always
going to suck unless there is additional invisible queueing beyond the
visible FIFO.

FIFOs on sane serial ports either have an adjustable threshold or fire
when its some way off empty. That way our normal flow is that you take
the TX interrupt before the port empties so you can fill it back up.

On that kind of port I'd expect optimal to probably be something like
writing 4 bytes until < 4 is left, and repeating that until your own
transmit queue is < 4 bytes and the write the dribble.

You don't normally want to perfectly fill the FIFO, you just want to ram
stuff into it efficiently with sufficient hardware queue and latency of
response that the queue never empties. Beyond that it doesn't matter.

Alan
