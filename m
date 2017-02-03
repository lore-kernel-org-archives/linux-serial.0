From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH v4 00/10] serial: st-asc: Allow handling of RTS lin
Date: Fri,  3 Feb 2017 10:23:09 +0000
Message-ID: <20170203102319.23489-1-lee.jones@linaro.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, jslaby-IBi9RG/b67k@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-F5mvAk5X5gdBDgjK7y7TUQ@public.gmane.org, patrice.chotard-qxv4g6HH51o@public.gmane.org, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

When hardware flow-control is disabled, manual toggling of the UART's
reset line (RTS) using userland applications (e.g. stty) is not
possible, since the ASC IP does not provide this functionality in the
same was as some other IPs do.  Thus, we have to do this manually.

This set ensures the correct Pinctrl groups are configured and
obtained for both manual toggling of the RTS line and for the IP to
take over the lines when HW flow-control is requested by the user.

Lee Jones (10):
  serial: st-asc: Ignore the parity error bit if 8-bit mode is enabled
  serial: st-asc: Provide RTS functionality
  serial: st-asc: Read in all Pinctrl states
  serial: st-asc: (De)Register GPIOD and swap Pinctrl profiles
  serial: st-asc: Use generic DT binding for announcing RTS/CTS lines
  dt-bindings: serial: Update 'uart-has-rtscts' description
  ARM: dts: STiH410-b2260: Identify the UART RTS line
  ARM: dts: STiH407-pinctrl: Add Pinctrl group for HW flow-control
  ARM: dts: STiH407-family: Use new Pinctrl groups
  ARM: dts: STiH410-b2260: Enable HW flow-control

 .../devicetree/bindings/serial/serial.txt          |   3 +-
 arch/arm/boot/dts/stih407-family.dtsi              |   3 +-
 arch/arm/boot/dts/stih407-pinctrl.dtsi             |  12 ++-
 arch/arm/boot/dts/stih410-b2260.dts                |   5 +
 drivers/tty/serial/st-asc.c                        | 101 +++++++++++++++++++--
 5 files changed, 110 insertions(+), 14 deletions(-)

-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
