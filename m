From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] serial: sh-sci: document R8A7797 bindings
Date: Fri, 25 Aug 2017 09:09:06 +0200
Message-ID: <CAMuHMdXkjYty_U9jA_Q-ziGcCSEa_GFLme5+XGgU3pLx5kTdDw@mail.gmail.com>
References: <20170824203144.032561541@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20170824203144.032561541@cogentembedded.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi Sergei,

On Thu, Aug 24, 2017 at 10:31 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> R-Car V3M (R8A7797) SoC also has the R-Car gen3 compatible SCIF and HSCIF
> ports, so document the SoC specific bindings.
>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>
> ---
> This patch is against the 'tty-next' branch of GregKH's 'tty.git' repo.
>
>  Documentation/devicetree/bindings/serial/renesas,sci-serial.txt |    2 ++
>  1 file changed, 2 insertions(+)
>
> Index: tty/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
> ===================================================================
> --- tty.orig/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
> +++ tty/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
> @@ -41,6 +41,8 @@ Required properties:
>      - "renesas,hscif-r8a7795" for R8A7795 (R-Car H3) HSCIF compatible UART.
>      - "renesas,scif-r8a7796" for R8A7796 (R-Car M3-W) SCIF compatible UART.
>      - "renesas,hscif-r8a7796" for R8A7796 (R-Car M3-W) HSCIF compatible UART.
> +    - "renesas,scif-r8a7797" for R8A7797 (R-Car V3M) SCIF compatible UART.
> +    - "renesas,hscif-r8a7797" for R8A7797 (R-Car V3M) HSCIF compatible UART.

Please use "renesas,scif-r8a77970" and "renesas,hscif-r8a77970" instead,
to follow the new 5-digit scheme started with r8a77995.

>      - "renesas,scifa-sh73a0" for SH73A0 (SH-Mobile AG5) SCIFA compatible UART.
>      - "renesas,scifb-sh73a0" for SH73A0 (SH-Mobile AG5) SCIFB compatible UART.
>      - "renesas,rcar-gen1-scif" for R-Car Gen1 SCIF compatible UART,

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
