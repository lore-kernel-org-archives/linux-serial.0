From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [RFC PATCH 1/3] UART: Add UART subsystem as a bus.
Date: Wed, 5 Dec 2012 03:49:23 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E88BD66D3@SHSMSX101.ccr.corp.intel.com>
References: <cover.1354505471.git.lv.zheng@intel.com>
 <6d5fc2e0799c12554aa8acdb2d7782ba8643902b.1354505472.git.lv.zheng@intel.com>
 <20121204185404.GQ3117@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20121204185404.GQ3117@intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: "Brown, Len" <len.brown@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <alan@linux.intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

> On Mon, Dec 03, 2012 at 11:39:59AM +0800, Lv Zheng wrote:
> > kobject attribute files:
> > # cat /sys/bus/uart/devices/INTF001:00/modalias
> > uart:INTF001:00
> > # cat /sys/bus/uart/devices/INTF001:00/tty_dev
> > ttyS0
> > # cat /sys/bus/uart/devices/INTF001:00/tty_attrs
> > 115200 8N0 HW
> > # cat /sys/bus/uart/devices/INTF001:00/modem_lines
> > LE:RTS,CTS,
> 
> What if instead of exporting these to userspace we just set the defaults based
> on the UartSerialBus() value? This way the user only needs to find the right tty
> to pass to hciattach.
> 
> > kobject sysfs links:
> > # ls -l /sys/bus/uart/devices
> > INTF001:00 -> ../../../devices/platform/INTF000:00/INTF001:00
> > # ls -l /sys/devices/platform/INTF000:00/INTF001:00
> > subsystem -> ../../../../bus/uart
> > host_node -> ../tty/ttyS0
> > # ls -l /sys/devices/platform/INTF000:00/tty/ttyS0
> > target_node -> ../../INTF001:00
> 
> And if we have enumerated the UART controller from ACPI (it is probably
> attached to the platform bus) we can find the tty device it exports like:
> 
> /sys/bus/platform/devices/INTF000:00/tty/ttyS1/dev
> 
> Only thing that is missing then is the type of the connected device. That can be
> extracted by following the firmware_node symlink:
> 
> # ls /sys/bus/platform/devices/INTF000\:00/firmware_node/
> INTF001:00
> ...
> 
> # cat
> /sys/bus/platform/devices/INTF000\:00/firmware_node/INTF001:00/hid
> INTF001
> 
> This ACPI ID then can be used to find out what device it is.
> 
> Well, this is probably not the simplest solution :-) I'm just trying to understand
> why we need to add a new bus type if only thing it adds is the sysfs files.

In our team, we've been discussing this solution like your suggestion for some times.
ACPI UART enumeration can be done in this way without kernel modifications.

IMO:
1. tty_device is current used as "host" side device, you can find .pm support in most of the serial drivers.
  They are always the codes turning off/on the clock of the host controller.
  If we want to support PM for a target device, there is no such node in the kernel device hierarchy.
2. firmware_node is based on the "likely deprecated" acpi_device solution, I need to find another one. Maybe this is still a shadow device.
  Like dmi-id device, a shadow device exporting attributes and generating uevents for the user space drivers may be helpful.
  It would be better if the PM support of the target devices can benefit from the existence of the shadow uart target devices.

> > +/**
> > + * uart_unregister_device - unregister a UART device
> > + * @device: value returned from uart_register_device()
> > + *
> > + * Reverse effect of uart_register_device().
> > + */
> > +void uart_unregister_device(struct uart_device *udev) {
> > +	if (udev->adap)
> > +		klist_del(&udev->klist_parent);
> > +	sysfs_remove_link(&udev->dev.kobj, "host_node");
> > +	if (udev->tty)
> > +		sysfs_remove_link(&udev->tty->kobj, "target_node");
> > +	device_unregister(&udev->dev);
> > +}
> > +EXPORT_SYMBOL_GPL(uart_unreigster_device);
> 
> Typo in the function name.

Fixed...

Thanks and best regards/Lv Zheng
