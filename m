From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [RFC PATCH 0/6] UART slave devices using serio
Date: Wed, 24 Aug 2016 18:24:30 -0500
Message-ID: <20160824232437.9446-1-robh@kernel.org>
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, "Dr . H . Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, Alan Cox <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Cc: Loic Poulain <loic.poulain-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, NeilBrown <neil-+NVA1uvv1dVBDLzU/O5InQ@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

This is a new approach to supporting UART slave devices using the
existing serio bus. After Arnd's proding, I took another look at serio
and decided extending it does make sense. Using serio primarily requires
adding DT based device matching and supporting buffer based write and
receive.

Currently, I'm using the existing serio serport ldisc for testing. This
requires using inputattach to open the tty and set the ldisc which in
turn registers a serio port with the serio core:

inputattach -bare /dev/ttyAMA1

Once a tty_port based serio port driver is in place, this step will not
be needed. Supporting cases like a USB UART will also work if the USB
UART is described in DT. If not described in DT, I'm not sure if the
existing serio manual binding is sufficient (Need to figure out how that
works). Slave drivers also need other ways to specify additional data
using module params perhaps. Getting DT overlays to work for
non-discoverable devices behind discoverable buses (i.e. detached from
a base DT) is another option, but that's not yet supported in general.

I've done all the serio changes in place, but ultimately I think at
least the core of serio should be moved out of drivers/input/. I don't
think it belongs under drivers/tty/ or drivers/tty/serial/, so
drivers/serio/?

BT is working under QEMU to the point a slave driver can bind to a
serio port device via DT, register as a BT device, start sending out
initial packets and receive data (typed at a terminal). Now I need to
find a real device.

A git branch is available here[1]. Note it will get rebased.

Rob

[1] git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git serial-bus-serio


Rob Herring (6):
  serio: add DT driver binding
  serio: serport: hacks to get DT probe to work
  serio: add buffer receive and write functions
  serio: serport: add support for buffered write and receive
  serio: add serial configuration functions
  bluetooth: hack up ldisc to use serio

 drivers/bluetooth/hci_ldisc.c | 261 +++++++++++++++++-------------------------
 drivers/bluetooth/hci_uart.h  |   3 +
 drivers/input/serio/serio.c   |  34 +++++-
 drivers/input/serio/serport.c |  49 ++++----
 include/linux/serio.h         |  59 +++++++++-
 5 files changed, 223 insertions(+), 183 deletions(-)

--
2.9.3
