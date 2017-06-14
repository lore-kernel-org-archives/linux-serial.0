From: Neil Armstrong <narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v5 0/4] tty/serial: meson_uart: add support for core clock handling
Date: Wed, 14 Jun 2017 10:29:13 +0200
Message-ID: <1497428957-19942-1-git-send-email-narmstrong@baylibre.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org
Cc: Neil Armstrong <narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, hgkr.klein-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-amlogic-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

This patchset is a re-spin of Helmut Klein's v3 patchset at [0] and the v4 patchset at [1].

Initially, the original patchset was made to enable usage on the non-AO UARTS
not enabled by the Bootloader (uart_B and uart_C), but the patchset needed
an overall change to have clean and stable DT bindings.

The Amlogic Meson UART Driver did not have stable DT bindings and mismatched
clock handling on non-AO UARTs since these "EE" UARTs needs a clock gate to
be ungated to works correctly.
In the same way, the AO UARTs does not need gating and can be used as
Early Consoles.

In the same time, the UART Interfaces can take clock input for the baudrate
generate from either the external Xtal or the internal Bus Clock (clk81).

So new bindings was necessary to meet these requirements and the DT
maintainers requirements.

The "legacy" binding actually used in the driver is left until all the DT
files are switched to the new bindings.

The GX DT has been tested, but the last 4 Meson6/Meson8/b are only
compile-tested, and testing is welcome.
Thus only the first 3 patches can be merged until the Meson6/Meson8/b are
formally tested.

It must be noted that the meson6 cannot work today except using an early
console since the UART driver could not probe without a clocks property.

Changes since v4 at [1]:
 - Droped meson8/meson8b DT patches
 - Fixes copy/paste error in patch 2
 - Refactored clock probing in patch 2
 - merged meson6 patches together to avoid breaking bisect

[0] http://lkml.kernel.org/r/20170331165437.26227-1-hgkr.klein-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
[1] http://lkml.kernel.org/r/1497001756-942-1-git-send-email-narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org

Helmut Klein (3):
  dt-bindings: serial: Add bindings for the Amlogic Meson UARTs
  tty/serial: meson_uart: update to stable bindings
  ARM64: dts: meson-gx: use stable UART bindings with correct gate clock

Neil Armstrong (1):
  ARM: dts: meson6: use stable UART bindings

 .../bindings/serial/amlogic,meson-uart.txt         | 38 +++++++++
 arch/arm/boot/dts/meson.dtsi                       |  8 +-
 arch/arm/boot/dts/meson6.dtsi                      | 28 +++++++
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi          | 12 ++-
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi        | 25 ++++++
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi         | 25 ++++++
 drivers/tty/serial/meson_uart.c                    | 90 ++++++++++++++++++++--
 7 files changed, 209 insertions(+), 17 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/serial/amlogic,meson-uart.txt

-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
