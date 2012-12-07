From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [RFC PATCH 1/3] UART: Add UART subsystem as a bus.
Date: Fri, 7 Dec 2012 04:54:40 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E88BD756A@SHSMSX101.ccr.corp.intel.com>
References: <cover.1354505471.git.lv.zheng@intel.com>
	<6d5fc2e0799c12554aa8acdb2d7782ba8643902b.1354505472.git.lv.zheng@intel.com>
	<20121204185404.GQ3117@intel.com>	<20121204195030.238d1b71@bob.linux.org.uk>
	<20121205062015.GR3117@intel.com>
	<20121205094343.09d653c5@pyramind.ukuu.org.uk>
	<1AE640813FDE7649BE1B193DEA596E88BD6C94@SHSMSX101.ccr.corp.intel.com>
 <20121206135341.148b325e@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20121206135341.148b325e@pyramind.ukuu.org.uk>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Alan Cox <alan@linux.intel.com>, "Brown, Len" <len.brown@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "Huang, Ying" <ying.huang@intel.com>
List-Id: linux-serial@vger.kernel.org

> > > We just need a set of type names for the sysfs node I think
> > > "bluetooth", "ups", "loconet", "serial", "modem", "cir" etc...
> >
> > Is it a good idea to introduce uart_device driver in the kernel to fill a new
> 'ldisc' member in the uart_device or to load ldisc by default for the
> corresponding tty_port?
> 
> No but it can provide information to help user space. In many cases the
> decision isn't about a line discipline but about automatically setting permissions
> or linking ports to the right driver.
> 
> The hints need to be generic - they can come from open firmware, from pci
> identifiers, from ACPI and so on.

Userspace need to know more than a simple type name to match the driver.
For example,
Atheros BT will send wrapped HCI packets from their HSU BT adapters, so they need to see "ath3000" rather than "bluetooth" to load a kernel hci protocol module for the device.
As we can see, in the i2c/spi world, there is only "type" field filling w/ chip name, not 2 fields - "type" filled w/ generic type and "id" filled w/ chip name.
Userspace can figure the generic "type" from the un-generic chip name like "type".
I just wonder will there be issues caused by following this design?

> > Shall we change the uart_bus to the tty_bus, then introduce tty_host /
> tty_target for the bus?
> 
> We have a tty class - is that not sufficient ?

As I mentioned in the previous mail, I'll keep the current naming rule until I see some objections strong enough.

-Lv
