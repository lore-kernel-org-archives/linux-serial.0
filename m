From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [RFC PATCH 1/3] UART: Add UART subsystem as a bus.
Date: Thu, 6 Dec 2012 07:36:35 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E88BD70E6@SHSMSX101.ccr.corp.intel.com>
References: <cover.1354505471.git.lv.zheng@intel.com>
	<6d5fc2e0799c12554aa8acdb2d7782ba8643902b.1354505472.git.lv.zheng@intel.com>
	<20121204185404.GQ3117@intel.com>	<20121204195030.238d1b71@bob.linux.org.uk>
	<20121205062015.GR3117@intel.com>
 <20121205094343.09d653c5@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20121205094343.09d653c5@pyramind.ukuu.org.uk>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Alan Cox <alan@linux.intel.com>, "Brown, Len" <len.brown@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

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

Hi, Mika

How is this handled in the i2c?
I think for OF, type can be filled as "bluetooth", "ups" and etc.
But for ACPI, the type field of the i2c_board_info is filled as hid in your patches.
Is this right?

Maybe I just need to add struct acpi_dev_node to the uart_board_info and let OF guys add of_node to it.
What's your opinion?

Best regards
-Lv
