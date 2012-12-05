From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [RFC PATCH 1/3] UART: Add UART subsystem as a bus.
Date: Wed, 5 Dec 2012 09:43:43 +0000
Message-ID: <20121205094343.09d653c5@pyramind.ukuu.org.uk>
References: <cover.1354505471.git.lv.zheng@intel.com>
	<6d5fc2e0799c12554aa8acdb2d7782ba8643902b.1354505472.git.lv.zheng@intel.com>
	<20121204185404.GQ3117@intel.com>
	<20121204195030.238d1b71@bob.linux.org.uk>
	<20121205062015.GR3117@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:53067 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751762Ab2LEJic (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 5 Dec 2012 04:38:32 -0500
In-Reply-To: <20121205062015.GR3117@intel.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Alan Cox <alan@linux.intel.com>, Lv Zheng <lv.zheng@intel.com>, Len Brown <len.brown@intel.com>, Rafael J Wysocki <rafael.j.wysocki@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-acpi@vger.kernel.org, linux-serial@vger.kernel.org

> > The property should not be in any ACPI specific form or space - just
> > attach it directly to the tty from ACPI, DT, driver internal knowledge,
> > PCI id, whatever
> 
> The only property that comes into mind is _HID/_CID (referring to the ACPI
> ID) that can be used by userspace to find out type of the device behind the
> UART port. I don't know what name would be generic enough for the property,
> though.

We just need a set of type names for the sysfs node I think
"bluetooth", "ups", "loconet", "serial", "modem", "cir" etc...

> There are other resources as well in addition to the UartSerialBus(). For
> example we might have two GPIO lines connected to the bluetooth chip and
> these are represented as GpioIo ACPI resources.

There was some planning on this some time ago. I think we know how to
deal with GPIOs

> Since the bluetooth is mostly handled by the N_HCI line discipline, should
> the GPIO handling be done there as well? It can distinguish between DT and
> ACPI enumerated devices by comparing dev->of_node and ACPI_HANDLE(dev) so
> it can get the resources from both DT and ACPI but I'm not sure if it
> really belongs there. Or should this be in a separate driver?

The plan was that the tty device would know its gpio lines and also
support a gpio structure giving mappings for extra control lines. It
seems we want that both visible to kernel (N_HCI etc) and visible to user
space (userspace custom handling using the gpio userspace interfaces).

Alan
