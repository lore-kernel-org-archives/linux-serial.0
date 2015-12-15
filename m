From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v3 00/27] serial: sh-sci: External Clock Support
Date: Tue, 15 Dec 2015 13:53:51 +0900
Message-ID: <20151215045350.GD32397@verge.net.au>
References: <1450119456-964-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1450119456-964-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Magnus Damm <magnus.damm@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-serial@vger.kernel.org, linux-sh@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Geert,

thanks for taking care of this, is quite a task!

On Mon, Dec 14, 2015 at 07:57:09PM +0100, Geert Uytterhoeven wrote:
> 	Hi Greg, Simon, Magnus, Sato-san,
> 
> This patch series contains several patches for the Renesas SCI serial
> driver:
>   - Clean up the naming of clocks in the driver and its DT bindings,
>   - Add support for the optional external clock on (H)SCI(F) and some
>     SCIFA, where this pin can serve as a clock input,
>   - Add support for the optional clock sources for the Baud Rate
>     Generator for External Clock (BRG), as found on some SCIF variants
>     and on HSCIF.
> Using external clocks increases the range and accuracy of supported baud
> rates.
> 
> This series is an updated version of the core (driver) changes of two
> series I sent before:
>   - [PATCH v2 00/16] serial: sh-sci: Clock Cleanups
>     (http://www.spinics.net/lists/linux-serial/msg19762.html)
>   - [PATCH 00/25] serial: sh-sci: Add external clock and BRG Support
>     (https://lkml.org/lkml/2015/11/19/550)
> To reduce (cross) dependencies, I split off the integration (DTS)
> patches into separate series:
>   - "[PATCH 0/7] ARM: shmobile: dtsi: Add SCIF fallback compatibility
>      strings",
>   - "[PATCH v3 00/12] ARM: shmobile: dtsi: Rename the serial port
>      clock to fck",
>   - "[PATCH v2 0/7] ARM: shmobile: dtsi: Add BRG support for (H)SCIF",
>   - "[PATCH v2 0/9] ARM: shmobile: dts: Enable SCIF_CLK frequency and
>     pins".
> As the SH architecture is orphaned, and the risk of conflicts is small,
> I have bundled all SH-specific changes with the core changes.  This
> reduces dependencies, too.

At this point I see two ways to move things forwards:

1. Greg can consider taking this series and I can take the
   related integration (DTS) series (noted below) into v4.6.
2. I can get some missing Acks from Greg (patches 02 and 07 I believe)
   and try and queue up this series and the related integration (DTS)
   series (noted below).

As it (perhaps surprisingly) it is late in the merge cycle for me to take
changes for v4.5 that will go though the ARM SoC tree and I am trying to
stabilise things a little. Thus, I favour option 1.

> Changes compared to previous submission (more detailed information in
> the individual patches):
>   - Add fallback compatibility strings for R-Car Gen1, Gen2, Gen3, which
>     allows the driver to match on (less) family-specific instead of
>     (more) SoC-specific compatible values,
>   - Rename "int_clk" to "brg_int", "SCI_INT_CLK" to "SCI_BRG_INT",
>   - Terminate loops over sampling rates on perfect matches,
>   - Many comments and clarifications in patch descriptions,
>   - Add Acked-by, Reviewed-by.
> 
> 
> This series consists of several parts:
>   - The first four patches update DT binding documentation.
>     The first patch also updates the driver, and is a hard dependency
>     for the integration (DTS) patches, and for the SH patches.
> 
>     [01/27] serial: sh-sci: Drop the interface clock
>     [02/27] serial: sh-sci: Add fallback compatibility strings (NEW)
>     [03/27] serial: sh-sci: Update DT binding documentation for external
> 			    clock input
>     [04/27] serial: sh-sci: Update DT binding documentation for BRG
> 			    support
> 
>   - Patches 5-23 update the driver only, and add external clock and BRG
>     support.
> 
>     [05/27] serial: sh-sci: Drop useless check for zero
>     [06/27] serial: sh-sci: Grammar s/Get ... for/Get ... from/
>     [07/27] serial: sh-sci: Use existing local variable in
> 			    sci_parse_dt() (NEW)
>     [08/27] serial: sh-sci: Drop unused frame_len parameter for
> 			    sci_baud_calc_hscif()
>     [09/27] serial: sh-sci: Don't overwrite clock selection in
> 			    serial_console_write()
>     [10/27] serial: sh-sci: Convert from clk_get() to devm_clk_get()
>     [11/27] serial: sh-sci: Make unsigned values in
> 			    sci_baud_calc_hscif() unsigned
>     [12/27] serial: sh-sci: Avoid overflow in sci_baud_calc_hscif()
>     [13/27] serial: sh-sci: Improve bit rate error calculation for
> 			    HSCIF
>     [14/27] serial: sh-sci: Avoid calculating the receive margin for
> 			    HSCIF
>     [15/27] serial: sh-sci: Merge sci_scbrr_calc() and
> 			    sci_baud_calc_hscif()
>     [16/27] serial: sh-sci: Take into account sampling rate for max baud
> 			    rate
>     [17/27] serial: sh-sci: Add BRG register definitions
>     [18/27] serial: sh-sci: Replace struct sci_port_info by type/regtype
> 			    encoding
>     [19/27] serial: sh-sci: Correct SCIF type on RZ/A1H
>     [20/27] serial: sh-sci: Correct SCIF type on R-Car for BRG
>     [21/27] serial: sh-sci: Prepare for multiple sampling clock sources
>     [22/27] serial: sh-sci: Add support for optional external (H)SCK
> 			    input
>     [23/27] serial: sh-sci: Add support for optional BRG on H)SCIF
> 
>   - Patches 24-26 update the SH architecture.
>     Patches 24 and 25 have a hard dependency on patch 1.
>     Patch 26 has a hard dependency on patch 17.
> 
>     [24/27] sh: Rename sci_ick and sci_fck clock to fck
>     [25/27] sh: Remove sci_ick clock alias
>     [26/27] sh: sh7734: Correct SCIF type for BRG
> 
>   - Patch 27 has a hard dependency on patch 24.
> 
>     [27/27] serial: sh-sci: Drop the sci_fck clock fallback
> 
> Testing:
>   - The Baud Rate Generator for External Clock (BRG) was tested on
>       - R-Car Gen1 (r8a7778/bockw, r8a7779/marzen, on SCIF),
>       - R-Car Gen2 (r8a7791/koelsch, on SCIF and HSCIF),
>       - R-Car Gen3 (r8a7795/salvator-x, on SCIF and HSCIF),
>   - The external clock input on (H)SCK was tested on
>       - R-Car Gen3 (r8a7795/salvator-x, on SCIF and HSCIF),
>   - Regression testing was done on Renesas ARM platforms that use SCIFA
>     as the console (r8a73a4/ape6evm, r8a7740/armadillo, and
>     sh73a0/kzm9g),
>   - You can find more testing-related information in the final
>     integration series.
> 
> Merge strategy:
>   - This series applies to v4.4-rc1,
>   - It would be good if at least the first 4 patches end up in v4.5, as
>     they contain DT bindings, and a hard dependency for some DTS
>     updates,
>   - If the 3 SH patches 24-26, and patch 27 go in together, this can be
>     done in the same release. Else the SH patches may have to wait for
>     v4.6, and patch 27 for v4.7.
>   - Greg has provided his ack for most patches (minus the SH-specific,
>     and the 2 new patches), and is OK for the patches going in through
>     another tree, so these could go in through Simon's tree as well,
>       - If these patches go in through Greg's tree, the DTS updates with
> 	a hard dependency on the first patch have to wait for v4.6,
>       - If these patches go in through Simon's tree, the DTS updates
> 	with a hard dependency on the first patch can go in v4.5, too,
>   - Note that some of the DTS updates have to wait for v4.6 due to other
>     dependencies (pinctrl, more info in the integration series),
>   - Note that there are a few unrelated sh-sci fixes floating around.
>     I think these should go through Greg's tree anyway (they are
>     unrelated, and I don't think these cause conflicts).
> 
> Greg/Simon, what do you think?
> 
> I've also pushed this series (against v4.4-rc1) to the
> topic/scif-clk-sck-brg-core-v3 branch of my renesas-drivers git
> repository at
> https://git.kernel.org/cgit/linux/kernel/git/geert/renesas-drivers.git
> 
> For testing, you best use the renesas-drivers-2015-12-14-v4.4-rc5 tag,
> as it includes the integration part.
> 
> Thanks for applying!
> 
> Geert Uytterhoeven (23):
>   serial: sh-sci: Add fallback compatibility strings
>   serial: sh-sci: Update DT binding documentation for external clock
>     input
>   serial: sh-sci: Update DT binding documentation for BRG support
>   serial: sh-sci: Drop useless check for zero sampling_rate
>   serial: sh-sci: Grammar s/Get ... for/Get ... from/
>   serial: sh-sci: Use existing local variable in sci_parse_dt()
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
>   serial: sh-sci: Prepare for multiple sampling clock sources
>   serial: sh-sci: Add support for optional external (H)SCK input
>   serial: sh-sci: Add support for optional BRG on (H)SCIF
>   sh: sh7734: Correct SCIF type for BRG
> 
> Laurent Pinchart (4):
>   serial: sh-sci: Drop the interface clock
>   sh: Rename sci_ick and sci_fck clock to fck
>   sh: Remove sci_ick clock alias
>   serial: sh-sci: Drop the sci_fck clock fallback
> 
>  .../bindings/serial/renesas,sci-serial.txt         |  32 +-
>  arch/sh/kernel/cpu/clock-cpg.c                     |   1 -
>  arch/sh/kernel/cpu/sh2a/clock-sh7264.c             |   9 +-
>  arch/sh/kernel/cpu/sh2a/clock-sh7269.c             |  16 +-
>  arch/sh/kernel/cpu/sh4a/clock-sh7343.c             |   8 +-
>  arch/sh/kernel/cpu/sh4a/clock-sh7366.c             |   6 +-
>  arch/sh/kernel/cpu/sh4a/clock-sh7723.c             |  12 +-
>  arch/sh/kernel/cpu/sh4a/clock-sh7734.c             |  12 +-
>  arch/sh/kernel/cpu/sh4a/clock-sh7757.c             |   6 +-
>  arch/sh/kernel/cpu/sh4a/clock-sh7785.c             |  12 +-
>  arch/sh/kernel/cpu/sh4a/clock-sh7786.c             |  12 +-
>  arch/sh/kernel/cpu/sh4a/clock-shx3.c               |   8 +-
>  arch/sh/kernel/cpu/sh4a/setup-sh7734.c             |  12 +-
>  drivers/tty/serial/sh-sci.c                        | 555 +++++++++++++++------
>  drivers/tty/serial/sh-sci.h                        |  10 +
>  include/linux/serial_sci.h                         |   1 +
>  16 files changed, 500 insertions(+), 212 deletions(-)
> 
> -- 
> 1.9.1
> 
> Gr{oetje,eeting}s,
> 
> 						Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
> 							    -- Linus Torvalds
> 
