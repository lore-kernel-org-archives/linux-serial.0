From: "Stuart MacDonald" <stuartm@connecttech.com>
Subject: Re: problems with serial driver
Date: Wed, 4 Sep 2002 12:22:32 -0400
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <08a301c2542f$45a78dc0$294b82ce@connecttech.com>
References: <Pine.LNX.4.44.0209041734310.26018-100000@scil.sinp.msu.ru>
Return-path: <linux-serial-owner@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org
To: slack@slackware.ru
Cc: linux-serial@vger.kernel.org

From: <slack@slackware.ru>
> :) Starting sender, starting receiver, CtrlC (kill -15, getting KILL
> signal in the prog). One note: both ports are on the same comp.

Always start the receiver first. Otherwise it's not guaranteed that
the serial receiver will sync properly with the data stream.

> Quatro check. I do not know how, but serverworks defines IRQs after 16 for
> side devices. But I have pure computers, without any devices. Of cource,
> I've got bad results on well-weaponed comp (audio, video IO etc.).
> With another chipset (860). Then, checkin new computers, that are virgin.

Irq conflicts can and do happen with on-board devices. Or are you
really running a no-video, no-nic, no-sound, no-parallel-port,
no-keyboard, no-mouse serial-console-only machine?

> > happen when the driver's handler is delayed too long.
> I see this, in the driver. But do not know what to do.

You see that the handler (in a live running machine) is delayed? You
have more "deep hardware knowledge" than you think. :-)

> Ah! Those old discussion about slow(long) and fast(short) interrupts?

An interrupt handler runs when interrupts are off. That means no other
hardware can have their interrupts acknowledged and handled. So if the
IDE subsystem has a very long (long running time) handler, the uarts
generate "fifo full" interrupts, but they are ignored for a long time.
In the meantime, the fifo fills and overruns.

I think the discussion you're thinking of is hardware interrupt
handlers vs software interrupt handlers (bottom halfs, but I think
they're going away, see tasklets).

> Hm... Where riside COM on-board ports? On which BUS (PCI/ISA)?

Don't know. Check with your manufacturer.

..Stu


