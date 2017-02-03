From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Subject: [PATCH v4 0/4] Renesas *SCIF* RX FIFO support
Date: Fri,  3 Feb 2017 11:38:16 +0100
Message-ID: <1486118300-12633-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-renesas-soc@vger.kernel.org, geert@linux-m68k.org, gregkh@linuxfoundation.org
Cc: wsa@the-dreams.de, linux-serial@vger.kernel.org, magnus.damm@gmail.com, sergei.shtylyov@cogentembedded.com, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
List-Id: linux-serial@vger.kernel.org

Hi!

This series implements support for using RX FIFO thresholds higher than one
in PIO mode on SCIF, HSCIF, SCIFA and SCIFB serial ports.

This revision is the remainder of the series rebased to apply cleanly to
tty-testing, with some minor style adjustments as suggested by Sergei.

CU
Uli


Changes since v3:
- rebased onto tty-testing
- fixed a few style issues

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


Ulrich Hecht (4):
  serial: sh-sci: increase RX FIFO trigger defaults for (H)SCIF
  serial: sh-sci: SCIFA/B RX FIFO software timeout
  serial: sh-sci: make RX FIFO parameters tunable via sysfs
  arm64: dts: r8a7796: salvator-x: add SCIF1 (DEBUG1)

 arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts |  14 ++
 drivers/tty/serial/sh-sci.c                        | 213 +++++++++++++++++----
 2 files changed, 195 insertions(+), 32 deletions(-)

-- 
2.7.4
