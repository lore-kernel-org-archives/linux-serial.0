From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [RFC PATCH] always probe UART HW when options are not specified
Date: Tue, 12 Jan 2016 14:42:28 -0800
Message-ID: <56958154.5090003@hurleysoftware.com>
References: <5672D18E.8000301@laposte.net>
 <5672E2CF.6080705@hurleysoftware.com> <5672E76A.3010506@laposte.net>
 <5672F588.8070503@hurleysoftware.com> <5672FD35.5070609@laposte.net>
 <56731689.70702@hurleysoftware.com> <56740FC3.50302@laposte.net>
 <5674204C.1000907@hurleysoftware.com> <56782DE5.7090708@laposte.net>
 <56798EC7.1030804@laposte.net> <5693C52B.90003@laposte.net>
 <5693D41E.8050601@hurleysoftware.com> <5693ECBA.50003@laposte.net>
 <5693FD3C.5080601@hurleysoftware.com> <5694C94B.3090405@free.fr>
 <56950C21.3010805@laposte.net> <5695584E.3040902@hurleysoftware.com>
 <56957D8B.3080906@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56957D8B.3080906@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Mason <slash.tmp@free.fr>
Cc: Sebastian Frias <sf84@laposte.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Mans Rullgard <mans@mansr.com>
List-Id: linux-serial@vger.kernel.org

On 01/12/2016 02:26 PM, Mason wrote:
> On 12/01/2016 20:47, Peter Hurley wrote:
> 
>> I expect that patch to go into -next sometime during the 4.5-rc cycle.
> 
> Do you mean the "Add Au1x00/RT288x earlycon support" patch?

No. This one http://www.spinics.net/lists/linux-serial/msg20328.html

> I find it strange that you have rt288x_putc while also
> using AU1x00_FOO. Seems like mixing naming styles.

I wrote it in 10 mins.

> Did you see my post about the underlying IP block?
> Might be appropriate to use that name there?

I did, and thanks for reminding me. I did follow that email thread
a while back about the provenance of this register layout.

I'd rather not go back through the source and rename the symbols.
Afaict, the Au1x00 landed first in source and then the RT288x afterwards.
So I'd like to stick with those.

I named the register layout on the basis of the original usage
which started in the 8250 port driver with the au_* accessor functions.

The earlycon functions I named that way because that's the name of
the earlycon (which originates from the DT compatible key which can't be
changed).

I do want people to be able to find other relevant code by grepping
these names, so I was thinking of adding a follow-on patch that uses the
AU1x00_ register names in the 8250 port driver LUT.

Regards,
Peter Hurley
