From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 2/2] serial: sh-sci: Add device tree support for r7s72100
Date: Mon, 17 Nov 2014 10:37:58 +0900
Message-ID: <20141117013757.GL11143@verge.net.au>
References: <1415980772-13287-1-git-send-email-geert+renesas@glider.be>
 <1415980772-13287-2-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:40001 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751928AbaKQBiB (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 16 Nov 2014 20:38:01 -0500
Content-Disposition: inline
In-Reply-To: <1415980772-13287-2-git-send-email-geert+renesas@glider.be>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, devicetree@vger.kernel.org, linux-sh@vger.kernel.org, linux-serial@vger.kernel.org

On Fri, Nov 14, 2014 at 04:59:32PM +0100, Geert Uytterhoeven wrote:
> Simply document the new compat string (and keep the list sorted by SoC).
> There appears to be no need for a driver update.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Simon Horman <horms+renesas@verge.net.au>

> ---
>  Documentation/devicetree/bindings/serial/renesas,sci-serial.txt | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
> index 7b87eb2c66be3131..ae73bb0e9ad9e58b 100644
> --- a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
> +++ b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
> @@ -4,8 +4,7 @@ Required properties:
>  
>    - compatible: Must contain one of the following:
>  
> -    - "renesas,scifa-sh73a0" for SH73A0 (SH-Mobile AG5) SCIFA compatible UART.
> -    - "renesas,scifb-sh73a0" for SH73A0 (SH-Mobile AG5) SCIFB compatible UART.
> +    - "renesas,scif-r7s72100" for R7S72100 (RZ/A1H) SCIF compatible UART.
>      - "renesas,scifa-r8a73a4" for R8A73A4 (R-Mobile APE6) SCIFA compatible UART.
>      - "renesas,scifb-r8a73a4" for R8A73A4 (R-Mobile APE6) SCIFB compatible UART.
>      - "renesas,scifa-r8a7740" for R8A7740 (R-Mobile A1) SCIFA compatible UART.
> @@ -24,6 +23,8 @@ Required properties:
>      - "renesas,scifa-r8a7794" for R8A7794 (R-Car E2) SCIFA compatible UART.
>      - "renesas,scifb-r8a7794" for R8A7794 (R-Car E2) SCIFB compatible UART.
>      - "renesas,hscif-r8a7794" for R8A7794 (R-Car E2) HSCIF compatible UART.
> +    - "renesas,scifa-sh73a0" for SH73A0 (SH-Mobile AG5) SCIFA compatible UART.
> +    - "renesas,scifb-sh73a0" for SH73A0 (SH-Mobile AG5) SCIFB compatible UART.
>      - "renesas,scif" for generic SCIF compatible UART.
>      - "renesas,scifa" for generic SCIFA compatible UART.
>      - "renesas,scifb" for generic SCIFB compatible UART.
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
