From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [RFC PATCH 0/3] UART slave device bus
Date: Thu, 18 Aug 2016 12:39:25 +0200
Message-ID: <118926C8-F4D0-41F5-B6A8-690E0312F3FB@goldelico.com>
References: <20160818011445.22726-1-robh@kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160818011445.22726-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marcel Holtmann <marcel@holtmann.org>, Jiri Slaby <jslaby@suse.com>, Sebastian Reichel <sre@kernel.org>, Pavel Machek <pavel@ucw.cz>, Peter Hurley <peter@hurleysoftware.com>, NeilBrown <neil@brown.name>, Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linus.walleij@linaro.org>, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Rob,
many thanks for picking up this unsolved topic!

> Am 18.08.2016 um 03:14 schrieb Rob Herring <robh@kernel.org>:
>=20
> Currently, devices attached via a UART are not well supported in the
> kernel. The problem is the device support is done in tty line =
disciplines,
> various platform drivers to handle some sideband, and in userspace =
with
> utilities such as hciattach.
>=20
> There have been several attempts to improve support, but they suffer =
from
> still being tied into the tty layer and/or abusing the platform bus. =
This
> is a prototype to show creating a proper UART bus for UART devices. It =
is
> tied into the serial core (really struct uart_port) below the tty =
layer
> in order to use existing serial drivers.
>=20
> This is functional with minimal testing using the loopback driver and
> pl011 (w/o DMA) UART under QEMU (modified to add a DT node for the =
slave
> device). It still needs lots of work and polish.
>=20
> TODOs:
> - Figure out the port locking. mutex plus spinlock plus refcounting? =
I'm
>  hoping all that complexity is from the tty layer and not needed here.
> - Split out the controller for uart_ports into separate driver. Do we =
see
>  a need for controller drivers that are not standard serial drivers?
> - Implement/test the removal paths
> - Fix the receive callbacks for more than character at a time (i.e. =
DMA)
> - Need better receive buffering than just a simple circular buffer or
>  perhaps a different receive interface (e.g. direct to client buffer)?
> - Test with other UART drivers
> - Convert a real driver/line discipline over to UART bus.
>=20
> Before I spend more time on this, I'm looking mainly for feedback on =
the
> general direction and structure (the interface with the existing =
serial
> drivers in particular).

Some quick comments (can't do any real life tests in the next weeks) =
from my (biased) view:

* tieing the solution into uart_port is the same as we had done. The =
difference seems to
   me that you completely bypass serial_core (and tty) while we want to =
integrate it with standard tty operation.

   We have tapped the tty layer only because it can not be 100% avoided =
if we use serial_core.

* one feedback I had received was that there may be uart device drivers =
not using serial_core. I am not sure if your approach addresses that.

* what I don't see is how we can implement our GPS device power control =
driver:
  - the device should still present itself as a tty device (so that cat =
/dev/ttyO1 reports NMEA records) and should
    not be completely hidden from user space or represented by a new =
interface type invented just for this device
    (while the majority of other GPS receivers are still simple tty =
devices).
  - how we can detect that the device is sending data to the UART while =
no user space process has the uart port open
    i.e. when does the driver know when to start/stop the UART.

* I like that a driver can simply call uart_dev_config(udev, 115200, =
'n', 8, 0);  instead of our
     uart_register_rx_notification(data->uart, rx_notification, =
&termios); where we have to partially
     fill the termios structure.

* it appears to need more code than our proposal did:

>=20
> Rob
>=20
>=20
> Rob Herring (3):
>  uart bus: Introduce new bus for UART slave devices
>  tty: serial_core: make tty_struct optional
>  tty: serial_core: add uart controller registration
>=20
> drivers/Kconfig                  |   2 +
> drivers/Makefile                 |   1 +
> drivers/tty/serial/serial_core.c |  11 +-
> drivers/tty/tty_buffer.c         |   2 +
> drivers/uart/Kconfig             |  17 ++
> drivers/uart/Makefile            |   3 +
> drivers/uart/core.c              | 458 =
+++++++++++++++++++++++++++++++++++++++
> drivers/uart/loopback.c          |  72 ++++++
> include/linux/serial_core.h      |   3 +-
> include/linux/uart_device.h      | 163 ++++++++++++++
> 10 files changed, 730 insertions(+), 2 deletions(-)
> create mode 100644 drivers/uart/Kconfig
> create mode 100644 drivers/uart/Makefile
> create mode 100644 drivers/uart/core.c
> create mode 100644 drivers/uart/loopback.c
> create mode 100644 include/linux/uart_device.h

thereof 9 files, ~650 changes w/o loopback demo

vs.

> On 10/16/2015 11:08 AM, H. Nikolaus Schaller wrote:
>> H. Nikolaus Schaller (3):
>> tty: serial core: provide a method to search uart by phandle
>> tty: serial_core: add hooks for uart slave drivers
>> misc: Add w2sg0004 gps receiver driver
>>=20
>> .../devicetree/bindings/misc/wi2wi,w2sg0004.txt    |  18 +
>> .../devicetree/bindings/serial/slaves.txt          |  16 +
>> .../devicetree/bindings/vendor-prefixes.txt        |   1 +
>> Documentation/serial/slaves.txt                    |  36 ++
>> drivers/misc/Kconfig                               |  18 +
>> drivers/misc/Makefile                              |   1 +
>> drivers/misc/w2sg0004.c                            | 443 =
+++++++++++++++++++++
>> drivers/tty/serial/serial_core.c                   | 214 +++++++++-
>> include/linux/serial_core.h                        |  25 +-
>> include/linux/w2sg0004.h                           |  27 ++
>> 10 files changed, 793 insertions(+), 6 deletions(-)
>> create mode 100644 =
Documentation/devicetree/bindings/misc/wi2wi,w2sg0004.txt
>> create mode 100644 =
Documentation/devicetree/bindings/serial/slaves.txt
>> create mode 100644 Documentation/serial/slaves.txt
>> create mode 100644 drivers/misc/w2sg0004.c
>> create mode 100644 include/linux/w2sg0004.h

Thereof 4 files, ~260 changes w/o gps demo and documentation/bindings.

BR and thanks,
Nikolaus
