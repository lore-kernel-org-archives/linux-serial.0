From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Subject: RE: [PATCH] serial: sh-sci: Document r8a774a1 bindings
Date: Thu, 8 Nov 2018 11:19:17 +0000
Message-ID: <TY1PR01MB1770A808CD0FB80FD1AE263DC0C50@TY1PR01MB1770.jpnprd01.prod.outlook.com>
References: <1534250042-15815-1-git-send-email-fabrizio.castro@bp.renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1534250042-15815-1-git-send-email-fabrizio.castro@bp.renesas.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Fabrizio Castro <fabrizio.castro@bp.renesas.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Simon Horman <horms@verge.net.au>, Geert Uytterhoeven <geert+renesas@glider.be>, Chris Paterson <Chris.Paterson2@renesas.com>, Biju Das <biju.das@bp.renesas.com>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Dear All,

This is just a gentle reminder.

Thanks,
Fab

> From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Sent: 14 August 2018 13:34
> Subject: [PATCH] serial: sh-sci: Document r8a774a1 bindings
>
> RZ/G2M (R8A774A1) SoC also has the R-Car Gen3 compatible SCIF and
> HSCIF ports, so document the SoC specific bindings. While at it,
> update the RZ/G1 and RZ/G2 family specific strings description as
> outdated.
>
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das@bp.renesas.com>
> ---
>  .../devicetree/bindings/serial/renesas,sci-serial.txt      | 14 ++++++++=
------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/serial/renesas,sci-serial.=
txt b/Documentation/devicetree/bindings/serial/renesas,sci-
> serial.txt
> index eaca9da..1994ab8 100644
> --- a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
> +++ b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
> @@ -20,6 +20,8 @@ Required properties:
>      - "renesas,hscif-r8a7745" for R8A7745 (RZ/G1E) HSCIF compatible UART=
.
>      - "renesas,scif-r8a77470" for R8A77470 (RZ/G1C) SCIF compatible UART=
.
>      - "renesas,hscif-r8a77470" for R8A77470 (RZ/G1C) HSCIF compatible UA=
RT.
> +    - "renesas,scif-r8a774a1" for R8A774A1 (RZ/G2M) SCIF compatible UART=
.
> +    - "renesas,hscif-r8a774a1" for R8A774A1 (RZ/G2M) HSCIF compatible UA=
RT.
>      - "renesas,scif-r8a7778" for R8A7778 (R-Car M1) SCIF compatible UART=
.
>      - "renesas,scif-r8a7779" for R8A7779 (R-Car H1) SCIF compatible UART=
.
>      - "renesas,scif-r8a7790" for R8A7790 (R-Car H2) SCIF compatible UART=
.
> @@ -55,13 +57,13 @@ Required properties:
>      - "renesas,scifa-sh73a0" for SH73A0 (SH-Mobile AG5) SCIFA compatible=
 UART.
>      - "renesas,scifb-sh73a0" for SH73A0 (SH-Mobile AG5) SCIFB compatible=
 UART.
>      - "renesas,rcar-gen1-scif" for R-Car Gen1 SCIF compatible UART,
> -    - "renesas,rcar-gen2-scif" for R-Car Gen2 SCIF compatible UART,
> -    - "renesas,rcar-gen3-scif" for R-Car Gen3 SCIF compatible UART,
> -    - "renesas,rcar-gen2-scifa" for R-Car Gen2 SCIFA compatible UART,
> -    - "renesas,rcar-gen2-scifb" for R-Car Gen2 SCIFB compatible UART,
> +    - "renesas,rcar-gen2-scif" for R-Car Gen2 and RZ/G1 SCIF compatible =
UART,
> +    - "renesas,rcar-gen3-scif" for R-Car Gen3 and RZ/G2 SCIF compatible =
UART,
> +    - "renesas,rcar-gen2-scifa" for R-Car Gen2 and RZ/G1 SCIFA compatibl=
e UART,
> +    - "renesas,rcar-gen2-scifb" for R-Car Gen2 and RZ/G1 SCIFB compatibl=
e UART,
>      - "renesas,rcar-gen1-hscif" for R-Car Gen1 HSCIF compatible UART,
> -    - "renesas,rcar-gen2-hscif" for R-Car Gen2 HSCIF compatible UART,
> -    - "renesas,rcar-gen3-hscif" for R-Car Gen3 HSCIF compatible UART,
> +    - "renesas,rcar-gen2-hscif" for R-Car Gen2 and RZ/G1 HSCIF compatibl=
e UART,
> +    - "renesas,rcar-gen3-hscif" for R-Car Gen3 and RZ/G2 HSCIF compatibl=
e UART,
>      - "renesas,scif" for generic SCIF compatible UART.
>      - "renesas,scifa" for generic SCIFA compatible UART.
>      - "renesas,scifb" for generic SCIFB compatible UART.
> --
> 2.7.4




Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, B=
uckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered=
 No. 04586709.
