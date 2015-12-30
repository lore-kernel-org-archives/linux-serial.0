From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [git pull/resend] serial: sh-sci: External Clock Support for v4.5
Date: Wed, 30 Dec 2015 11:40:48 +0100
Message-ID: <1451472048-25592-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Simon Horman <horms+renesas@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

	Hi Greg,

The following changes since commit 8005c49d9aea74d382f474ce11afbbc7d7130bec:

  Linux 4.4-rc1 (2015-11-15 17:00:27 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git scif-clk-sck-brg-for-v4.5

for you to fetch changes up to 192d367f218d0cd94aa9b5059992e4aa19ec5b36:

  serial: sh-sci: Drop the sci_fck clock fallback (2015-12-17 11:19:12 +0100)

Summary:
  - Clean up the naming of clocks in the sh-sci driver and its DT bindings,
  - Add support for the optional external clock on (H)SCI(F), where this pin
    can serve as a clock input,
  - Add support for the optional clock sources for the Baud Rate
    Generator for External Clock (BRG), as found on some SCIF variants
    and on HSCIF.

Thanks for pulling!

----------------------------------------------------------------
Geert Uytterhoeven (23):
      serial: sh-sci: Add fallback compatibility strings
      serial: sh-sci: Update DT binding documentation for external clock input
      serial: sh-sci: Update DT binding documentation for BRG support
      serial: sh-sci: Drop useless check for zero sampling_rate
      serial: sh-sci: Grammar s/Get ... for/Get ... from/
      serial: sh-sci: Use existing local variable in sci_parse_dt()
      serial: sh-sci: Drop unused frame_len parameter for sci_baud_calc_hscif()
      serial: sh-sci: Don't overwrite clock selection in serial_console_write()
      serial: sh-sci: Convert from clk_get() to devm_clk_get()
      serial: sh-sci: Make unsigned values in sci_baud_calc_hscif() unsigned
      serial: sh-sci: Avoid overflow in sci_baud_calc_hscif()
      serial: sh-sci: Improve bit rate error calculation for HSCIF
      serial: sh-sci: Avoid calculating the receive margin for HSCIF
      serial: sh-sci: Merge sci_scbrr_calc() and sci_baud_calc_hscif()
      serial: sh-sci: Take into account sampling rate for max baud rate
      serial: sh-sci: Add BRG register definitions
      serial: sh-sci: Replace struct sci_port_info by type/regtype encoding
      serial: sh-sci: Correct SCIF type on RZ/A1H
      serial: sh-sci: Correct SCIF type on R-Car for BRG
      serial: sh-sci: Prepare for multiple sampling clock sources
      serial: sh-sci: Add support for optional external (H)SCK input
      serial: sh-sci: Add support for optional BRG on (H)SCIF
      sh: sh7734: Correct SCIF type for BRG

Laurent Pinchart (4):
      serial: sh-sci: Drop the interface clock
      sh: Rename sci_ick and sci_fck clock to fck
      sh: Remove sci_ick clock alias
      serial: sh-sci: Drop the sci_fck clock fallback

 .../bindings/serial/renesas,sci-serial.txt         |  32 +-
 arch/sh/kernel/cpu/clock-cpg.c                     |   1 -
 arch/sh/kernel/cpu/sh2a/clock-sh7264.c             |   9 +-
 arch/sh/kernel/cpu/sh2a/clock-sh7269.c             |  16 +-
 arch/sh/kernel/cpu/sh4a/clock-sh7343.c             |   8 +-
 arch/sh/kernel/cpu/sh4a/clock-sh7366.c             |   6 +-
 arch/sh/kernel/cpu/sh4a/clock-sh7723.c             |  12 +-
 arch/sh/kernel/cpu/sh4a/clock-sh7734.c             |  12 +-
 arch/sh/kernel/cpu/sh4a/clock-sh7757.c             |   6 +-
 arch/sh/kernel/cpu/sh4a/clock-sh7785.c             |  12 +-
 arch/sh/kernel/cpu/sh4a/clock-sh7786.c             |  12 +-
 arch/sh/kernel/cpu/sh4a/clock-shx3.c               |   8 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7734.c             |  12 +-
 drivers/tty/serial/sh-sci.c                        | 555 +++++++++++++++------
 drivers/tty/serial/sh-sci.h                        |  10 +
 include/linux/serial_sci.h                         |   1 +
 16 files changed, 500 insertions(+), 212 deletions(-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
