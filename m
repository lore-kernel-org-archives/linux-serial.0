From: Rob Landley <rob@landley.net>
Subject: Re: Commit 18e8cf159177 broke qemu-system-sh4 serial input.
Date: Mon, 24 Apr 2017 15:46:06 -0500
Message-ID: <e2896a92-389c-61f1-b9e7-4e039d6eb958@landley.net>
References: <41d6bb75-5be0-c563-0569-ea37aab58f1e@landley.net>
 <CAMuHMdWtBHTBCNo2-oO2Zv7O8McypcaEMh+_8DD+D1T7GTxAzw@mail.gmail.com>
 <fc641b90-e939-e9cc-8621-f4f6d202b0da@landley.net>
 <CAO3366wMgKrDXM5=HO27TiU7kZqBO-hFxuzVJkJLbNz82zAodw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <CAO3366wMgKrDXM5=HO27TiU7kZqBO-hFxuzVJkJLbNz82zAodw@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Linux-sh list <linux-sh@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On 04/24/2017 02:23 AM, Ulrich Hecht wrote:
> On Sat, Apr 22, 2017 at 10:49 AM, Rob Landley <rob@landley.net> wrote:
>> On 04/21/2017 02:26 AM, Geert Uytterhoeven wrote:
>>> According to the SH7751R datasheet, SCFCR does have the RTRG1 and RTRG0 bits.
>>> I assume the problem goes away if you comment out the call to scif_set_rtrg()?
>>
>> The current code has been further complicated by two more commits
>> (039403765 and 90afa5255) doing who knows what, but deleting the
>> "scif_set_rtrg(port, s->rx_trigger);" from sci_reset() does appear to
>> fix the problem.
> 
> Most(?) SCIFs have a feature that is always enabled and that asserts
> DR even if the FIFO threshold has not been reached if no data is
> received for 1.5 frames. Exceptions known to me are SCIFA/Bs, which
> require special handling for it to work, and SH7705's SCIF, which does
> not seem to have this at all. According to its datasheet, the
> SH7751R's SCIF has the timeout feature, so I would have expected it to
> work...

QEMU is an emulator. I've run sh4 linux on it for about 10 years now.
Sounds like they never implemented this feature because nothing used it
before now.

My general approach when dealing with this sort of thing is to point
figures at the thing that changed, and caused "it was working" to go to
"it's not working". When qemu broke this same sh4 serial port, I asked
_them_ to fix it:

https://lists.nongnu.org/archive/html/qemu-devel/2012-07/msg03929.html

Asking qemu to change means current kernels will never run on existing
qemu installations again, when they did for a decade now, which seems
like a regression to me?

Rob
