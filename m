From: "Frantisek Rysanek" <Frantisek.Rysanek@post.cz>
Subject: Re: serial flow control appears broken
Date: Wed, 01 Aug 2007 23:54:23 +0200
Message-ID: <46B11D2F.31852.34529AEB@Frantisek.Rysanek.post.cz>
References: <fa.Z6O0xFRT69zes0Mg+agt3Uiwux4@ifi.uio.no>, <20070728130009.43ea9e14@the-village.bc.nu>, <46AB631B.6070109@howardsilvan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp.seznam.cz ([212.80.76.43]:46289 "HELO smtp.seznam.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751486AbXHAVy1 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 1 Aug 2007 17:54:27 -0400
In-reply-to: <46AB631B.6070109@howardsilvan.com>
Content-description: Mail message body
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

On 28 Jul 2007 at 17:39, Lee Howard wrote:
> >>Curiously, the session at 38400 bps that skipped 858 bytes... coincided, 
> >>not just in sequence but also in precice timing within the session, with 
> >>a small but noticeable disk load that I caused by grepping through a 
> >>hundred session logs.  
>
> I've attached dmesg output.
>
I'd like to summarize a few points that have appeared in this long 
thread.

Someone else has mentioned interrupt latency.
I seem to recall that the RTAI people can measure that. 
http://issaris.org/rtai/list.php
They report that some P4-class Intel chipsets (i845/865 for example) 
that are using message-signaled interrupt passing across the HubLink 
(serialized PCI) from the South Bridge to the North Bridge, exhibit 
interrupt latencies on the order of milliseconds, if the HubLink is 
loaded by some heavy PCI transfers, such as intensive disk IO. 
Reportedly this is because the interrupt messages are competing for 
the "right of the way" with the DMA-driven PCI transactions that 
carry the bulk of the disk IO payload, where a single PCI transaction 
can take that long.

Now: you've quoted a Shuttle HOT-661. That's an older chipset, i440 
class. That one was still using the traditional out-of-band interrupt 
delivery mechanism, using the INTR signal + vector reading over the 
ISA bus. Yet, come to think of that, the native PCI interconnect 
between the MCH and the PIIX4 can still present a bottleneck to IRQ 
processing. The AT PIC is located in the PIIX4 (south bridge). After 
the INTR signal, in order to access the AT-PIC (to read the vector), 
the CPU has to reach out across that PCI bus. Now if the bus is busy 
with some lengthy PCI DMA transfer, what happens to the interrupt 
delivery?
I don't know for sure, but possibly the CPU gets stalled by the north 
bridge, until the PCI DMA transfer is over. The same would be true 
about any ISA read/write, such as legacy ISA-based serial UART 
access. If anyone knows for sure, please comment on this...

I mean to say that this may be unrelated to some other driver 
disabling interrupts explicitly. The latency may occur even with 
interrupts enabled, due to the PCI bottleneck.

Based on your dmesg listing, your disk drive and chipset have settled 
on using UDMA33. The maximum disk transfer size is 128 kB. Cannot say 
how this translates to PCI transactions. If this implied that a 
single PCI transaction could be 128 kB long, that would be almost a 
millisecond at 132 MBps (PCI speed) or some 4 ms at 33 MBps (disk 
drive speed). Again, can't say for sure if this implies a stall, or 
if the data dribbles in such a way that the 33 MBps data flow is 
interleaved with other transactions (IRQ related or not).
Mr. Fulghum has quoted 694us of slack (at 115200 bps and an 
8-Byte trigger level).

I've never seen this happen, but possibly I wasn't stressing my 
machines enough :-)

Frank Rysanek

