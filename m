From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [RFC PATCH 1/3] UART: Add UART subsystem as a bus.
Date: Fri, 7 Dec 2012 10:25:36 +0000
Message-ID: <20121207102536.7dda1b1b@pyramind.ukuu.org.uk>
References: <cover.1354505471.git.lv.zheng@intel.com>
	<6d5fc2e0799c12554aa8acdb2d7782ba8643902b.1354505472.git.lv.zheng@intel.com>
	<20121204185404.GQ3117@intel.com>
	<20121204195030.238d1b71@bob.linux.org.uk>
	<20121205062015.GR3117@intel.com>
	<20121205094343.09d653c5@pyramind.ukuu.org.uk>
	<1AE640813FDE7649BE1B193DEA596E88BD6C94@SHSMSX101.ccr.corp.intel.com>
	<20121206135341.148b325e@pyramind.ukuu.org.uk>
	<1AE640813FDE7649BE1B193DEA596E88BD756A@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:56178 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755923Ab2LGKUS (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 7 Dec 2012 05:20:18 -0500
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E88BD756A@SHSMSX101.ccr.corp.intel.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Alan Cox <alan@linux.intel.com>, "Brown, Len" <len.brown@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "Huang, Ying" <ying.huang@intel.com>

On Fri, 7 Dec 2012 04:54:40 +0000
"Zheng, Lv" <lv.zheng@intel.com> wrote:

> > > > We just need a set of type names for the sysfs node I think
> > > > "bluetooth", "ups", "loconet", "serial", "modem", "cir" etc...
> > >
> > > Is it a good idea to introduce uart_device driver in the kernel to fill a new
> > 'ldisc' member in the uart_device or to load ldisc by default for the
> > corresponding tty_port?
> > 
> > No but it can provide information to help user space. In many cases the
> > decision isn't about a line discipline but about automatically setting permissions
> > or linking ports to the right driver.
> > 
> > The hints need to be generic - they can come from open firmware, from pci
> > identifiers, from ACPI and so on.
> 
> Userspace need to know more than a simple type name to match the driver.

It's just an enumeration - and unlike numbers names don't usually collide
or need hard management

> For example,
> Atheros BT will send wrapped HCI packets from their HSU BT adapters, so they need to see "ath3000" rather than "bluetooth" to load a kernel hci protocol module for the device.

Fine so we could use "bluetooth/atheros" or similar. Easily dealt with

Alan
