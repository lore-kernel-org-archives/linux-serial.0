From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Subject: Re: Commit 18e8cf159177 broke qemu-system-sh4 serial input.
Date: Mon, 24 Apr 2017 09:23:26 +0200
Message-ID: <CAO3366wMgKrDXM5=HO27TiU7kZqBO-hFxuzVJkJLbNz82zAodw@mail.gmail.com>
References: <41d6bb75-5be0-c563-0569-ea37aab58f1e@landley.net>
 <CAMuHMdWtBHTBCNo2-oO2Zv7O8McypcaEMh+_8DD+D1T7GTxAzw@mail.gmail.com> <fc641b90-e939-e9cc-8621-f4f6d202b0da@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <fc641b90-e939-e9cc-8621-f4f6d202b0da@landley.net>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Rob Landley <rob@landley.net>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Linux-sh list <linux-sh@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Sat, Apr 22, 2017 at 10:49 AM, Rob Landley <rob@landley.net> wrote:
>
>
> On 04/21/2017 02:26 AM, Geert Uytterhoeven wrote:
>> According to the SH7751R datasheet, SCFCR does have the RTRG1 and RTRG0 bits.
>> I assume the problem goes away if you comment out the call to scif_set_rtrg()?
>
> The current code has been further complicated by two more commits
> (039403765 and 90afa5255) doing who knows what, but deleting the
> "scif_set_rtrg(port, s->rx_trigger);" from sci_reset() does appear to
> fix the problem.

Most(?) SCIFs have a feature that is always enabled and that asserts
DR even if the FIFO threshold has not been reached if no data is
received for 1.5 frames. Exceptions known to me are SCIFA/Bs, which
require special handling for it to work, and SH7705's SCIF, which does
not seem to have this at all. According to its datasheet, the
SH7751R's SCIF has the timeout feature, so I would have expected it to
work...

CU
Uli
