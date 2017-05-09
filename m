From: Dong Aisheng <aisheng.dong@nxp.com>
Subject: [PATCH 0/6] tty: serial: lpuart: add imx7ulp support
Date: Tue, 9 May 2017 15:50:42 +0800
Message-ID: <1494316248-24052-1-git-send-email-aisheng.dong@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org, jslaby@suse.com, fugang.duan@nxp.com, stefan@agner.ch, Mingkai.Hu@nxp.com, yangbo.lu@nxp.com, Dong Aisheng <aisheng.dong@nxp.com>
List-Id: linux-serial@vger.kernel.org

This patch series mainly intends to add imx7ulp support which is also
using FSL lpuart.

The lpuart in imx7ulp is basically the same as ls1021a. It's also
32 bit width register, but unlike ls1021a, it's little endian.
Besides that, imx7ulp lpuart has a minor different register layout
from ls1021a that it has four extra registers (verid, param, global,
pincfg) located at the beginning of register map, which are currently
not used by the driver and less to be used later.

Furthermore, this patch serial also add a new more accurate baud rate
calculation method as MX7ULP can't divide a suitable baud rate
with the default setting.

Currently the new baud rate calculation is only enabled on MX7ULP.
However, i guess the Layerscape may also be able to use it as there
seems to be no difference in baud rate setting register after checking
the Layerscape Reference Manual.

As i don't have Layerscape boards, i can't test it, so i only enable it
for MX7ULP by default to avoid a potential break.

I copied LayerScape guys in this series and hope they can help test later.
If it works on Layerscape as well, then they can switch to the new setting
too and totally remove the old stuff.

Dong Aisheng (6):
  tty: serial: lpuart: introduce lpuart_soc_data to represent SoC
    property
  tty: serial: lpuart: add little endian 32 bit register support
  dt-bindings: serial: fsl-lpuart: add i.MX7ULP support
  tty: serial: lpuart: add imx7ulp support
  tty: serial: lpuart: add earlycon support for imx7ulp
  tty: serial: lpuart: add a more accurate baud rate calculation method

 .../devicetree/bindings/serial/fsl-lpuart.txt      |   2 +
 drivers/tty/serial/fsl_lpuart.c                    | 149 ++++++++++++++++++---
 2 files changed, 136 insertions(+), 15 deletions(-)

-- 
2.7.4
