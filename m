From: Mason <slash.tmp@free.fr>
Subject: Re: Hardware spec prevents optimal performance in device driver
Date: Sun, 10 May 2015 18:46:00 +0200
Message-ID: <554F8B48.204@free.fr>
References: <554DDFF3.5060906@free.fr>	<20150509183254.18b786f9@lxorguk.ukuu.org.uk>	<554E72B9.8010809@free.fr> <yw1xbnhsk9ow.fsf@unicorn.mansr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <yw1xbnhsk9ow.fsf@unicorn.mansr.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mans Rullgard <mans@mansr.com>
Cc: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

On 10/05/2015 12:29, M=E5ns Rullg=E5rd wrote:

> Mason writes:
>=20
>> One Thousand Gnomes wrote:
>>
>>> Mason wrote:
>>>
>>>> I'm writing a device driver for a serial-ish kind of device.
>>>> I'm interested in the TX side of the problem. (I'm working on
>>>> an ARM Cortex A9 system by the way.)
>>>>
>>>> There's a 16-byte TX FIFO. Data is queued to the FIFO by writing
>>>> {1,2,4} bytes to a TX{8,16,32} memory-mapped register.
>>>> Reading the TX_DEPTH register returns the current queue depth.
>>>>
>>>> The TX_READY IRQ is asserted when (and only when) TX_DEPTH
>>>> transitions from 1 to 0.
>>>
>>> If the last statement is correct then your performance is probably =
always
>>> going to suck unless there is additional invisible queueing beyond =
the
>>> visible FIFO.
>>
>> Do you agree with my assessment that the current semantics for
>> TX_READY lead to a race condition, unless we limit ourselves
>> to a single (atomic) write between interrupts?
>=20
> No.  To get best throughput, you can simply busy-wait until TX_DEPTH
> indicates the FIFO is almost empty, then write a few words, but no mo=
re
> than you know fit in the FIFO.  Repeat until all data has been writte=
n.
> Use the IRQ only to signal completion of the entire packet.

Would you fill the FIFO with TX_READY disabled?
or with all interrupts masked?

I will show with pseudo-code where (I think) the race condition
breaks the algorithm you suggest. (When using IRQs, not busy wait.)

> If the transmit rate is low, you can save some CPU time by filling th=
e
> FIFO, then sleeping until it should be almost empty, fill again, etc.

=46or one data point, the test app I have sets the tx rate to 128 kbps.
Thus, 1 ms to transmit an entire queue. CPU runs at 100-1000 MHz
depending on the mood of cpufreq.

> Whether busy-waiting or sleeping, this approach keeps the data flowin=
g
> as fast as possible.
>=20
> With the hardware you describe, there is unfortunately a trade-off
> between throughput and CPU efficiency.  You'll have to decide which i=
s
> more important to you.

I can ask the hardware designer to change the behavior for the next
iteration of the SoC.

Regards.
