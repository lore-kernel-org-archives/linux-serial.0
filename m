From: Grant Edwards <grant.b.edwards@gmail.com>
Subject: Re: [PATCH] Documentation about RS485 serial communications
Date: Tue, 16 Nov 2010 18:03:43 +0000 (UTC)
Message-ID: <ibuh1v$uh6$1@dough.gmane.org>
References: <20100408111310.524f7354@lxorguk.ukuu.org.uk>
 <4CBD8EE4.5040808@evidence.eu.com> <i9ka0s$4ua$1@dough.gmane.org>
 <201010191727.53314.alexander.stein@systec-electronic.com>
 <i9kk4o$svc$1@dough.gmane.org> <4CC418A9.6090602@evidence.eu.com>
 <4CDA630F.4060903@atmel.com> <20101110172842.GC12371@suse.de>
 <4CDBC3EC.6020707@evidence.eu.com> <20101116143016.GB6527@ucw.cz>
 <AANLkTi=grehSnfWzCDtSXXmNb=-NAwbHHJ_P1XPyOuw8@mail.gmail.com>
 <20101116172013.102e06a6@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On 2010-11-16, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Tue, 16 Nov 2010 10:13:22 -0600
> Matt Schulte <matts@commtech-fastcom.com> wrote:
>
>> On Tue, Nov 16, 2010 at 8:30 AM, Pavel Machek <pavel@ucw.cz> wrote:
>> > Hi!
>> >
>> >> Documentation about RS485 serial communications
>> >
>> > I have seen hardware (kontron pmc-6l) that was capable of switching
>> > between RS232, RS485 and one other standard by software.
>> >
>> > Is such hw common? If so, should we have standard interface?
>> 
>> In my opinion this type of card is not that common.  Generally
>> speaking the achievable baud rates for this type of multi-protocol
>> card are very limited because of limitations of the transceiver chips.
>>  It seems that most of the time people would rather have a faster
>> serial port than one that does several different voltages
>
> If there are two types in common use then thats enough to say we should
> have a common interface IMHO

Comtrol, Moxa, B&B, Sealevel, and others all sell PCI cards and
Ethernet attached serial ports that have selectable interfaces
(typically RS-232/422/485).  Comtrol and Moxa have had drivers in the
kernel tree for ages, but they've always had to use custom ioctl calls
for things like configuring 232/485/422 mode and half/full-duplex
mode.

There are also tons of small Linux-based industrial server appliances
from Comtrol, Silex, Digi, Moxa, and others that have selectable
interface serial ports.

Having a standard API for things like interface mode, half-full
duplex, inter-character timeout, 9-bit mode, and so on would be life a
lot easier for those of us who maintain Linux serial drivers...

-- 
Grant Edwards               grant.b.edwards        Yow! I always have fun
                                  at               because I'm out of my
                              gmail.com            mind!!!
