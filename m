From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Subject: Re: Hardware spec prevents optimal performance in device driver
Date: Sun, 10 May 2015 11:29:03 +0100
Message-ID: <yw1xbnhsk9ow.fsf@unicorn.mansr.com>
References: <554DDFF3.5060906@free.fr>
	<20150509183254.18b786f9@lxorguk.ukuu.org.uk>
	<554E72B9.8010809@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <554E72B9.8010809@free.fr> (Mason's message of "Sat, 09 May 2015
	22:48:57 +0200")
Sender: linux-kernel-owner@vger.kernel.org
To: Mason <slash.tmp@free.fr>
Cc: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Mason <slash.tmp@free.fr> writes:

> One Thousand Gnomes wrote:
>
>> Mason wrote:
>>=20
>>> I'm writing a device driver for a serial-ish kind of device.
>>> I'm interested in the TX side of the problem. (I'm working on
>>> an ARM Cortex A9 system by the way.)
>>>
>>> There's a 16-byte TX FIFO. Data is queued to the FIFO by writing
>>> {1,2,4} bytes to a TX{8,16,32} memory-mapped register.
>>> Reading the TX_DEPTH register returns the current queue depth.
>>>
>>> The TX_READY IRQ is asserted when (and only when) TX_DEPTH
>>> transitions from 1 to 0.
>>=20
>> If the last statement is correct then your performance is probably a=
lways
>> going to suck unless there is additional invisible queueing beyond t=
he
>> visible FIFO.
>
> Do you agree with my assessment that the current semantics for
> TX_READY lead to a race condition, unless we limit ourselves
> to a single (atomic) write between interrupts?

No.  To get best throughput, you can simply busy-wait until TX_DEPTH
indicates the FIFO is almost empty, then write a few words, but no more
than you know fit in the FIFO.  Repeat until all data has been written.
Use the IRQ only to signal completion of the entire packet.

If the transmit rate is low, you can save some CPU time by filling the
=46IFO, then sleeping until it should be almost empty, fill again, etc.

Whether busy-waiting or sleeping, this approach keeps the data flowing
as fast as possible.

With the hardware you describe, there is unfortunately a trade-off
between throughput and CPU efficiency.  You'll have to decide which is
more important to you.

--=20
M=E5ns Rullg=E5rd
mans@mansr.com
