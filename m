From: Dong Aisheng <aisheng.dong@nxp.com>
Subject: [PATCH V3 0/7] tty: serial: lpuart: add imx7ulp support
Date: Mon, 12 Jun 2017 23:37:21 +0800
Message-ID: <1497281848-12995-1-git-send-email-aisheng.dong@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org, jslaby@suse.com, fugang.duan@nxp.com, stefan@agner.ch, Mingkai.Hu@nxp.com, yangbo.lu@nxp.com, nikita.yoush@cogentembedded.com, andy.shevchenko@gmail.com, dongas86@gmail.com, Dong Aisheng <aisheng.dong@nxp.com>
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

ChangeLog:
v2->v3:
 * Remove global lpuart_is_be.
   Instead use struct uart_port's iotype member.
   lpuart32_read/write API prototype is also updated to use the iotype to
   distingush the endians. And most importantly, this way also works with
   earlycon.

v1->v2:
 * Patch 2/4/5 chagned, other no changes.
   See individuals for details.

Dong Aisheng (7):
  tty: serial: lpuart: introduce lpuart_soc_data to represent SoC
    property
  tty: serial: lpuart: refactor lpuart32_{read|write} prototype
  tty: serial: lpuart: add little endian 32 bit register support
  dt-bindings: serial: fsl-lpuart: add i.MX7ULP support
  tty: serial: lpuart: add imx7ulp support
  tty: serial: lpuart: add earlycon support for imx7ulp
  tty: serial: lpuart: add a more accurate baud rate calculation method

 .../devicetree/bindings/serial/fsl-lpuart.txt      |   2 +
 drivers/tty/serial/fsl_lpuart.c                    | 286 ++++++++++++++-------
 2 files changed, 201 insertions(+), 87 deletions(-)

-- 
2.7.4
