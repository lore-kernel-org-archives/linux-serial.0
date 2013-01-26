From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v5 1/2] TTY: Add TTY slave enumeration support
Date: Fri, 25 Jan 2013 19:42:32 -0800
Message-ID: <20130126034232.GB5066@kroah.com>
References: <cover.1354505471.git.lv.zheng@intel.com>
 <cover.1359022955.git.lv.zheng@intel.com>
 <12848b50e1096dc11a193694ee248d51d45ce093.1359022955.git.lv.zheng@intel.com>
 <20130125214121.GA30924@kroah.com>
 <1AE640813FDE7649BE1B193DEA596E88BF41C7@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:59882 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755036Ab3AZDky (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 25 Jan 2013 22:40:54 -0500
Content-Disposition: inline
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E88BF41C7@SHSMSX101.ccr.corp.intel.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: Alan Cox <alan@linux.intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Brown, Len" <len.brown@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "Jiri Slaby (jslaby@suse.cz)" <jslaby@suse.cz>, "Heikki Krogerus (heikki.krogerus@linux.intel.com)" <heikki.krogerus@linux.intel.com>

On Sat, Jan 26, 2013 at 03:04:33AM +0000, Zheng, Lv wrote:
> Thanks for your suggestions.
> All your concerns are against the needs of creating such slave devices.
> Let me delete all of the others and reply once.
> 
> > > In order to send uevent, a device need to be a class device or a bus
> > > device. This patch introduces a tty_enum bus since the enumerated
> > > slave devices are expected to be physical devices.
> > 
> > Again, tty devices are already class devices, and they send out uevents.
> > You can see this today by watching the uevent stream using a tool like
> > 'udevadmin monitor'.
> 
> Please consider the following real scenario when a ttyS0 driver module gets loaded at kernel runtime:
> 1. the tty controller driver creates ttyS0

Fine.

> 2. user gets uevent notified and doesn't know how to use this tty device

Of course, that's normal.

> 3. a slave ACPI node under the ttyS0 gets enumerated and attributes gets appended

How will that happen?  Who causes that to happen?  When would that
happen?

> 4. user need to do user space effort to regenerate the uevent to get a Bluetooth hci user driver matched

Whatever caused step 3 to happen can send a new uevent saying something
has changed.  That's a one line patch.

> If the step 3 can be put ahead of step 2, there might not be weakness without this enhancement.

Yes.

> Considering a more complex scenario:
> There are two or more target devices under the ttyS0 and can be selected by some external GPIOs.
> Actually, BIOS will do this putting many test devices under the ttyS0.
> The step 3 then can never be put ahead of step 2.
> (It might be implemented using some exist kernel mechanisms like the SCSI contribute container devices...)

No, don't look at SCSI for sysfs ideas or driver core usage, it's a
mess and is wrong in places.  Look at how USB and PCI do it if you are
curious how to implement a bus.

But again, this isn't a bus, this is a TTY class, and again, we already
have one, so use it, don't create another one to stack on top of it,
that's crazy.

greg k-h
