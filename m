From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Subject: [PATCH 0/7] Renesas *SCIF* RX FIFO support
Date: Fri,  9 Dec 2016 13:36:04 +0100
Message-ID: <1481286971-16667-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-renesas-soc@vger.kernel.org, wsa@the-dreams.de, geert@linux-m68k.org
Cc: linux-serial@vger.kernel.org, magnus.damm@gmail.com, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
List-Id: linux-serial@vger.kernel.org

Hi!

This series implements support for using RX FIFO thresholds higher than one
in PIO mode on SCIF, HSCIF, SCIFA and SCIFB serial ports.

This was originally implemented to fulfill a request for a software
timer-based solution, but I have found that it is not sensible to implement
such a feature on SCIF and HSCIF. These IPs do not support disabling of the
hardware timeout feature that all SCIFs have, and that triggers an interrupt
if no new data has arrived for more than 1.5 frames.

This series therefore enables the hardware timeout for SCIFs and HSCIFs, and
the software timeout for SCIFAs and SCIFBs only.

(Hardware timeout on SCIFA/B is possible, but has not been implemented here
due to a lack of time. The same goes for the limited amount of tuning of
the hardware timeout that is possible on HSCIF ports.)

Two sysfs attributes are added to tune the FIFO behavior:

- rx_fifo_trigger: Controls the trigger level at which an interrupt is
  forced. Works for both hardware and software timeout.
- rx_fifo_timeout: Software timeout in frames upon which the FIFOs are
  checked even if no interrupt is triggered. Zero (default) disables the
  timeout. (SCIFA and SCIFB only)

CU
Uli


Ulrich Hecht (7):
  serial: sh-sci: add FIFO trigger bits
  serial: sh-sci: consider DR (data ready) bit adequately
  serial: sh-sci: implement FIFO threshold register setting
  serial: sh-sci: increase RX FIFO trigger defaults for (H)SCIF
  serial: sh-sci: SCIFA/B RX FIFO software timeout
  serial: sh-sci: make RX FIFO parameters tunable via sysfs
  arm64: dts: r8a7796: salvator-x: add SCIF1 (DEBUG1)

 arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts |  12 +
 drivers/tty/serial/sh-sci.c                        | 254 ++++++++++++++++++---
 drivers/tty/serial/sh-sci.h                        |   7 +
 3 files changed, 238 insertions(+), 35 deletions(-)

-- 
2.7.4
