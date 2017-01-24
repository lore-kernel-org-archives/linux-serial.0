From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 6/7] serial: sh-sci: make RX FIFO parameters tunable
 via sysfs
Date: Tue, 24 Jan 2017 09:02:29 +0100
Message-ID: <CAMuHMdV2ush4n=aTLbJG3ATDJDXu4zakxu4HrAkWGouPwuxcog@mail.gmail.com>
References: <1485187458-8195-1-git-send-email-ulrich.hecht+renesas@gmail.com> <1485187458-8195-7-git-send-email-ulrich.hecht+renesas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1485187458-8195-7-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
List-Id: linux-serial@vger.kernel.org

On Mon, Jan 23, 2017 at 5:04 PM, Ulrich Hecht
<ulrich.hecht+renesas@gmail.com> wrote:
> Allows tuning of the RX FIFO fill threshold and timeout. (The latter is
> only applicable to SCIFA and SCIFB).
>
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
