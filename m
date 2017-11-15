From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 1/2] serial: sh-sci: Support for variable HSCIF hardware
 RX timeout
Date: Wed, 15 Nov 2017 16:31:24 +0100
Message-ID: <CAMuHMdXXrxJo4cCxUGJH0o_x9yD3QEQZ_a5ktnxy5zbEd9dJdA@mail.gmail.com>
References: <1506690534-27302-1-git-send-email-ulrich.hecht+renesas@gmail.com>
 <1506690534-27302-2-git-send-email-ulrich.hecht+renesas@gmail.com> <20171115150615.tg4gwh3ekfew6dcx@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20171115150615.tg4gwh3ekfew6dcx@ninjato>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>
List-Id: linux-serial@vger.kernel.org

Hi Wolfram,

On Wed, Nov 15, 2017 at 4:06 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> On Fri, Sep 29, 2017 at 03:08:53PM +0200, Ulrich Hecht wrote:
>> HSCIF has facilities that allow changing the timeout after which an RX
>> interrupt is triggered even if the FIFO is not filled. This patch allows
>> changing the default (15 bits of silence) using the existing sysfs
>> attribute "rx_fifo_timeout".
>>
>> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
>
> Can't this patch be resent independently of the other? With Geert's tag
> added?

No need to resend, see commit fa2abb03637a5528 ("serial: sh-sci: Support
for variable HSCIF hardware RX timeout") in today's upstream.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
