From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 1/7] serial: sh-sci: add FIFO trigger bits
Date: Wed, 14 Dec 2016 14:35:48 +0100
Message-ID: <CAMuHMdU6EECyeeq=safmYsO1Dy6AXiY2C1nUW7_dLU5koaUmBg@mail.gmail.com>
References: <1481286971-16667-1-git-send-email-ulrich.hecht+renesas@gmail.com> <1481286971-16667-2-git-send-email-ulrich.hecht+renesas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1481286971-16667-2-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>
List-Id: linux-serial@vger.kernel.org

Hi Ulrich,

On Fri, Dec 9, 2016 at 1:36 PM, Ulrich Hecht
<ulrich.hecht+renesas@gmail.com> wrote:
> Defines the bits controlling FIFO thresholds, adds the additional
> HSCIF registers to the register map.
>
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Minor comment below.

> --- a/drivers/tty/serial/sh-sci.h
> +++ b/drivers/tty/serial/sh-sci.h
> @@ -29,6 +29,8 @@ enum {
>         SCPDR,                          /* Serial Port Data Register */
>         SCDL,                           /* BRG Frequency Division Register */
>         SCCKS,                          /* BRG Clock Select Register */
> +       HSRTRGR,                        /* Receive FIFO Data Count Register */

Receive FIFO Data Count Trigger Register

(to avoid confusion with the FIFO Data Count Register)

> +       HSTTRGR,                        /* Transmit FIFO Data Count Register */

Transmit FIFO Data Count Trigger Register

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
