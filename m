From: Alan Cox <alan@linux.intel.com>
Subject: Re: [RFC PATCH v3 1/4] UART: Add UART subsystem as a bus.
Date: Thu, 6 Dec 2012 13:40:20 +0000
Message-ID: <20121206134020.0747af0f@bob.linux.org.uk>
References: <cover.1354505471.git.lv.zheng@intel.com>
	<cover.1354785372.git.lv.zheng@intel.com>
	<c561ccd12ef845a7f30f26dfb706bb569e7244a7.1354785372.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <c561ccd12ef845a7f30f26dfb706bb569e7244a7.1354785372.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: Len Brown <len.brown@intel.com>, Rafael J Wysocki <rafael.j.wysocki@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-acpi@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

> enumerated and userspace can obtain the hotplug event of the UART
> target devices. Linux kernel is lack of an overall enumeration
> mechanism for UART target devices.

ls /sys/class/tty/

> In order to send uevent, a device need to be a class device or a bus
> device. This patch introduces a bus_type subsystem to manage the new

I still don't see why the existing tty class interfaces cannot be used,
the hints from ACPI (or anywhere else) cannot be attached as properties
to the tty driver and device sysfs

Alan
