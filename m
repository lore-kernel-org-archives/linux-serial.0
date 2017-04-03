From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 0/5] minitty: a minimal TTY layer alternative for
 embedded systems
Date: Mon, 3 Apr 2017 20:14:08 +0200
Message-ID: <CAMuHMdUTW7Fh+3kWKFCToqhaz-+58--=Sx1Zv0KRnVY4bDKOGQ@mail.gmail.com>
References: <20170401222119.25106-1-nicolas.pitre@linaro.org>
 <87pogur0y9.fsf@firstfloor.org> <alpine.LFD.2.20.1704021729470.1847@knanqh.ubzr>
 <92fb1e4a-d6df-f55b-c0a1-9c1eb78e3943@longlandclan.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <92fb1e4a-d6df-f55b-c0a1-9c1eb78e3943@longlandclan.id.au>
Sender: linux-kernel-owner@vger.kernel.org
To: Stuart Longland <stuartl@longlandclan.id.au>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, Andi Kleen <andi@firstfloor.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

On Mon, Apr 3, 2017 at 12:44 AM, Stuart Longland
<stuartl@longlandclan.id.au> wrote:
> On 03/04/17 07:41, Nicolas Pitre wrote:
>>> No PTYs seems like a big limitation. This means no sshd?
>> Again, my ultimate system target is in the sub-megabyte of RAM.  I
>> really doubt you'll be able to fit an SSH server in there even if PTYs
>> were supported, unless sshd (or dropbear) can be made really tiny.
>> Otherwise you most probably have sufficient resources to run the regular
>> TTY code.
>
> Are we talking small microcontrollers here?  The smallest machine in
> terms of RAM I ever recall running Linux on was a 386SX/25 MHz with 4MB
> RAM, and that had a MMU.

Let's halve that. I once tried and ran Linux in 2 MiB, incl. X, twm, and xterm.
Of course with swap enabled.  And swapping like hell.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
