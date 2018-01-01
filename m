From: Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: [RFC v2 0/9] Realtek Bluetooth serdev support (H5 protocol)
Date: Mon,  1 Jan 2018 21:42:08 +0100
Message-ID: <20180101204217.26165-1-martin.blumenstingl@googlemail.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org, gustavo-THi1TnShQwVAfugRpC6u6w@public.gmane.org, johan.hedberg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, jslaby-IBi9RG/b67k@public.gmane.org, johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-amlogic-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Larry.Finger-tQ5ms3gMjBLk1uMJSBkQmQ@public.gmane.org, carlo-6IF/jdPJHihWk0Htik3J/w@public.gmane.org, drake-6IF/jdPJHihWk0Htik3J/w@public.gmane.org, Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

Hello,

I am sending this series because I want to get feedback.
please don't expect it to be perfect (yet). especially since it's
touching parts of the kernel I've not worked with before.

my goal was NOT to use the user-space initialization tool for the
Bluetooth part of one of my devices (which uses a Realtek RTL8723BS).
my hope was that I only had to hook up serdev support to hci_h5 and
re-use the setup function provided by btrtl. unfortunately it wasn't
that easy.

there are no datasheets for the RTL8723BS or RTL8723DS out there.
however, there are some userspace tools which go through the whole
initialization process - this is what I used as reference:
- RTL8723BS Bluetooth sources from [0]
- RTL8723DS Bluetooth sources from [1]

These modules require a firmware and a config file (both don't seem
to be compatible with what we have in linux-firmware at the moment).

since it's an RFC I also have some questions:
- who can help testing that I didn't break any USB based Realtek
  Bluetooth chips? I only have UART (embedded into the SDIO RTL8723BS
  and RTL8723DS) ones
- what about the Bluetooth firmware and config blobs? how to get them
  into the linux-firmware tree? maybe Larry Finger can help here :)
- what are <your name here> comments about this series?


Changes since RFC v1 at [2]:
- fixed compile error in PATCH #1 if CONFIG_SERIAL_DEV_BUS is disabled
  (spotted by Intel's kbuild test robot - many thanks!)
- renamed "disable-gpios" to "enable-gpios" in the dt-bindings and
  hci_h5 patches
- added a "realtek,config-data" property to devicetree which can be used
  to provide the "config"-blob. I did not find a way to auto-generate
  that blob. a similar property is described by "marvell-bt-8xxx.txt".
  This affects the dt-bindings (Documentation) patch and introduces a
  new patch for btrtl.c.
- guard against the vendor_setup callback being NULL (thanks Marcel
  Holtmann for suggesting this in the review of RFC 1) in the hci_h5
  patch
- added comments where the msleep() times are coming from in the hci_h5
  patch
- dropped an unnecessary msleep() after sending the "change baudrate"
  command (thanks Marcel Holtmann for spotting this)
- entirely drop HCI_UART_INIT_PENDING instead of just ignoring it in
  hci_serdev


[0] https://github.com/lwfinger/rtl8723bs_bt
[1] https://github.com/NextThingCo/rtl8723ds_bt
[2] https://www.spinics.net/lists/linux-bluetooth/msg72862.html


Martin Blumenstingl (9):
  serdev: implement parity configuration
  dt-bindings: net: bluetooth: add support for Realtek Bluetooth chips
  Bluetooth: btrtl: add MODULE_FIRMWARE declarations
  Bluetooth: btrtl: split the device initialization into smaller parts
  Bluetooth: btrtl: add support for retrieving the UART settings
  Bluetooth: btrtl: add support for the RTL8723BS and RTL8723DS chips
  bluetooth: btrtl: load the config blob from devicetree when available
  Bluetooth: drop HCI_UART_INIT_PENDING support
  Bluetooth: hci_h5: add support for Realtek UART Bluetooth modules

 .../devicetree/bindings/net/realtek-bluetooth.txt  |  41 ++
 drivers/bluetooth/Kconfig                          |   1 +
 drivers/bluetooth/btrtl.c                          | 461 ++++++++++++++++-----
 drivers/bluetooth/btrtl.h                          |  46 ++
 drivers/bluetooth/hci_h5.c                         | 206 ++++++++-
 drivers/bluetooth/hci_ldisc.c                      |  38 --
 drivers/bluetooth/hci_serdev.c                     |   3 -
 drivers/bluetooth/hci_uart.h                       |   4 +-
 drivers/tty/serdev/core.c                          |  12 +
 drivers/tty/serdev/serdev-ttyport.c                |  21 +
 include/linux/serdev.h                             |   5 +
 11 files changed, 678 insertions(+), 160 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/realtek-bluetooth.txt

-- 
2.15.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
