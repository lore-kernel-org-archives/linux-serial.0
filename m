From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH v5 1/2] TTY: Add TTY slave enumeration support
Date: Sat, 26 Jan 2013 03:04:33 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E88BF41C7@SHSMSX101.ccr.corp.intel.com>
References: <cover.1354505471.git.lv.zheng@intel.com>
 <cover.1359022955.git.lv.zheng@intel.com>
 <12848b50e1096dc11a193694ee248d51d45ce093.1359022955.git.lv.zheng@intel.com>
 <20130125214121.GA30924@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:62267 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751228Ab3AZDEi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 25 Jan 2013 22:04:38 -0500
In-Reply-To: <20130125214121.GA30924@kroah.com>
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alan Cox <alan@linux.intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Brown, Len" <len.brown@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "Jiri Slaby (jslaby@suse.cz)" <jslaby@suse.cz>, "Heikki Krogerus (heikki.krogerus@linux.intel.com)" <heikki.krogerus@linux.intel.com>

Thanks for your suggestions.
All your concerns are against the needs of creating such slave devices.
Let me delete all of the others and reply once.

> > In order to send uevent, a device need to be a class device or a bus
> > device. This patch introduces a tty_enum bus since the enumerated
> > slave devices are expected to be physical devices.
> 
> Again, tty devices are already class devices, and they send out uevents.
> You can see this today by watching the uevent stream using a tool like
> 'udevadmin monitor'.

Please consider the following real scenario when a ttyS0 driver module gets loaded at kernel runtime:
1. the tty controller driver creates ttyS0
2. user gets uevent notified and doesn't know how to use this tty device
3. a slave ACPI node under the ttyS0 gets enumerated and attributes gets appended
4. user need to do user space effort to regenerate the uevent to get a Bluetooth hci user driver matched

If the step 3 can be put ahead of step 2, there might not be weakness without this enhancement.
Considering a more complex scenario:
There are two or more target devices under the ttyS0 and can be selected by some external GPIOs.
Actually, BIOS will do this putting many test devices under the ttyS0.
The step 3 then can never be put ahead of step 2.
(It might be implemented using some exist kernel mechanisms like the SCSI contribute container devices...)

With this patch:
1. a tty controller driver creates ttyS0
2. user gets the uevent notified and need to do nothing
3. a slave device BTH0:00 gets enumerated and created
4. user gets the uevent notified and uses the attributes exported by this device to do a proper Bluetooth hci user driver matching
The latter is more generic which is equivalent to the exist PCMCIA Bluetooth hci matching. And I just think we could get more benefits when we do PM enabling for such uart slave devices.
And I think this patch would not change any currently used user space behavior.
But the user space behavior can be unified if such slave device nodes are there.

Best regards
-Lv

