From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH/RFC v2] serial: sh-sci: Add device tree support for r8a7779
Date: Wed, 30 Apr 2014 03:06:49 +0200
Message-ID: <2737920.PNRvA9nzcM@avalon>
References: <1398756011-4672-1-git-send-email-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1398756011-4672-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-sh-owner@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Simon,

Thank you for the patch.

I've CC'ed the DT list which seems to have been forgotten.

On Tuesday 29 April 2014 16:20:11 Simon Horman wrote:
> Simply document a new compat string.
> There appears to be no need for a driver updates.
> 
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> 
> ---
> 
> v2
> * Do not update the driver to set SCSCR_CKE1.
>   Instead DT may provide the P clock as the clock for the SCIF devices.
> ---
>  Documentation/devicetree/bindings/serial/renesas,sci-serial.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
> b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt index
> 53e6c17..bba86de 100644
> --- a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
> +++ b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
> @@ -12,6 +12,7 @@ Required properties:
>      - "renesas,scifa-r8a7791" for R8A7791 (R-Car M2) SCIFA compatible UART.
>      - "renesas,scifb-r8a7791" for R8A7791 (R-Car M2) SCIFB compatible UART.
>      - "renesas,hscif-r8a7791" for R8A7791 (R-Car M2) HSCIF compatible UART.
> +    - "renesas,scif-r8a7779" for R8A7779 (R-Car H1) SCIF compatible UART.

What about moving this at the top of the list to keep it sorted by SoC number 
?

Apart from that,

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

>      - "renesas,scif" for generic SCIF compatible UART.
>      - "renesas,scifa" for generic SCIFA compatible UART.
>      - "renesas,scifb" for generic SCIFB compatible UART.

-- 
Regards,

Laurent Pinchart

