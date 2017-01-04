From: David Lechner <david-nq/r/kbU++upp/zk7JDF2g@public.gmane.org>
Subject: [PATCH v2 0/4] TI DA8xx/OMAPL13x/AM17xx/AM18xx/C66x UART
Date: Wed,  4 Jan 2017 14:30:10 -0600
Message-ID: <1483561814-21953-1-git-send-email-david@lechnology.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Santosh Shilimkar <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: David Lechner <david-nq/r/kbU++upp/zk7JDF2g@public.gmane.org>, Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Axel Haslam <ahaslam-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Bartosz Golaszewski <bgolaszewski-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-serial@vger.kernel.org

This series adds a new UART port type for TI DA8xx/OMAPL13x/AM17xx/AM18xx/C66x
UART. This SoCs have a non-standard register for UART power management that
needs special handling in the UART driver.

v2 changes:
* Added references to C66x SoC in various places, which I assume is an OK
  shorthand for TI Keystone processors.
* New patch for Keystone device tree. This is untested as I don't have any
  Keystone boards.


David Lechner (4):
  doc: DT: Add ti,da830-uart to serial/8250 bindings
  serial: 8250: Add new port type for TI
    DA8xx/OMAPL13x/AM17xx/AM18xx/C66x
  ARM: da850: Add ti,da830-uart compatible for serial ports
  ARM: dts: keystone: Add "ti,da830-uart" compatible string

 Documentation/devicetree/bindings/serial/8250.txt |  1 +
 arch/arm/boot/dts/da850.dtsi                      |  9 ++++++---
 arch/arm/boot/dts/keystone-k2g.dtsi               |  2 +-
 arch/arm/boot/dts/keystone-k2l.dtsi               |  4 ++--
 arch/arm/boot/dts/keystone.dtsi                   |  4 ++--
 drivers/tty/serial/8250/8250_of.c                 |  1 +
 drivers/tty/serial/8250/8250_port.c               | 22 ++++++++++++++++++++++
 include/uapi/linux/serial_core.h                  |  3 ++-
 include/uapi/linux/serial_reg.h                   |  8 ++++++++
 9 files changed, 45 insertions(+), 9 deletions(-)

-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
