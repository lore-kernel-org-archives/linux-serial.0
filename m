From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [RFC PATCH 1/3] UART: Add UART subsystem as a bus.
Date: Thu, 6 Dec 2012 01:26:39 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E88BD6C94@SHSMSX101.ccr.corp.intel.com>
References: <cover.1354505471.git.lv.zheng@intel.com>
	<6d5fc2e0799c12554aa8acdb2d7782ba8643902b.1354505472.git.lv.zheng@intel.com>
	<20121204185404.GQ3117@intel.com>	<20121204195030.238d1b71@bob.linux.org.uk>
	<20121205062015.GR3117@intel.com>
 <20121205094343.09d653c5@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:25181 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752908Ab2LFB0o convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 5 Dec 2012 20:26:44 -0500
In-Reply-To: <20121205094343.09d653c5@pyramind.ukuu.org.uk>
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Alan Cox <alan@linux.intel.com>, "Brown, Len" <len.brown@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Mathias Nyman <mathias.nyman@linux.intel.com>, "Huang, Ying" <ying.huang@intel.com>

> > > The property should not be in any ACPI specific form or space - just
> > > attach it directly to the tty from ACPI, DT, driver internal
> > > knowledge, PCI id, whatever
> >
> > The only property that comes into mind is _HID/_CID (referring to the
> > ACPI
> > ID) that can be used by userspace to find out type of the device
> > behind the UART port. I don't know what name would be generic enough
> > for the property, though.
> 
> We just need a set of type names for the sysfs node I think "bluetooth", "ups",
> "loconet", "serial", "modem", "cir" etc...

Is it a good idea to introduce uart_device driver in the kernel to fill a new 'ldisc' member in the uart_device or to load ldisc by default for the corresponding tty_port?

One more important thing I should mention is about a design decision for this patch set.
My current implementation is for the uart tty devices.
Shall we change the uart_bus to the tty_bus, then introduce tty_host / tty_target for the bus?
In the Linux world, tty is the only language that the "tty physical devices" will use to talk to each other, thus it make sense to have a tty_bus and enable PM ops for the physical devices on the bus.
If we do so, the tty_host or tty_port can be the functional devices on top of the host side physical tty devices (ex. platform device / pcmcia device), and the tty_target can be used instead of the uart_device.
We could leave tty_host unimplemented in the first step as there is already a tty_port abstraction.

> > There are other resources as well in addition to the UartSerialBus().
> > For example we might have two GPIO lines connected to the bluetooth
> > chip and these are represented as GpioIo ACPI resources.
> 
> There was some planning on this some time ago. I think we know how to deal
> with GPIOs
> 
> > Since the bluetooth is mostly handled by the N_HCI line discipline,
> > should the GPIO handling be done there as well? It can distinguish
> > between DT and ACPI enumerated devices by comparing dev->of_node and
> > ACPI_HANDLE(dev) so it can get the resources from both DT and ACPI but
> > I'm not sure if it really belongs there. Or should this be in a separate driver?
> 
> The plan was that the tty device would know its gpio lines and also support a
> gpio structure giving mappings for extra control lines. It seems we want that
> both visible to kernel (N_HCI etc) and visible to user space (userspace custom
> handling using the gpio userspace interfaces).

When this is ready, someone knowing ACPI GPIO better than me (Heikki or Mathias included) can add additional features on top of this.

Best regards/Lv Zheng
