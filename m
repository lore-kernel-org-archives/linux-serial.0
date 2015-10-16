From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH v3 0/3] UART slave device support (goldelico version)
Date: Fri, 16 Oct 2015 21:11:52 +0200
Message-ID: <7558A010-6311-4974-BDE1-614EB27EFC6E@goldelico.com>
References: <cover.1445018912.git.hns@goldelico.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1445018912.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>, Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Jonathan Corbet <corbet@lwn.net>
Cc: Sergei Zviagintsev <sergei@s15v.net>, Peter Hurley <peter@hurleysoftware.com>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Sebastian Reichel <sre@kernel.org>, NeilBrown <neil@brown.name>, Grant Likely <grant.likely@linaro.org>, LKML <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, Marek Belisko <marek@goldelico.com>, devicetree@vger.kernel.org, linux-doc@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Changes V3:
- changed from RFC to PATCH
- added separate bindings and concept documentation documents
- worked in comments by Sergei Zviagintsev

Changes V2:
- fixed some formatting

This patch series is our proposal to add hooks so that the driver for a device connected to an UART can
monitor modem control lines and data activity of the connected chip.

It contains an example for such a device driver which needs such sophisticated power control: wi2wi,w2sg0004

A remote device connected to a RS232 interface is usually power controlled by the DTR line.
The DTR line is managed automatically by the UART driver for open() and close() syscalls
and on demand by tcsetattr().

With embedded devices, the serial peripheral might be directly and always connected to the UART
and there might be no physical DTR line involved. Power control (on/off) has to be done by some
chip specific device driver (which we call "UART slave") through some mechanisms (I2C, GPIOs etc.)
not related to the serial interface. Some devices do not tell their power state except by sending
or not sending data to the UART. In such a case the device driver must be able to monitor data
activity. The role of the device driver is to encapsulate such power control in a single place.

This patch series allows to support such UART slave drivers by providing:
* a mechanism that a slave driver can identify the UART instance it is connected to
* a mechanism that UART slave drivers can register to be notified
* notfications for DTR (and other modem control) state changes
* notifications that the device has sent some data to the UART

A slave device tree entry simply adds a phandle reference to the UART it is connected to, e.g.

       gps {
               compatible = "wi2wi,w2sg0004";
               uart = <&uart1>;
       };

The slave driver calls devm_serial_get_uart_by_phandle() to identify the uart driver.
devm_serial_get_uart_by_phandle() follows the concept of devm_usb_get_phy_by_phandle().

A slave device driver registers itself with serial_register_slave() to receive notifications.
Notification handlers can be registered by serial_register_mctrl_notification() and
serial_register_rx_notification(). If an UART has a NULL slave or a NULL handler registered,
no notifications are sent.

RX notification handlers can define a ktermios setup and modify or decide to throw away the
character that is passed upwards.

This all is a follow-up to the w2sg0004 driver submitted in 2014 that did want to add an optional
GPIO to DTR in omap-serial.c and required the w2sg0004 driver to present itself as a "virtual
GPIO". The idea of a "virtual GPIO"  is not compatible with the concept that DT must
describe hardware (and not virtual hardware). So in this new solution DT only describes that
the w2sg0004 is connected to some UART and how the power state signalling works is left
to the driver implementations.

The rx data notification also removes the concept of having two different pinmux states
and make the w2sg0004 driver intercept rx activities by switching the rx line to a GPIO
interrupt. This was very OMAP3 specific. The new solution is generic and might even be
extensible that the chip driver could filter or consume the rx data before it is passed
to the tty layer.

This patch works on 4.3-rc as intended except one major weakness: we have to call
uart_change_speed() each time we open the tty. This is the opposite of what we would like
to have: that the slave initializes the uart speed through some termios and the tty level just uses
this setting. We have not yet completely understood how to make this work and are happy
about help in this area.


Am 16.10.2015 um 20:08 schrieb H. Nikolaus Schaller <hns@goldelico.com>:

> H. Nikolaus Schaller (3):
>  tty: serial core: provide a method to search uart by phandle
>  tty: serial_core: add hooks for uart slave drivers
>  misc: Add w2sg0004 gps receiver driver
> 
> .../devicetree/bindings/misc/wi2wi,w2sg0004.txt    |  18 +
> .../devicetree/bindings/serial/slaves.txt          |  16 +
> .../devicetree/bindings/vendor-prefixes.txt        |   1 +
> Documentation/serial/slaves.txt                    |  36 ++
> drivers/misc/Kconfig                               |  18 +
> drivers/misc/Makefile                              |   1 +
> drivers/misc/w2sg0004.c                            | 443 +++++++++++++++++++++
> drivers/tty/serial/serial_core.c                   | 214 +++++++++-
> include/linux/serial_core.h                        |  25 +-
> include/linux/w2sg0004.h                           |  27 ++
> 10 files changed, 793 insertions(+), 6 deletions(-)
> create mode 100644 Documentation/devicetree/bindings/misc/wi2wi,w2sg0004.txt
> create mode 100644 Documentation/devicetree/bindings/serial/slaves.txt
> create mode 100644 Documentation/serial/slaves.txt
> create mode 100644 drivers/misc/w2sg0004.c
> create mode 100644 include/linux/w2sg0004.h
> 
> -- 
> 2.5.1
> 
