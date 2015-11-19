From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 02/25] serial: sh-sci: Update DT binding documentation for BRG support
Date: Thu, 19 Nov 2015 22:26:04 +0200
Message-ID: <1577961.dn1fd8r35p@avalon>
References: <1447958344-836-1-git-send-email-geert+renesas@glider.be> <1447958344-836-3-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1447958344-836-3-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Geert,

Thank you for the patch.

On Thursday 19 November 2015 19:38:41 Geert Uytterhoeven wrote:
> Amend the DT bindings to include the optional clock sources for the Baud
> Rate Generator for External Clock (BRG), as found on some SCIF variants
> and on HSCIF.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: devicetree@vger.kernel.org
> ---
>  Documentation/devicetree/bindings/serial/renesas,sci-serial.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
> b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt index
> 8efc9b6f35637fbb..ae907e39b11c2a5a 100644
> --- a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
> +++ b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
> @@ -46,6 +46,12 @@ Required properties:
>      On (H)SCI(F) and some SCIFA, an additional clock may be specified:
>        - "hsck" for the optional external clock input (on HSCIF),
>        - "sck" for the optional external clock input (on other variants).
> +    On UARTs equipped with a Baud Rate Generator for External Clock (BRG)
> +    (some SCIF and HSCIF), additional clocks may be specified:
> +      - "int_clk" for the optional internal clock source for the frequency
> +	divider (typically the (AXI or SHwy) bus clock),

Isn't this always the same clock as the SCIF functional clock ?

> +      - "scif_clk" for the optional external clock source for the frequency
> +	divider (SCIF_CLK).
> 
>  Note: Each enabled SCIx UART should have an alias correctly numbered in the
> "aliases" node.

-- 
Regards,

Laurent Pinchart

