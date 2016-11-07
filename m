From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH/RFC] serial: sh-sci: Fix deadlock caused by serial output request
Date: Mon, 7 Nov 2016 16:20:56 +0100
Message-ID: <CAMuHMdW8VPo5Vx08CdN9ZHw=ujamNc+Th5VftE5CxJdxbGwZVg@mail.gmail.com>
References: <1478531681-1561-1-git-send-email-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1478531681-1561-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa@sang-engineering.com>, Magnus Damm <magnus.damm@gmail.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Mon, Nov 7, 2016 at 4:14 PM, Simon Horman <horms+renesas@verge.net.au> wrote:
> From: Takatoshi Akiyama <takatoshi.akiyama.kj@ps.hitachi-solutions.com>
>
> While spin is already locked, serial output request causes the deadlock,
> because serial output process also tries to lock the spin.
> This patch removes serial output with spin locked.
>
> Signed-off-by: Takatoshi Akiyama <takatoshi.akiyama.kj@ps.hitachi-solutions.com>
> Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
