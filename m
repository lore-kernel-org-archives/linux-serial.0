From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [RFC PATCH v3 1/4] UART: Add UART subsystem as a bus.
Date: Fri, 7 Dec 2012 03:52:03 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E88BD7485@SHSMSX101.ccr.corp.intel.com>
References: <cover.1354505471.git.lv.zheng@intel.com>
	<cover.1354785372.git.lv.zheng@intel.com>
	<c561ccd12ef845a7f30f26dfb706bb569e7244a7.1354785372.git.lv.zheng@intel.com>
 <20121206134020.0747af0f@bob.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20121206134020.0747af0f@bob.linux.org.uk>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>
Cc: "Brown, Len" <len.brown@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "H. Peter Anvin (hpa@linux.intel.com)" <hpa@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

> > enumerated and userspace can obtain the hotplug event of the UART
> > target devices. Linux kernel is lack of an overall enumeration
> > mechanism for UART target devices.
> 
> ls /sys/class/tty/

I'm searching for a target "physical" device while the "tty device" looks more like a "functional" device.

IMO, an ideal driver model is:
Creating a strict IO topology for all of the physical buses w/ physical devices created within this hierarchy, then make the abstract things "class devices", including the "functional devices" and the "filter devices".
The examples of the "physical devices": platform device, uart_device, i2c_client, spi_device
The examples of the "functional devices": tty device, i2c_adapter, spi_master
The examples of the "filter devices": ppp device

If this rule is strictly obeyed by all of the subsystems, then:
1. the hardware PM can be added to the physical devices
2. the functional devices will inc/dec the PM reference count for the physical devices <- this can help to add request based runtime PM
3. the other filter devices/drivers can call the APIs provided by the functional devices, some of them may affect the PM ref count.
Implementing OS guided power management might be simpler:
1. if a bus offered PM support, it should appear in the bus_type
2. if a platform offered PM support, it should appear as PM_domain
Currently, Linux allows enabling of PM support for device_type, if things are cleaned up, the use of device_type PM can be reduced.

If a device was handling hardware stuff including the PM, it should be a "physical device".
If a device was offering communication means, it should be a "functional device".
If a device was using the communication means, it should be a "filter device".
So how could a tty device be a physical device? If we enable PM for it, dpm_list order will be crushed, issues might occur on system suspending/resuming.

> > In order to send uevent, a device need to be a class device or a bus
> > device. This patch introduces a bus_type subsystem to manage the new
> 
> I still don't see why the existing tty class interfaces cannot be used, the hints
> from ACPI (or anywhere else) cannot be attached as properties to the tty driver
> and device sysfs

I checked the PM call chain, then found the followings:

On system suspending:
  adapter.suspend -> for_each_port(uart_suspend_port) -> uart_change_pm(3) -> uart_ops->pm -> uart_port->pm
On system resuming:
  adapter.resume -> for_each_port(uart_resume_port) -> uart_change_pm(0) -> uart_ops->pm -> uart_port->pm
Where the adapter could be platform devices.

On tty file opening:
 uart_open -> uart_change_pm(0) -> uart_ops->pm -> uart_port->pm
On tty file closing:
 uart_close -> uart_change_pm(3) -> uart_ops->pm -> uart_port->pm

And I checked the PM implementation, most of the drivers will enable/disable the "HOST" side port clock there and only few of them will lower the required terminal lines to tell the target devices to enter a low power state.
So I was just thinking if the tty device was used as physical device in the community, it might be used as "host" side physical device, and my patch was trying to enable a "target" side physical device.

Adding driver support for such "target physical uart device" sounds a good idea. But I need an explicit approval for adding the kernel resident driver.

Best regards
-Lv

