From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 2/2] Changes to existing files for 0PF FPGA board.
Date: Sat, 20 Jun 2015 22:48:30 +0200
Message-ID: <CAMuHMdVucr68GKHnGkCYeEwozUOMUDkAFDAOffn2_U3VkUeKJQ@mail.gmail.com>
References: <1434647946.861556@landley.net>
	<1434647946.861922@landley.net>
	<CAMuHMdV_hNng9MDotN3jidRdG+WEUwjDwYcmTTohLPtfMEoAKg@mail.gmail.com>
	<55849397.1060000@landley.net>
	<CAMuHMdXscFCvHGGkFvF6XPS9b=K+p7cCQrnUA86BMfyWpwHP1Q@mail.gmail.com>
	<5585C952.6020406@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <5585C952.6020406@landley.net>
Sender: linux-sh-owner@vger.kernel.org
To: Rob Landley <rob@landley.net>
Cc: Jiri Slaby <jslaby@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@linaro.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Vivek Goyal <vgoyal@redhat.com>, "Steven Rostedt (Red Hat)" <rostedt@goodmis.org>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Riku Voipio <riku.voipio@linaro.org>, Jiri Kosina <jkosina@suse.cz>, Paul Bolle <pebolle@tiscali.nl>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Davidlohr Bueso <davidlohr@hp.com>, Richard Weinberger <richard@nod.at>, Zhigang Lu <zlu@tilera.com>, Vineet Gupta <vgupta@synopsys.com>, Richard Kuo <rkuo@codeaurora.org>, Max Filippov <jcmvbkbc@gmail.com>, Pranith Kumar <bobby.prani@gmail.com>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>linux-s
List-Id: linux-serial@vger.kernel.org

Hi Rob,

On Sat, Jun 20, 2015 at 10:13 PM, Rob Landley <rob@landley.net> wrote:
>>> (Now the reason _I_ thought you'd reject it had more to do with not
>>> having converted it to device tree yet, and things on that level. But I
>>
>> Sh is an existing supported architecture, so DT is not a hard requirement.
>
> Yeah, but new board... And it's the right thing to do.

Still, people wouldn't be unhappy if you added DT support ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
--
To unsubscribe from this list: send the line "unsubscribe linux-sh" in
