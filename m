From: Marek Belisko <marek@goldelico.com>
Subject: [PATCH RFC v2 0/3] UART slave device support
Date: Sun, 28 Jun 2015 21:46:23 +0200
Message-ID: <1435520786-31867-1-git-send-email-marek@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jslaby@suse.cz, gregkh@linuxfoundation.org, arnd@arndb.de
Cc: peter@hurleysoftware.com, mark.rutland@arm.com, gnomes@lxorguk.ukuu.org.uk, sre@kernel.org, neil@brown.name, grant.likely@linaro.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, robh+dt@kernel.org, pawel.moll@arm.com, hns@goldelico.com, Marek Belisko <marek@goldelico.com>
List-Id: linux-serial@vger.kernel.org

Post RFC V2 (test on 4.1) as it seems that V1 wasn't sent properly.

Hi all,
this patch series is our proposal to add hooks so that the driver for a device connected to an UART can
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

This patch works on linux-next as intended except one major weakness: we have to call
uart_change_speed() each time we open the tty. This is the opposite of what we would like
to have: that the slave initializes the uart speed through some termios and the tty level just uses
this setting. We have not yet completely understood how to make this work and are happy
about help in this area.

And of course we would like to see general comments about the whole implementation
approach.

H. Nikolaus Schaller (3):
  tty: serial core: provide method to search uart by phandle
  tty: serial_core: Add hooks for uart slave drivers
  misc: Add w2g0004 gps receiver driver

 .../devicetree/bindings/misc/wi2wi,w2sg0004.txt    |  18 +
 Documentation/serial/slaves.txt                    |  36 ++
 drivers/misc/Kconfig                               |  18 +
 drivers/misc/Makefile                              |   1 +
 drivers/misc/w2sg0004.c                            | 436 +++++++++++++++++++++
 drivers/tty/serial/serial_core.c                   | 205 +++++++++-
 include/linux/serial_core.h                        |  21 +-
 include/linux/w2sg0004.h                           |  28 ++
 8 files changed, 757 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/misc/wi2wi,w2sg0004.txt
 create mode 100644 Documentation/serial/slaves.txt
 create mode 100644 drivers/misc/w2sg0004.c
 create mode 100644 include/linux/w2sg0004.h

-- 
1.9.1
