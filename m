From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [RFC v2 5/6] max9260: add driver for i2c over GMSL passthrough
Date: Tue, 18 Jul 2017 08:51:06 +0200
Message-ID: <CAMuHMdWybpNd0=iVaiJbO=31jBMFi+Zq+jQ0tcEsXEdxLrh-Nw@mail.gmail.com>
References: <1500305076-15570-1-git-send-email-ulrich.hecht+renesas@gmail.com> <1500305076-15570-6-git-send-email-ulrich.hecht+renesas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1500305076-15570-6-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh@kernel.org>, Peter Rosin <peda@axentia.se>, Linux I2C <linux-i2c@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi Ulrich,

On Mon, Jul 17, 2017 at 5:24 PM, Ulrich Hecht
<ulrich.hecht+renesas@gmail.com> wrote:
> This driver implements tunnelling of i2c requests over GMSL via a
> MAX9260 deserializer. It provides an i2c adapter that can be used
> to reach devices on the far side of the link.
>
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Thanks for your patch!

> --- /dev/null
> +++ b/drivers/media/i2c/max9260.c
> @@ -0,0 +1,288 @@

> +static void max9260_transact(struct max9260_device *dev,
> +                            int expect,
> +                            u8 *request, int len)

const u8 *request (or const void *?)

> +static int max9260_read_reg(struct max9260_device *dev, int reg)
> +{
> +       u8 request[] = { 0x79, 0x91, reg, 1 };

static const

I don't know if this buffer is ever copied. If not, perhaps it should not be
on the stack anyway because some serial drivers may not support DMA
from stack buffers?
This applies to all buffers below.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
