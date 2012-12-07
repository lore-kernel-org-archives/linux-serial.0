From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [RFC PATCH 1/3] UART: Add UART subsystem as a bus.
Date: Fri, 7 Dec 2012 05:41:20 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E88BD75D2@SHSMSX101.ccr.corp.intel.com>
References: <cover.1354505471.git.lv.zheng@intel.com>
	<6d5fc2e0799c12554aa8acdb2d7782ba8643902b.1354505472.git.lv.zheng@intel.com>
	<20121204185404.GQ3117@intel.com>	<20121204195030.238d1b71@bob.linux.org.uk>
	<20121205062015.GR3117@intel.com>
	<20121205094343.09d653c5@pyramind.ukuu.org.uk>
	<1AE640813FDE7649BE1B193DEA596E88BD6C94@SHSMSX101.ccr.corp.intel.com>
 <20121206135341.148b325e@pyramind.ukuu.org.uk>
 <1AE640813FDE7649BE1B193DEA596E88BD756A@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:24124 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751815Ab2LGFlZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 7 Dec 2012 00:41:25 -0500
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E88BD756A@SHSMSX101.ccr.corp.intel.com>
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Alan Cox <alan@linux.intel.com>, "Brown, Len" <len.brown@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "Huang, Ying" <ying.huang@intel.com>

> > > > We just need a set of type names for the sysfs node I think
> > > > "bluetooth", "ups", "loconet", "serial", "modem", "cir" etc...
> > >
> > > Is it a good idea to introduce uart_device driver in the kernel to
> > > fill a new
> > 'ldisc' member in the uart_device or to load ldisc by default for the
> > corresponding tty_port?
> >
> > No but it can provide information to help user space. In many cases
> > the decision isn't about a line discipline but about automatically
> > setting permissions or linking ports to the right driver.
> >
> > The hints need to be generic - they can come from open firmware, from
> > pci identifiers, from ACPI and so on.
> 
> Userspace need to know more than a simple type name to match the driver.
> For example,
> Atheros BT will send wrapped HCI packets from their HSU BT adapters, so they
> need to see "ath3000" rather than "bluetooth" to load a kernel hci protocol
> module for the device.
> As we can see, in the i2c/spi world, there is only "type" field filling w/ chip name,
> not 2 fields - "type" filled w/ generic type and "id" filled w/ chip name.
> Userspace can figure the generic "type" from the un-generic chip name like
> "type".
> I just wonder will there be issues caused by following this design?

Ying has suggested me to include all of the HID/CIDs as a list into board_info.
If OF need this feature, I'll split type into a type and an "ID" list.
The module_alias file can export all of the IDs and the device name can be the "type:index".
I can make the modifications on this if you think this is better.

> > > Shall we change the uart_bus to the tty_bus, then introduce tty_host
> > > /
> > tty_target for the bus?
> >
> > We have a tty class - is that not sufficient ?
> 
> As I mentioned in the previous mail, I'll keep the current naming rule until I see
> some objections strong enough.

This statement is confusing in English, let me clarify this.
If the reasons for the uart_bus in the previous email are not correct, I'll change everything named as uart_xxx to tty_xxx, then the tty_bus is probably not needed, and I can use tty class after the decision.

Best regards
-Lv
