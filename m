From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH 0/9] Serial slave device bus
Date: Tue, 10 Jan 2017 12:44:38 +0100
Message-ID: <8E1651EC-E9E5-4BB5-84CB-8CFEE08009BA@goldelico.com>
References: <20170106162635.19677-1-robh@kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170106162635.19677-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marcel Holtmann <marcel@holtmann.org>, Jiri Slaby <jslaby@suse.com>, Sebastian Reichel <sre@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Peter Hurley <peter@hurleysoftware.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Loic Poulain <loic.poulain@intel.com>, Pavel Machek <pavel@ucw.cz>, NeilBrown <neil@brown.name>, Linus Walleij <linus.walleij@linaro.org>, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Rob,

> Am 06.01.2017 um 17:26 schrieb Rob Herring <robh@kernel.org>:
>=20
> Here goes another attempt at a serial device bus (aka uart slaves, tty
> slaves, etc.).
>=20
> After some discussions with Dmitry at LPC, I decided to move away from
> extending serio and moved back to making a new bus type instead. He =
didn't
> think using serio was a good fit, and serio has a number of =
peculiarities
> in regards to sysfs and it's driver model. I don't think we want to =
inherit
> those for serial slave devices.
>=20
> This version sits on top of tty_port rather than uart_port as Alan
> requested. Once I created a struct tty rather than moving everything
> needed to tty_port, it became a lot easier and less invasive to the =
tty
> core code.
>=20
> I have hacked up versions of the BT ldisc and TI ST drivers moved over =
to
> use the serdev bus. I have BT working on the HiKey board which has TI =
BT.
> With the serdev bus support, it eliminates the need for the TI =
userspace
> UIM daemon.
>=20
> This series and the mentioned drivers can be found here[1].
>=20
> Rob
>=20
> [1] git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git =
serial-bus-v2
>=20
> Alan Cox (1):
>  tty_port: allow a port to be opened with a tty that has no file =
handle
>=20
> Rob Herring (8):
>  tty: move the non-file related parts of tty_release to new
>    tty_release_struct
>  tty_port: make tty_port_register_device wrap
>    tty_port_register_device_attr
>  tty: constify tty_ldisc_receive_buf buffer pointer
>  tty_port: Add port client functions
>  dt/bindings: Add a serial/UART attached device binding
>  serdev: Introduce new bus for serial attached devices
>  serdev: add a tty port controller driver
>  tty_port: register tty ports with serdev bus
>=20
> .../devicetree/bindings/serial/slave-device.txt    |  34 ++
> MAINTAINERS                                        |   8 +
> drivers/char/Kconfig                               |   1 +
> drivers/tty/Makefile                               |   1 +
> drivers/tty/serdev/Kconfig                         |  16 +
> drivers/tty/serdev/Makefile                        |   5 +
> drivers/tty/serdev/core.c                          | 388 =
+++++++++++++++++++++
> drivers/tty/serdev/serdev-ttyport.c                | 244 +++++++++++++
> drivers/tty/tty_buffer.c                           |  19 +-
> drivers/tty/tty_io.c                               |  44 ++-
> drivers/tty/tty_port.c                             |  60 +++-
> include/linux/serdev.h                             | 227 ++++++++++++
> include/linux/tty.h                                |  12 +-
> 13 files changed, 1017 insertions(+), 42 deletions(-)
> create mode 100644 =
Documentation/devicetree/bindings/serial/slave-device.txt
> create mode 100644 drivers/tty/serdev/Kconfig
> create mode 100644 drivers/tty/serdev/Makefile
> create mode 100644 drivers/tty/serdev/core.c
> create mode 100644 drivers/tty/serdev/serdev-ttyport.c
> create mode 100644 include/linux/serdev.h
>=20
> --
> 2.10.1
>=20

First of all many thanks for making another proposal!

Instead of looking into the implementation details of your code I have
hacked my w2sg0004 GPS driver (which works based on my proposed =
uart_slave
driver) so that it makes use of your new serdev API.

Here are some observations which I hope they give directions where your
work can be improved:

1. it was quite easy to convert the driver to a serdev_device_driver :)

The general driver structure could be taken unchanged and it was mainly
platform_device -> serdev_device_driver and replacing my notification
handlers by serdev_device_ops.

Communication with the chip seems to work well. At least if it is =
unexpectedly
turned on the driver receives the wrong NMEA records and turns the GPS
chip off. That is the core of our power management scheme and why
we need a serdev driver for this chip at all.

So the general API for getting read/write access to the serial interface
(and setting baud rate) from a device driver seems to be fine!


2. When I try to open the tty from user space to fetch the serial data I
just get

root@letux:~# cat /dev/ttyO1
[  659.290618] ttyO ttyO1: tty_open: tty->count(2) !=3D #fd's(1)
[  665.257232] ttyO ttyO1: tty_release: tty->count(2) !=3D #fd's(1)
^C
root@letux:~#

So it does not seem to be possible to read the data from the tty any =
more.

Maybe there can be some function serdev_device_set_shared(dev, flag).
If set to exclusive the /dev node would be hidden from user-space.


3. for completely implementing my w2sg0004 driver (and two others) it =
would
be nice to have additional serdev_device_ops:

a) to be notified about user-space clients doing open/close on the tty
b) and/or to be notified about user-space tcsetattr or TIOCMSET (for =
DTR)

There may be other means (ldisc?) to get these notifications, but that
needs the serdev driver to register with two different subsystems.

Another approach could be to completely rewrite the driver so that it =
wraps
and hides the /dev/ttyO1 and registers its own /dev/gps tty port for =
user-space
communication. Then it would be notified for all user-space and serial
interface activities as a man-in-the-middle.

But I expect that it delays the communication and is quite some =
overhead.


4. It seems as if I have to modprobe the driver explicitly (it is not
located and loaded automatically based on the compatible string in DT
like i2c clients).


BR and thanks for your progress,
Nikolaus
