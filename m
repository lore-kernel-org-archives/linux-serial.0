From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [RFC PATCH 1/3] UART: Add UART subsystem as a bus.
Date: Wed, 5 Dec 2012 08:20:15 +0200
Message-ID: <20121205062015.GR3117@intel.com>
References: <cover.1354505471.git.lv.zheng@intel.com>
 <6d5fc2e0799c12554aa8acdb2d7782ba8643902b.1354505472.git.lv.zheng@intel.com>
 <20121204185404.GQ3117@intel.com>
 <20121204195030.238d1b71@bob.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:33073 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751576Ab2LEGQ7 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 5 Dec 2012 01:16:59 -0500
Content-Disposition: inline
In-Reply-To: <20121204195030.238d1b71@bob.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Len Brown <len.brown@intel.com>, Rafael J Wysocki <rafael.j.wysocki@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-acpi@vger.kernel.org, linux-serial@vger.kernel.org

On Tue, Dec 04, 2012 at 07:50:30PM +0000, Alan Cox wrote:
> > And if we have enumerated the UART controller from ACPI (it is
> > probably attached to the platform bus) we can find the tty device it
> > exports like:
> 
> The property should not be in any ACPI specific form or space - just
> attach it directly to the tty from ACPI, DT, driver internal knowledge,
> PCI id, whatever

The only property that comes into mind is _HID/_CID (referring to the ACPI
ID) that can be used by userspace to find out type of the device behind the
UART port. I don't know what name would be generic enough for the property,
though.

There are other resources as well in addition to the UartSerialBus(). For
example we might have two GPIO lines connected to the bluetooth chip and
these are represented as GpioIo ACPI resources.

Since the bluetooth is mostly handled by the N_HCI line discipline, should
the GPIO handling be done there as well? It can distinguish between DT and
ACPI enumerated devices by comparing dev->of_node and ACPI_HANDLE(dev) so
it can get the resources from both DT and ACPI but I'm not sure if it
really belongs there. Or should this be in a separate driver?
