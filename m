From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Subject: [PATCH v3 0/7] Renesas *SCIF* RX FIFO support
Date: Thu,  2 Feb 2017 18:10:13 +0100
Message-ID: <1486055420-31595-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-renesas-soc@vger.kernel.org, wsa@the-dreams.de, geert@linux-m68k.org
Cc: linux-serial@vger.kernel.org, magnus.damm@gmail.com, sergei.shtylyov@cogentembedded.com, gregkh@linuxfoundation.org, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
List-Id: linux-serial@vger.kernel.org

Hi!

This series implements support for using RX FIFO thresholds higher than one
in PIO mode on SCIF, HSCIF, SCIFA and SCIFB serial ports.

This revision has been rebased onto renesas-drivers-2017-01-24-v4.10-rc5 and
adds the missing changelog for "serial: sh-sci: increase RX FIFO trigger
defaults for (H)SCIF" requested by Geert and Greg.

CU
Uli


Changes since v2:
- rebase
- add missing changelog entry

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
 drivers/tty/serial/sh-sci.c                        | 273 ++++++++++++++++++---
 drivers/tty/serial/sh-sci.h                        |   8 +-
 3 files changed, 262 insertions(+), 33 deletions(-)

-- 
2.7.4
