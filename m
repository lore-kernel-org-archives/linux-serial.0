From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 00/25] serial: sh-sci: Add external clock and BRG Support
Date: Tue, 24 Nov 2015 11:43:14 +0900
Message-ID: <20151124024314.GD21853@verge.net.au>
References: <1447958344-836-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1447958344-836-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Magnus Damm <magnus.damm@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Thu, Nov 19, 2015 at 07:38:39PM +0100, Geert Uytterhoeven wrote:
> 	Hi,
> 
> This patch series adds support to the Renesas SCI serial driver for
>   - the optional external clock on (H)SCI(F) and some SCIFA, where this
>     pin can serve as a clock input,
>   - the optional clock sources for the Baud Rate Generator for External
>     Clock (BRG), as found on some SCIF variants and on HSCIF.
> Using external clocks increases the range and accuracy of supported baud
> rates. Please see the descriptions of the DTS patches for more detailed
> information regarding the impact on the supported platforms.
> 
> For now this supports r8a7791/koelsch and r8a7795/salvator-x only, which
> have an external SCIF_CLK running at 14.7456 MHz.
> Support for other R-Car platforms will be added later.
> 
> Testing:
>   - The Baud Rate Generator for External Clock (BRG) was tested with
>     SCIF and HSCIF on r8a7791/koelsch and r8a7795/salvator-x,
>   - The external clock input on (H)SCK was tested on r8a7795/salvator-x
>     by feeding an external clock signal to (H)SCIF1,
>   - Various bit rates were monitored using a SmartScope,
>   - Regression testing was done on Renesas ARM platforms that use SCIFA
>     as the console (r8a73a4/ape6evm, r8a7740/armadillo, and
>     sh73a0/kzm9g).
> 	      
> Dependencies:
>   - This series depends on the series "[PATCH v2 00/16] serial: sh-sci:
>     Clock Cleanups",
>   - The SH patch 25 depends on the "serial: sh-sci" patches in this
>     series,
>   - The DTS patches 21-24 can be applied independently, once the DT
>     binding patches 1-2 are accepted,

I have marked those patches as deferred pending the bindings being
accepted.

>   - r8a7791/r8a7795 has a runtime dependency on series "[PATCH 0/2]
>     pinctrl: sh-pfc: r8a7791/r8a7795: Add SCIF_CLK support",
>   - r8a7795 also depends on
>        - platform support in e.g. renesas-drivers-2015-11-17-v4.4-rc1,
>        - "[PATCH] pinctrl: sh-pfc: r8a7795: Add HSCIF pins, groups, and
> 	 functions",
>        - "[PATCH] arm64: renesas: r8a7795 dtsi: Add all HSCIF nodes".
>   - Legacy SH has a runtime dependency on:
>       - series "[PATCH 0/2] drivers: sh: clk: Cleanup clock API",
