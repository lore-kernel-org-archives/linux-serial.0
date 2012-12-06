From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [RFC PATCH 1/3] UART: Add UART subsystem as a bus.
Date: Thu, 6 Dec 2012 01:55:43 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E88BD6D48@SHSMSX101.ccr.corp.intel.com>
References: <cover.1354505471.git.lv.zheng@intel.com>
	<6d5fc2e0799c12554aa8acdb2d7782ba8643902b.1354505472.git.lv.zheng@intel.com>
	<20121204185404.GQ3117@intel.com>	<20121204195030.238d1b71@bob.linux.org.uk>
	<20121205062015.GR3117@intel.com>
 <20121205094343.09d653c5@pyramind.ukuu.org.uk>
 <1AE640813FDE7649BE1B193DEA596E88BD6C94@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:50751 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751980Ab2LFBzx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 5 Dec 2012 20:55:53 -0500
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E88BD6C94@SHSMSX101.ccr.corp.intel.com>
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Alan Cox <alan@linux.intel.com>, "Brown, Len" <len.brown@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Mathias Nyman <mathias.nyman@linux.intel.com>, "Huang, Ying" <ying.huang@intel.com>

> > > > The property should not be in any ACPI specific form or space -
> > > > just attach it directly to the tty from ACPI, DT, driver internal
> > > > knowledge, PCI id, whatever
> > >
> > > The only property that comes into mind is _HID/_CID (referring to
> > > the ACPI
> > > ID) that can be used by userspace to find out type of the device
> > > behind the UART port. I don't know what name would be generic enough
> > > for the property, though.
> >
> > We just need a set of type names for the sysfs node I think
> > "bluetooth", "ups", "loconet", "serial", "modem", "cir" etc...
> 
> Is it a good idea to introduce uart_device driver in the kernel to fill a new 'ldisc'
> member in the uart_device or to load ldisc by default for the corresponding
> tty_port?

In the ACPI spec, there is no such attribute for the UART devices, OF might easily introduce this.
It's hard to add type name or ldisc name directly to the uart_board_info.

We can either add driver support for the uart_device to fill this as I mentioned in the first reply or to add a HID -> type name (or ldisc name) matching table in the acpi_uart.c to extract this information for the ACPI enumerated uart_board_info.

Best regards/Lv Zheng
