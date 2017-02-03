From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v3 2/7] serial: sh-sci: consider DR (data ready) bit adequately
Date: Fri, 3 Feb 2017 10:31:26 +0100
Message-ID: <CAMuHMdX1xhgpFoTQpdJ7nfmfAB3jRTgBNQw1YzKfXaOuDUQ-2Q@mail.gmail.com>
References: <1486055420-31595-1-git-send-email-ulrich.hecht+renesas@gmail.com> <1486055420-31595-3-git-send-email-ulrich.hecht+renesas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1486055420-31595-3-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Greg KH <gregkh@linuxfoundation.org>
List-Id: linux-serial@vger.kernel.org

On Thu, Feb 2, 2017 at 6:10 PM, Ulrich Hecht
<ulrich.hecht+renesas@gmail.com> wrote:
> To allow operation with a higher RX FIFO interrupt threshold in PIO
> mode, it is necessary to consider the DR bit ("FIFO not full, but no
> data received for 1.5 frames") as an indicator that data can be read.
> Otherwise the driver will let data rot in the FIFO until the threshold
> is reached.
>
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Readding
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
