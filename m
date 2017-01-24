From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 2/7] serial: sh-sci: consider DR (data ready) bit adequately
Date: Tue, 24 Jan 2017 08:57:05 +0100
Message-ID: <CAMuHMdULr-PF4eGhi3R7smGj_g3QNHgFxNABmALv3HM2_WyZ2w@mail.gmail.com>
References: <1485187458-8195-1-git-send-email-ulrich.hecht+renesas@gmail.com> <1485187458-8195-3-git-send-email-ulrich.hecht+renesas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1485187458-8195-3-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
List-Id: linux-serial@vger.kernel.org

On Mon, Jan 23, 2017 at 5:04 PM, Ulrich Hecht
<ulrich.hecht+renesas@gmail.com> wrote:
> To allow operation with a higher RX FIFO interrupt threshold in PIO
> mode, it is necessary to consider the DR bit ("FIFO not full, but no
> data received for 1.5 frames") as an indicator that data can be read.
> Otherwise the driver will let data rot in the FIFO until the threshold
> is reached.
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
