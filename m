From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 0/4] ARM: dts: r8a777[89]: HSCIF support
Date: Thu, 17 Mar 2016 09:06:12 +0100
Message-ID: <CAMuHMdUCD8c3vA5YWaCavr3TMso0BGrxidQHbH-2WP593ZRdiA@mail.gmail.com>
References: <1458148210-21800-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1458148210-21800-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Cc: Simon Horman <horms@verge.net.au>, linux-renesas-soc@vger.kernel.org, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>
List-Id: linux-serial@vger.kernel.org

Hi Ulrich,

On Wed, Mar 16, 2016 at 6:10 PM, Ulrich Hecht
<ulrich.hecht+renesas@gmail.com> wrote:
> This adds HSCIF nodes to the r8a7778 and r8a7779 device trees.
> (And the relevant clocks on r8a7778, which are already there on r8a7779.)

Just wondering: have you tested this?

It seems serial0 on Bock-W can be pinmuxed to HSCIF0 instead of SCIF0.
On Marzen it's less easy, probably you need physical access to expansion
connectors.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
