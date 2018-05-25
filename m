From: Johan Hovold <johan@kernel.org>
Subject: [RFC PATCH 0/3] USB: serial: add device tree (and serdev) support
Date: Fri, 25 May 2018 14:52:54 +0200
Message-ID: <20180525125257.29124-1-johan@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Johan Hovold <johan@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

These are some patches I've been using to test out using serdev with USB
serial. Adding device-tree support to USB serial is really a
separate matter and could be merged before the remaining issues related
to hotplug are addressed for serdev.

Note that this has been a low-intensity on-going effort where most
prerequisites are already upstream including USB device tree support
(4.15), device-tree node sharing (4.13), musb device-node propagation
(linux-next) and various fixes along the way (driver core, usb core,
musb).

What left to be decided is how to deal with multi-port devices. This
series uses child nodes to represent each port, which may be a little
counter-intuitive for devices (or rather interfaces) with just a single
port:

	&usb_interface {
		#address-cells = <1>;
		#size-cells = <0>;

		serial@0 {
			reg = <0>;
		};
	};

but I still think this it how it needs to be implemented.

Another thing that's currently lacking is binding documentation.

For completeness (and per request), the second patch enables serdev
support and can be used for testing purposes. The third patch can be
used as a base for testing this on a BBB and describes two USB serial
devices attached to an external hub.

Note that this series depends on a couple of patches (for usb-serial and
musb) that are still in linux-next. For convenience, I've prepared a
branch here:

	https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git/log/?h=usb-serial-of

Johan


Johan Hovold (3):
  USB: serial: add device-tree support
  USB: serial: enable serdev support
  dbg: ARM: dts: boneblack: add USB topology and serdev nodes

 arch/arm/boot/dts/am335x-boneblack.dts | 57 ++++++++++++++++++++++++++
 drivers/usb/serial/bus.c               |  7 ++--
 drivers/usb/serial/usb-serial.c        | 28 ++++++++++++-
 3 files changed, 88 insertions(+), 4 deletions(-)

-- 
2.17.0
