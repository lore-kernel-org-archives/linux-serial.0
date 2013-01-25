From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v5 1/2] TTY: Add TTY slave enumeration support
Date: Fri, 25 Jan 2013 13:41:21 -0800
Message-ID: <20130125214121.GA30924@kroah.com>
References: <cover.1354505471.git.lv.zheng@intel.com>
 <cover.1359022955.git.lv.zheng@intel.com>
 <12848b50e1096dc11a193694ee248d51d45ce093.1359022955.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:38226 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750887Ab3AYVl0 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 25 Jan 2013 16:41:26 -0500
Received: by mail-pa0-f42.google.com with SMTP id rl6so497702pac.1
        for <linux-serial@vger.kernel.org>; Fri, 25 Jan 2013 13:41:26 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <12848b50e1096dc11a193694ee248d51d45ce093.1359022955.git.lv.zheng@intel.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: Alan Cox <alan@linux.intel.com>, Rafael J Wysocki <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-acpi@vger.kernel.org, linux-serial@vger.kernel.org

On Thu, Jan 24, 2013 at 06:30:21PM +0800, Lv Zheng wrote:
> In the recent ACPI 5.0 specification updates, firmwares are provided the
> possibilities to enumerate the UART slave devices known to the platform
> vendors.
> There are the needs in Linux to utilize the benefits:
> 1. hotplug uevent
> 2. serial configuration
> Currently, only serial cards on the specific bus (ex. PCMCIA) can be
> enumerated and userspace can obtain the hotplug event of the UART target
> devices. Linux kernel is lack of an overall enumeration mechanism for
> UART slave devices.

Huh?  That's flat out not true, otherwise how would userspace be
creating the proper /dev/tty* nodes for all tty devices?

> In order to send uevent, a device need to be a class device or a bus
> device. This patch introduces a tty_enum bus since the enumerated slave
> devices are expected to be physical devices.

Again, tty devices are already class devices, and they send out uevents.
You can see this today by watching the uevent stream using a tool like
'udevadmin monitor'.

> When the UART slave devices are created, userspace uevent rules can
> pass the creation details to the userspace driver managers
> (ex. hciattach), then the device managers can read hardware IDs and the
> serial configurations from the exported device attributes to match and
> configure a userspace TTY device driver.

What?  We do that today, no kernel changes needed.

> The created slave devices will be automatically unregistered when the
> associated TTY ports are destructed.

Again, this happens today.

Or am I missing something big and major here?  How have people been
seeing and configuring their tty devices for the last 8+ years or so
since the 2.6.0 kernel was released with uevent support for tty devices?

lost,

greg k-h
