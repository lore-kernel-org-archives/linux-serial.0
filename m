From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [RFC PATCH 1/3] UART: Add UART subsystem as a bus.
Date: Thu, 6 Dec 2012 13:53:41 +0000
Message-ID: <20121206135341.148b325e@pyramind.ukuu.org.uk>
References: <cover.1354505471.git.lv.zheng@intel.com>
	<6d5fc2e0799c12554aa8acdb2d7782ba8643902b.1354505472.git.lv.zheng@intel.com>
	<20121204185404.GQ3117@intel.com>
	<20121204195030.238d1b71@bob.linux.org.uk>
	<20121205062015.GR3117@intel.com>
	<20121205094343.09d653c5@pyramind.ukuu.org.uk>
	<1AE640813FDE7649BE1B193DEA596E88BD6C94@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:54879 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755026Ab2LFNs2 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 6 Dec 2012 08:48:28 -0500
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E88BD6C94@SHSMSX101.ccr.corp.intel.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Alan Cox <alan@linux.intel.com>, "Brown, Len" <len.brown@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Mathias Nyman <mathias.nyman@linux.intel.com>, "Huang, Ying" <ying.huang@intel.com>

> > We just need a set of type names for the sysfs node I think "bluetooth", "ups",
> > "loconet", "serial", "modem", "cir" etc...
> 
> Is it a good idea to introduce uart_device driver in the kernel to fill a new 'ldisc' member in the uart_device or to load ldisc by default for the corresponding tty_port?

No but it can provide information to help user space. In many cases the
decision isn't about a line discipline but about automatically setting
permissions or linking ports to the right driver.

The hints need to be generic - they can come from open firmware, from pci
identifiers, from ACPI and so on.

> Shall we change the uart_bus to the tty_bus, then introduce tty_host / tty_target for the bus?

We have a tty class - is that not sufficient ?

Alan
