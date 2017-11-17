From: Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: [RFC v1 0/8] Realtek Bluetooth serdev support (H5 protocol)
Date: Fri, 17 Nov 2017 23:35:35 +0100
Message-ID: <20171117223543.32429-1-martin.blumenstingl@googlemail.com>
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org, gustavo-THi1TnShQwVAfugRpC6u6w@public.gmane.org, johan.hedberg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, jslaby-IBi9RG/b67k@public.gmane.org, johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-amlogic-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Larry.Finger-tQ5ms3gMjBLk1uMJSBkQmQ@public.gmane.org, Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
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
- I guess patch #1 ("serdev: implement parity configuration") and patch
  #7 ("Bluetooth: hci_serdev: remove the HCI_UART_INIT_PENDING check")
  can go on their own as these don't depend on anything else.
  should I split the reset into two series (btrtl + hci_h5 Realtek
  serdev support) or keep it as one?
- what about the Bluetooth firmware and config blobs? how to get them
  into the linux-firmware tree? maybe Larry Finger can help here :)
- what are <your name here> comments about this series?


Regards
Martin


[0] https://github.com/lwfinger/rtl8723bs_bt
[1] https://github.com/NextThingCo/rtl8723ds_bt

Martin Blumenstingl (8):
  serdev: implement parity configuration
  Bluetooth: btrtl: add MODULE_FIRMWARE declarations
  Bluetooth: btrtl: split the device initialization into smaller parts
  Bluetooth: btrtl: add support for retrieving the UART settings
  Bluetooth: btrtl: add support for the RTL8723BS and RTL8723DS chips
  Bluetooth: hci_h5: add support for Realtek UART Bluetooth modules
  Bluetooth: hci_serdev: remove the HCI_UART_INIT_PENDING check
  dt-bindings: net: bluetooth: add support for Realtek Bluetooth chips

 .../devicetree/bindings/net/realtek-bluetooth.txt  |  31 ++
 drivers/bluetooth/Kconfig                          |   1 +
 drivers/bluetooth/btrtl.c                          | 426 +++++++++++++++------
 drivers/bluetooth/btrtl.h                          |  46 +++
 drivers/bluetooth/hci_h5.c                         | 195 +++++++++-
 drivers/bluetooth/hci_serdev.c                     |   3 -
 drivers/tty/serdev/core.c                          |  12 +
 drivers/tty/serdev/serdev-ttyport.c                |  21 +
 include/linux/serdev.h                             |   3 +
 9 files changed, 620 insertions(+), 118 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/realtek-bluetooth.txt

-- 
2.15.0
