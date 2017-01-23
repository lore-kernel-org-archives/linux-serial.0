From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Subject: [PATCH v2 0/7] Renesas *SCIF* RX FIFO support
Date: Mon, 23 Jan 2017 17:04:11 +0100
Message-ID: <1485187458-8195-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-renesas-soc@vger.kernel.org, wsa@the-dreams.de, geert@linux-m68k.org
Cc: linux-serial@vger.kernel.org, magnus.damm@gmail.com, sergei.shtylyov@cogentembedded.com, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
List-Id: linux-serial@vger.kernel.org

Hi!

This series implements support for using RX FIFO thresholds higher than one
in PIO mode on SCIF, HSCIF, SCIFA and SCIFB serial ports.

This revision addresses the issues found by Geert and Sergei in their
reviews, see below for details.

Setting the RX trigger on SH77xx-style ports is still not handled correctly,
mostly because we don't have any hardware to test against. I have changed
the trigger default for these ports to 1 to avoid regressions.

CU
Uli


Changes since v1:
- clarify HS trigger register enum
- simplify DR bit handling
- if() cascade -> switch()
- disable RX trigger for SH77xx-style ports
- clean up on failure to create sysfs attribute
- r8a7796 DT: add control pins, rtscts flag


Ulrich Hecht (7):
  serial: sh-sci: add FIFO trigger bits
  serial: sh-sci: consider DR (data ready) bit adequately
  serial: sh-sci: implement FIFO threshold register setting
  serial: sh-sci: increase RX FIFO trigger defaults for (H)SCIF
  serial: sh-sci: SCIFA/B RX FIFO software timeout
  serial: sh-sci: make RX FIFO parameters tunable via sysfs
  arm64: dts: r8a7796: salvator-x: add SCIF1 (DEBUG1)

 arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts |  14 ++
 drivers/tty/serial/sh-sci.c                        | 259 ++++++++++++++++++---
 drivers/tty/serial/sh-sci.h                        |   8 +-
 3 files changed, 248 insertions(+), 33 deletions(-)

-- 
2.7.4
