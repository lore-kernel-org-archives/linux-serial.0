From: Alan Cox <alan@linux.intel.com>
Subject: Re: [RFC PATCH 1/3] UART: Add UART subsystem as a bus.
Date: Tue, 4 Dec 2012 19:50:30 +0000
Message-ID: <20121204195030.238d1b71@bob.linux.org.uk>
References: <cover.1354505471.git.lv.zheng@intel.com>
	<6d5fc2e0799c12554aa8acdb2d7782ba8643902b.1354505472.git.lv.zheng@intel.com>
	<20121204185404.GQ3117@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:53810 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752101Ab2LDTr5 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 4 Dec 2012 14:47:57 -0500
In-Reply-To: <20121204185404.GQ3117@intel.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Len Brown <len.brown@intel.com>, Rafael J Wysocki <rafael.j.wysocki@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-acpi@vger.kernel.org, linux-serial@vger.kernel.org

> What if instead of exporting these to userspace we just set the
> defaults based on the UartSerialBus() value? This way the user only
> needs to find the right tty to pass to hciattach.

We should also make sure the types are generic because there are lots
of platforms that can use DT to describe devices usefully this way, and
there are types not in the ACPI spec (eg Loconet) that some apps could
do with finding.

> And if we have enumerated the UART controller from ACPI (it is
> probably attached to the platform bus) we can find the tty device it
> exports like:

The property should not be in any ACPI specific form or space - just
attach it directly to the tty from ACPI, DT, driver internal knowledge,
PCI id, whatever

Alan
