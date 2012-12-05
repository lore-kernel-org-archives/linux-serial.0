From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [RFC PATCH 1/3] UART: Add UART subsystem as a bus.
Date: Wed, 5 Dec 2012 07:07:52 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E88BD6A54@SHSMSX101.ccr.corp.intel.com>
References: <cover.1354505471.git.lv.zheng@intel.com>
 <6d5fc2e0799c12554aa8acdb2d7782ba8643902b.1354505472.git.lv.zheng@intel.com>
 <20121204185404.GQ3117@intel.com> <20121204195030.238d1b71@bob.linux.org.uk>
 <20121205062015.GR3117@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:22905 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751880Ab2LEHHz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 5 Dec 2012 02:07:55 -0500
In-Reply-To: <20121205062015.GR3117@intel.com>
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>, Alan Cox <alan@linux.intel.com>
Cc: "Brown, Len" <len.brown@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

> On Tue, Dec 04, 2012 at 07:50:30PM +0000, Alan Cox wrote:
> > > And if we have enumerated the UART controller from ACPI (it is
> > > probably attached to the platform bus) we can find the tty device it
> > > exports like:
> >
> > The property should not be in any ACPI specific form or space - just
> > attach it directly to the tty from ACPI, DT, driver internal
> > knowledge, PCI id, whatever
> 
> The only property that comes into mind is _HID/_CID (referring to the ACPI
> ID) that can be used by userspace to find out type of the device behind the
> UART port. I don't know what name would be generic enough for the property,
> though.
> 
> There are other resources as well in addition to the UartSerialBus(). For
> example we might have two GPIO lines connected to the bluetooth chip and
> these are represented as GpioIo ACPI resources.
> 
> Since the bluetooth is mostly handled by the N_HCI line discipline, should the
> GPIO handling be done there as well? It can distinguish between DT and ACPI
> enumerated devices by comparing dev->of_node and ACPI_HANDLE(dev) so it
> can get the resources from both DT and ACPI but I'm not sure if it really
> belongs there. Or should this be in a separate driver?

IMO, 
For ACPI enumerated target devices, ACPI can provide GPIO enumeration API by feeding ACPI_HANDLE(tty->target) to obtain the GPIO resources while OF can offer its own implementation.
Then there are 2 possible solutions can be found by calling such APIs:
1. implement GPIO enabling in the kernel side N_HCI proto driver.
2. implement GPIO enabling in the kernel side UART driver on TIOCSETD.

Same issues can be found for the ACPI enumerated SPI/I2C target devices.
Thus the GpioIrq and GpioIo is not handled in this patch set.

Best regards/Lv Zheng
