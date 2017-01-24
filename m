From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 7/7] arm64: dts: r8a7796: salvator-x: add SCIF1 (DEBUG1)
Date: Tue, 24 Jan 2017 09:08:17 +0100
Message-ID: <CAMuHMdW-+pBTnaaiT6B-NnSHQX6giSn0nSQs-+Lvuu1AsjrMOQ@mail.gmail.com>
References: <1485187458-8195-1-git-send-email-ulrich.hecht+renesas@gmail.com> <1485187458-8195-8-git-send-email-ulrich.hecht+renesas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1485187458-8195-8-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
List-Id: linux-serial@vger.kernel.org

Hi Uli,

On Mon, Jan 23, 2017 at 5:04 PM, Ulrich Hecht
<ulrich.hecht+renesas@gmail.com> wrote:
> Enables the SCIF hooked up to the DEBUG1 connector.
>
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> ---
>  arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts
> index c7f40f8..498d971 100644
> --- a/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts
> +++ b/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts
> @@ -18,6 +18,7 @@
>
>         aliases {
>                 serial0 = &scif2;
> +               serial1 = &scif1;

While the patch is acceptable as-is, my question is still valid:
Is there any specific reason you chose scif1 over hscif1?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
