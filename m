From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 2/2] Changes to existing files for 0PF FPGA board.
Date: Sat, 20 Jun 2015 10:00:37 +0200
Message-ID: <CAMuHMdXscFCvHGGkFvF6XPS9b=K+p7cCQrnUA86BMfyWpwHP1Q@mail.gmail.com>
References: <1434647946.861556@landley.net>
	<1434647946.861922@landley.net>
	<CAMuHMdV_hNng9MDotN3jidRdG+WEUwjDwYcmTTohLPtfMEoAKg@mail.gmail.com>
	<55849397.1060000@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <55849397.1060000@landley.net>
Sender: linux-sh-owner@vger.kernel.org
To: Rob Landley <rob@landley.net>
Cc: Jiri Slaby <jslaby@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@linaro.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Vivek Goyal <vgoyal@redhat.com>, "Steven Rostedt (Red Hat)" <rostedt@goodmis.org>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Riku Voipio <riku.voipio@linaro.org>, Jiri Kosina <jkosina@suse.cz>, Paul Bolle <pebolle@tiscali.nl>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Davidlohr Bueso <davidlohr@hp.com>, Richard Weinberger <richard@nod.at>, Zhigang Lu <zlu@tilera.com>, Vineet Gupta <vgupta@synopsys.com>, Richard Kuo <rkuo@codeaurora.org>, Max Filippov <jcmvbkbc@gmail.com>, Pranith Kumar <bobby.prani@gmail.com>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>linux-s
List-Id: linux-serial@vger.kernel.org

Hi Rob,

On Sat, Jun 20, 2015 at 12:11 AM, Rob Landley <rob@landley.net> wrote:
> On 06/18/2015 02:36 PM, Geert Uytterhoeven wrote:
>> On Thu, Jun 18, 2015 at 7:19 PM, Rob Landley <rob@landley.net> wrote:
>>> Changes to existing files to add 0pf j2 board support.
>>
>> Thanks for your patch!
>>
>> Like Greg already said, splitting it up in logical parts and providing useful
>> patch descriptions would be highly appreciated.
>
> I actually don't know how to split it up further. The initial port was
> done by a series of contractors (in Russia, I think), and then I
> inherited it to try to get something releasable. This is the smallest
> chunk I could get to actually boot.
>
> I suppose I could send you the serial driver by itself, and _then_ the
> board, but it wouldn't compile if nothing uses it. (Similarly you can't
> boot the board without a serial console...)

You don't have to send in a big initial patch that actually boots.
For new architecture/SoC/board support, just split it in logical hunks,
and submit it in some logical order that always builds.

E.g.:
  - SoC core support (arch/sh/),
  - Board support (arch/sh/),
  - Drivers.

The first two should go in through akpm (sh is orphaned),
the rest through the individual subsystem maintainers.

> (Now the reason _I_ thought you'd reject it had more to do with not
> having converted it to device tree yet, and things on that level. But I

Sh is an existing supported architecture, so DT is not a hard requirement.
If you would have waited until after the removal of sh, it would be much
harder :-) (cfr. h8300, but Sato-san did a great job there, with DT, CCF, ...)

> wanted to get it out there so people outside $DAYJOB can test the
> hardware. We did a linuxcon japan presentation which lwn.net covered,
> and we're getting pokes about "where can I download this", so...)

It's great to hear there's so much interest in this! Let's hope this will
attract more actual contributors...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
--
To unsubscribe from this list: send the line "unsubscribe linux-sh" in
