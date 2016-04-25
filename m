From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: sh-sci regression without scif_clk in 4.6-rc5
Date: Mon, 25 Apr 2016 14:44:05 +0200
Message-ID: <CAMuHMdUiMM4c+f2t8ZVAfpN-9+gdQFfffT40fiqsE=+JmRvQ4w@mail.gmail.com>
References: <1461587081.28870.2.camel@bitron.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1461587081.28870.2.camel@bitron.ch>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: =?UTF-8?Q?J=C3=BCrg_Billeter?= <j@bitron.ch>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, linux-renesas-soc@vger.kernel.org, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi J=C3=BCrg,

On Mon, Apr 25, 2016 at 2:24 PM, J=C3=BCrg Billeter <j@bitron.ch> wrote=
:
> testing 4.6-rc5 on a custom R-Car H3 board, I noticed that the Linux
> console attached to SCIF2 no longer works (it works on 4.5). earlycon
> works fine, though. Unlike Salvator-X, this H3 board does not use an
> external SCIF clock and thus, scif_clk is not enabled in the board
> device tree.
>
> The first "bad" commit is
> commit 3e5dd6f6e690048d0fd1c913397506648724474e
> Author: Geert Uytterhoeven <geert+renesas@glider.be>
> Date:   Fri Feb 26 16:54:31 2016 +0100
>
>     clk: Ignore disabled DT clock providers
>
> As far as I can tell, the issue is that, with the above commit,
> devm_clk_get() returns -EPROBE_DEFER for disabled clocks and the sh-s=
ci
> driver aborts probing with -EPROBE_DEFER even though scif_clk is
> optional.
>
> I can work around this issue with the patch below but I'm not sure
> about the correct fix. Intuitively, I would expect devm_clk_get() to
> return -ENOENT instead of -EPROBE_DEFER for disabled clocks but I don=
't
> know whether this can be changed in the common clock framework withou=
t
> risking issues in other places.
>
> What do you think is the best solution to this issue?

The real issue is that scif_clk in r8a7795.dtsi should not be marked
disabled.

Cfr. "ARM: dts: r8a7791: Don't disable referenced optional clocks"
https://git.kernel.org/cgit/linux/kernel/git/horms/renesas.git/commit/?=
h=3Dfixes-for-v4.6&id=3Dac6908b3049397b10bcfd8143d79cbdbbd266f02

Will fix and send patches for all other affected SoCs...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-=
m68k.org

In personal conversations with technical people, I call myself a hacker=
=2E But
when I'm talking to journalists I just say "programmer" or something li=
ke that.
                                -- Linus Torvalds
