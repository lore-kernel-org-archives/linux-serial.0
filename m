From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: 2.6.24: Serial disabled in BIOS but serial modules still
	loaded (probably PnP related)
Date: Tue, 27 Nov 2007 16:59:06 +0800
Message-ID: <1196153946.5385.4.camel@sli10-conroe.sh.intel.com>
References: <fa.P01QcmUf2f3DN4etI8KJYFdaLnE@ifi.uio.no>
	 <4749C15C.6020805@shaw.ca>  <200711252301.34503.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:21161 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751066AbXK0I7P (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 27 Nov 2007 03:59:15 -0500
In-Reply-To: <200711252301.34503.arvidjaar@mail.ru>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: Robert Hancock <hancockr@shaw.ca>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Mon, 2007-11-26 at 04:01 +0800, Andrey Borzenkov wrote:
> On Sunday 25 November 2007, Robert Hancock wrote:
> > Andrey Borzenkov wrote:
> > > I have no COM port on notebook (without port replicator which I do not have)
> > > so COM is disabled in BIOS. No ttyS* is detected during boot (and no device
> > > created) but I just noticed that serial modules are still loaded. Well, this
> > > partially defeats the purpose of disabling COM port - the intention was to
> > > free resources by *not* loading unneeded modules ...
> > > 
> > > This may have something to do with (ACPI) PnP which apparently believes COM is alive.
> > > Notebook is Toshiba Portege 4000.
> > 
> > Probably a BIOS bug. It still lists the port in PnP data even though the 
> > hardware is disabled, so the kernel still tries to load the serial 
> > driver for it, which finds there's no port there.
> > 
> 
> Here is what we get from _STA:
> 
> [ 1689.988245] HID=PNP0501 flags=0d
> 
> If I read specs correctly, if bit 1 is cleared it means, device is not able
> to access its hardware resources, so it makes no sense to even try to
> load driver for it.
> 
> And of course it makes PnP output completely bogus:
> 
> 00:09 PNP0501 16550A-compatible serial port
>     state = active
>     allocated resources:
>         io 0x3f8-0x3ff
>         irq 5
>  
> So two questions:
> 
> 1. why device got enabled when ACPI explicitly stated it cannot be?
> 2. can we get information about _STA result in user space so we do not try
> to autoload driver for device that can't work?
0xd means present, disabled. A disabled PNP device can be enabled, ACPI
doesn't say it can't be. When the driver is loaded, it will enabled the
device. If BIOS wants to disable the device, it should make the device
non-present.

Thanks,
Shaohua
