From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 00/25] serial: sh-sci: Add external clock and BRG Support
Date: Thu, 19 Nov 2015 23:08:55 +0200
Message-ID: <1662323.uZlFXR9U2a@avalon>
References: <1447958344-836-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1447958344-836-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Geert,

Thank you for the patches.

For patches 3-6, 13, 15-16 and 22 and 24,

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

I'm not sure I'd bother with patch 25/25, but I'm not against merging it 
either. I'd be surprised if the serial driver still worked at all on SH :-)

On Thursday 19 November 2015 19:38:39 Geert Uytterhoeven wrote:
> 	Hi,
> 
> This patch series adds support to the Renesas SCI serial driver for
>   - the optional external clock on (H)SCI(F) and some SCIFA, where this
>     pin can serve as a clock input,
>   - the optional clock sources for the Baud Rate Generator for External
>     Clock (BRG), as found on some SCIF variants and on HSCIF.

Could you briefly explain (and even better in a source code comment) how you 
handle baud rate calculation with the chained BRGs ?

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
>   - r8a7791/r8a7795 has a runtime dependency on series "[PATCH 0/2]
>     pinctrl: sh-pfc: r8a7791/r8a7795: Add SCIF_CLK support",
>   - r8a7795 also depends on
>        - platform support in e.g. renesas-drivers-2015-11-17-v4.4-rc1,
>        - "[PATCH] pinctrl: sh-pfc: r8a7795: Add HSCIF pins, groups, and
> 	 functions",
>        - "[PATCH] arm64: renesas: r8a7795 dtsi: Add all HSCIF nodes".
>   - Legacy SH has a runtime dependency on:
>       - series "[PATCH 0/2] drivers: sh: clk: Cleanup clock API",
> 
> Thanks for your comments!
> 
> Geert Uytterhoeven (25):
>   serial: sh-sci: Update DT binding documentation for external clock
>     input
>   serial: sh-sci: Update DT binding documentation for BRG support
>   serial: sh-sci: Drop useless check for zero sampling_rate
>   serial: sh-sci: Grammar s/Get ... for/Get ... from/
>   serial: sh-sci: Drop unused frame_len parameter for
>     sci_baud_calc_hscif()
>   serial: sh-sci: Don't overwrite clock selection in
>     serial_console_write()
>   serial: sh-sci: Convert from clk_get() to devm_clk_get()
>   serial: sh-sci: Make unsigned values in sci_baud_calc_hscif() unsigned
>   serial: sh-sci: Avoid overflow in sci_baud_calc_hscif()
>   serial: sh-sci: Improve bit rate error calculation for HSCIF
>   serial: sh-sci: Avoid calculating the receive margin for HSCIF
>   serial: sh-sci: Merge sci_scbrr_calc() and sci_baud_calc_hscif()
>   serial: sh-sci: Take into account sampling rate for max baud rate
>   serial: sh-sci: Add BRG register definitions
>   serial: sh-sci: Replace struct sci_port_info by type/regtype encoding
>   serial: sh-sci: Correct SCIF type on RZ/A1H
>   serial: sh-sci: Correct SCIF type on R-Car for BRG
>   serial: sh-sci: Prepare for multiple clocks and baud rate generators
>   serial: sh-sci: Add support for optional external (H)SCK input
>   serial: sh-sci: Add support for optional BRG on (H)SCIF
>   ARM: shmobile: r8a7791 dtsi: Add BRG support for (H)SCIF
>   ARM: shmobile: koelsch dts: Enable SCIF_CLK frequency and pins
>   arm64: renesas: r8a7795 dtsi: Add BRG support for (H)SCIF
>   arm64: renesas: salvator-x dts: Enable SCIF_CLK frequency and pins
>   sh: sh7734: Correct SCIF type for BRG
> 
>  .../bindings/serial/renesas,sci-serial.txt         |   9 +
>  arch/arm/boot/dts/r8a7791-koelsch.dts              |  13 +
>  arch/arm/boot/dts/r8a7791.dtsi                     |  54 ++-
>  arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts |  12 +
>  arch/arm64/boot/dts/renesas/r8a7795.dtsi           |  74 ++-
>  arch/sh/kernel/cpu/sh4a/setup-sh7734.c             |  12 +-
>  drivers/tty/serial/sh-sci.c                        | 530 ++++++++++++------
>  drivers/tty/serial/sh-sci.h                        |   5 +
>  include/linux/serial_sci.h                         |   1 +
>  9 files changed, 508 insertions(+), 202 deletions(-)

-- 
Regards,

Laurent Pinchart

