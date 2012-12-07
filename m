From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [RFC PATCH v3 1/4] UART: Add UART subsystem as a bus.
Date: Fri, 7 Dec 2012 10:22:13 +0000
Message-ID: <20121207102213.07d93e1a@pyramind.ukuu.org.uk>
References: <cover.1354505471.git.lv.zheng@intel.com>
	<cover.1354785372.git.lv.zheng@intel.com>
	<c561ccd12ef845a7f30f26dfb706bb569e7244a7.1354785372.git.lv.zheng@intel.com>
	<20121206134020.0747af0f@bob.linux.org.uk>
	<1AE640813FDE7649BE1B193DEA596E88BD7485@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E88BD7485@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: Alan Cox <alan@linux.intel.com>, "Brown, Len" <len.brown@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "H. Peter Anvin (hpa@linux.intel.com)" <hpa@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

> > ls /sys/class/tty/
> 
> I'm searching for a target "physical" device while the "tty device" looks more like a "functional" device.

We don't currently properly link that up - but we should. It does however
provide the place to attach information like modem lines and intended use.

> If this rule is strictly obeyed by all of the subsystems, then:
> 1. the hardware PM can be added to the physical devices

To get the heirarchy you need to the tty to be in the PCI bus or other
bus where it actually sits ? Consider an ACPI enumerated port whose
address space is behind a PCI bridge.

> 1. if a bus offered PM support, it should appear in the bus_type

Which would usually be the PCI bus (and an ACPI enumerated device behind
a PCI bus needs to go via PCI to keep all the PCI counts correct)

> If a device was handling hardware stuff including the PM, it should be a "physical device".
> If a device was offering communication means, it should be a "functional device".
> If a device was using the communication means, it should be a "filter device".

A tty is all three. We have the physical device (wires and pins), the
functional object (an open tty) and filters (line disciplines I guess).

> And I checked the PM implementation, most of the drivers will enable/disable the "HOST" side port clock there and only few of them will lower the required terminal lines to tell the target devices to enter a low power state.

Because generally that breaks stuff. For example if you lower the carrier
to some UPS devices they conclude the PC has been turned off. This leads
to highly undesirable behaviour. As a result it's generally been user
space that handles such details.

> So I was just thinking if the tty device was used as physical device in the community, it might be used as "host" side physical device, and my patch was trying to enable a "target" side physical device.
> 
> Adding driver support for such "target physical uart device" sounds a good idea. But I need an explicit approval for
adding the kernel resident driver.

Not entirely sure what you mean by kernel resident driver here.

As of 3.7 we have a 'tty_port' for every tty. Not every port corresponds
to an actual physical device (eg pty doesn't, nor do mux channels). We
could certainly keep a bus driver reference in the tty_port if it helps.
If NULL means "none/not set" we can also gradually make drivers set it
correctly.

At that point you would be able to find the underlying device from any
tty port, and you can find any tty_port from the tty as of 3.7.

